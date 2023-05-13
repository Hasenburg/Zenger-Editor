//
//  MapFunctions.swift
//  Zenger Editor
//
//  Created by Sebastian Haslberger on 09.02.23.
//

import SwiftUI
import MapKit
import FirebaseFirestore

extension MapView {
    
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        
        addLocations(map: uiView)
        
        setCenter(map: uiView)
        
        showRoutes(map: uiView)
        
        save_new_locations()
    }
    
    func addLocations(map: MKMapView) {
        let annotations = map.annotations
        map.removeAnnotations(annotations)
        for x in dm.alle_staende.locations.indices {
            addLocation(n: x, map: map, category: x == 0 ? "Jagdhütte" : "Stände")
        }
    }
    
    func addLocation(n: Int, map: MKMapView, category: String) {
        let stand = MKPointAnnotation()
        stand.title = "\(n)"
        stand.subtitle = "\(category)"
        stand.coordinate = CLLocationCoordinate2D(latitude: dm.alle_staende.locations[n].latitude, longitude: dm.alle_staende.locations[n].longitude)
        map.addAnnotation(stand)
    }
    
    func save_new_locations () {
        Task {
            if dm.save_button_pressed {
                
                for idx in changed_staende {
                    let arr_idx = Int(idx.title!!)!
                    print("Stand \(arr_idx)")
                    print("Before \(dm.alle_staende.locations[arr_idx])")
                    
                    let GeoCoord = GeoPoint(latitude: idx.coordinate.latitude, longitude: idx.coordinate.longitude)
                    dm.alle_staende.locations[arr_idx] = GeoCoord
                    print("After \(GeoCoord)")
                }
                dm.save_location_changes()
                dm.save_button_pressed.toggle()
                changed_staende.removeAll()
            }
        }
    }
    
    @MainActor
    func setCenter(map: MKMapView) {
        if dm.map_set_center {
            map.setRegion(MKCoordinateRegion(center: self.coordinate, span: self.span), animated: true)
            dm.map_set_center = false
        }
    }
    
    func showRoutes(map:MKMapView) {
        for idx in dm.routes_of_actual_year.routes.indices {
            if dm.all_routes_views[idx].visible {
                showSingleRoute(map: map, route: dm.routes_of_actual_year.routes[idx], idx: idx)
            } else if !dm.all_routes_views[idx].visible {
                for overlay_idx in map.overlays {
                    guard let _ = overlay_idx.title else { return }
                    if overlay_idx.title!! == String(idx) {
                        map.removeOverlay(overlay_idx)
                    }
                }
            }
        }
    }
    
    func showSingleRoute(map: MKMapView, route: Route, idx: Int) {
        
        
        //Get locations
        var coordinates: [CLLocationCoordinate2D] = []
        for x in route.route_numbers {
            coordinates.append(CLLocationCoordinate2D(latitude: dm.alle_staende.locations[x].latitude, longitude:dm.alle_staende.locations[x].longitude))
            
        }
        
        //Add Polylines
        let overlay = MKPolyline(coordinates: coordinates, count: coordinates.count)
        overlay.subtitle = "Route"
        overlay.title = "\(idx)"
        overlay.color = color_scheme_route[idx].uicolor
        map.addOverlay(overlay)
        
        if route.route_numbers.count != 0 {
            print("idx: \(idx),route_count: \(route.route_numbers.count)")
            
            
            
            //Add Circle for last Route
            let last = route.route_numbers.last
            let circle = CLLocationCoordinate2D(latitude: dm.alle_staende.locations[last!].latitude, longitude: dm.alle_staende.locations[last!].longitude)
            let c_overlay = MKCircle(center: circle, radius: 60)
            c_overlay.subtitle = "Circle"
            c_overlay.title = "\(idx)"
            c_overlay.color = color_scheme_route[idx].uicolor
            map.addOverlay(c_overlay)
            
            
        }
    }
    
    func addStandToRoute(stand_nr: String) {
        for idx in dm.routes_of_actual_year.routes.indices {
            if dm.all_routes_views[idx].edit_mode {
                if dm.routes_of_actual_year.routes[idx].route_numbers.last != Int(stand_nr) {
                    dm.routes_of_actual_year.routes[idx].route_numbers.append(Int(stand_nr)!)
                    dm.update_all_routes()
                } else {
                    dm.routes_of_actual_year.routes[idx].route_numbers.removeLast()
                    dm.update_all_routes()
                }
            }
        }
        
    }
}

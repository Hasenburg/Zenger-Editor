//
//  CoordinatorMapView.swift
//  NewMap
//
//  Created by Sebastian Haslberger on 07.02.23.
//

import SwiftUI
import MapKit


extension MapView {
    class Coordinator: NSObject, MKMapViewDelegate {
        
        var parent : MapView
        
        
        @Binding var changes_made: Bool
        
        init(_parent: MapView, changes_made: Binding<Bool>) {
            parent = _parent
            _changes_made = changes_made
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            
            if let overlay_ = overlay as? MKPolyline {
                let renderer = MKPolylineRenderer(overlay: overlay)
                
                renderer.strokeColor = overlay_.color
                renderer.lineWidth = 5
                
                return renderer
                
            } else if let overlay_ = overlay as? MKCircle {
                let renderer = MKCircleRenderer(overlay: overlay)
                renderer.fillColor = overlay_.color
                
                
                return renderer
            } else {
                return MKOverlayRenderer()
            }
        }
        
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            
            view.isDraggable = parent.dm.annotation_is_draggable
            
            parent.addStandToRoute(stand_nr: (view.annotation?.title!!)!)
            
            
        }
        
        @MainActor
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
            
            if newState == MKAnnotationView.DragState.ending {
                changes_made = true
                
                parent.changed_staende.append(view.annotation!)
                
            }
            
            if newState == MKAnnotationView.DragState.dragging {
            }
            
            if newState == MKAnnotationView.DragState.starting {
                view.dragState = .dragging
            }
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customView")
            
            annotationView.canShowCallout = true
            
            annotationImage(annotationView: annotationView, annotation: annotation)
            
            return annotationView
        }
        
        
        
        func annotationImage (annotationView: MKAnnotationView, annotation: MKAnnotation) {
            if annotation.subtitle == "Stände" {
                let circle = UIImage(systemName: "\(annotation.title!!).circle")!.withTintColor(.white)
                let size = CGSize(width: 25, height: 25)
                annotationView.image = UIGraphicsImageRenderer(size: size).image(actions: { _ in
                    circle.draw(in: CGRect(origin: .zero, size: size))
                    
                })
            }
            
            if annotation.subtitle == "Jagdhütte" {
                let house = UIImage(systemName: "house")!.withTintColor(.white)
                let size = CGSize(width: 25, height: 20)
                annotationView.image = UIGraphicsImageRenderer(size: size).image(actions: { _ in
                    house.draw(in: CGRect(origin: .zero, size: size))
                    
                })
            }
        }
    }
}

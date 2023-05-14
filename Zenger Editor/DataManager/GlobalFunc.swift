//
//  TestData.swift
//  NewMap
//
//  Created by Sebastian Haslberger on 04.02.23.
//

import SwiftUI
import MapKit

extension DataManager {
    
    
    func get_current_year() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: Date())
    }
    
    func check_route_visibility() -> Color {
        var color: Color = .purple
        var visible: [Bool] = []
        
        let routes = self.all_routes_views
        for idx in routes.indices {
            if routes[idx].visible {
                visible.append(routes[idx].visible)
            }
        }
        
        if visible.count == 0 {
            color = .primary
        } else if visible.count == routes.count {
            color = .accentColor
        } else {
            color = .orange
        }
        
        return color
    }
    
    func toggle_visibility (on: Bool) {
        for idx in self.all_routes_views.indices {
            self.all_routes_views[idx].visible = on
        }
    }
    
    func toggle_expansion (on: Bool) {
        for idx in self.all_routes_views.indices {
            self.all_routes_views[idx].expanded = on
        }
    }
    
    func get_km (route_nr: Int) -> Double {
        var coordinates: [CLLocation] = []
        if self.alle_staende.locations.count > 40  {
            if routes_of_actual_year.routes[safe: route_nr] != nil {
                for x in routes_of_actual_year.routes[route_nr].route_numbers {
                    coordinates.append(CLLocation(latitude: self.alle_staende.locations[x].latitude, longitude:self.alle_staende.locations[x].longitude))
                }
            }
        }
        var distance: Double = 0
        for x in coordinates.indices {
            if x < coordinates.count-1 {
                distance += coordinates[x].distance(from: coordinates[x+1])
            }
        }
        return distance/1000
    }
    
    func get_all_rest_years(completionHandler: (String) -> Void) {
        let index = self.years.lastIndex(of: app_year)
        for idx in index!...self.years.count-1 {
            completionHandler(self.years[safe: idx]!)
        }
    }
	
	
	func check_treiber (route_nr: Int) -> String {
		var name = ""
		for idx in self.alle_treiber {
			if idx.route == route_nr {
				name = idx.treiber
			}
		}
		return name
	}
	
}


extension Collection where Indices.Iterator.Element == Index {
    public subscript(safe index: Index) -> Iterator.Element? {
        return (startIndex <= index && index < endIndex) ? self[index] : nil
    }
}



var Locations = [
    CLLocationCoordinate2D(latitude: 0, longitude: 0),
    CLLocationCoordinate2D(latitude: 48.286350, longitude: 11.752594),
    CLLocationCoordinate2D(latitude: 48.285030, longitude: 11.756457),
    CLLocationCoordinate2D(latitude: 48.285660, longitude: 11.760449),
    CLLocationCoordinate2D(latitude: 48.288375, longitude: 11.756384),
    CLLocationCoordinate2D(latitude: 48.282156, longitude: 11.756804),
    CLLocationCoordinate2D(latitude: 48.282291, longitude: 11.759722),
    CLLocationCoordinate2D(latitude: 48.283888, longitude: 11.763349),
    CLLocationCoordinate2D(latitude: 48.296440, longitude: 11.769589),
    CLLocationCoordinate2D(latitude: 48.283813, longitude: 11.766361),
    CLLocationCoordinate2D(latitude: 48.282745, longitude: 11.767006),
    CLLocationCoordinate2D(latitude: 48.281876, longitude: 11.769693),
    CLLocationCoordinate2D(latitude: 48.285313, longitude: 11.770928),
    CLLocationCoordinate2D(latitude: 48.282069, longitude: 11.771333),
    CLLocationCoordinate2D(latitude: 48.285064, longitude: 11.773408),
    CLLocationCoordinate2D(latitude: 48.287436, longitude: 11.772958),
    CLLocationCoordinate2D(latitude: 48.287954, longitude: 11.771348),
    CLLocationCoordinate2D(latitude: 48.289525, longitude: 11.772810),
    CLLocationCoordinate2D(latitude: 48.290832, longitude: 11.771648),
    CLLocationCoordinate2D(latitude: 48.283636, longitude: 11.773671),
    CLLocationCoordinate2D(latitude: 48.292861, longitude: 11.773709),
    CLLocationCoordinate2D(latitude: 48.284230, longitude: 11.758675),
    CLLocationCoordinate2D(latitude: 48.297040, longitude: 11.775138),
    CLLocationCoordinate2D(latitude: 48.298002, longitude: 11.775465),
    CLLocationCoordinate2D(latitude: 48.294852, longitude: 11.774368),
    CLLocationCoordinate2D(latitude: 48.292690, longitude: 11.771520),
    CLLocationCoordinate2D(latitude: 48.287850, longitude: 11.754731),
    CLLocationCoordinate2D(latitude: 48.299254, longitude: 11.774461),
    CLLocationCoordinate2D(latitude: 48.284187, longitude: 11.753743),
    CLLocationCoordinate2D(latitude: 48.294497, longitude: 11.766336),
    CLLocationCoordinate2D(latitude: 48.293562, longitude: 11.766357),
    CLLocationCoordinate2D(latitude: 48.292035, longitude: 11.765755),
    CLLocationCoordinate2D(latitude: 48.294161, longitude: 11.763869),
    CLLocationCoordinate2D(latitude: 48.293591, longitude: 11.761708),
    CLLocationCoordinate2D(latitude: 48.292360, longitude: 11.763438),
    CLLocationCoordinate2D(latitude: 48.291680, longitude: 11.763557),
    CLLocationCoordinate2D(latitude: 48.290670, longitude: 11.762457),
    CLLocationCoordinate2D(latitude: 48.289053, longitude: 11.765481),
    CLLocationCoordinate2D(latitude: 48.289864, longitude: 11.769767),
    CLLocationCoordinate2D(latitude: 48.295175, longitude: 11.764827),
    CLLocationCoordinate2D(latitude: 48.288745, longitude: 11.760020),
    CLLocationCoordinate2D(latitude: 48.288123, longitude: 11.760888),
    CLLocationCoordinate2D(latitude: 48.288417, longitude: 11.762843),
    CLLocationCoordinate2D(latitude: 48.287116, longitude: 11.762057),
    CLLocationCoordinate2D(latitude: 48.286426, longitude: 11.757369),
    CLLocationCoordinate2D(latitude: 48.286686, longitude: 11.765102),
    CLLocationCoordinate2D(latitude: 48.287328, longitude: 11.767133),
    CLLocationCoordinate2D(latitude: 48.279872, longitude: 11.758877),
    CLLocationCoordinate2D(latitude: 0, longitude: 0),
    CLLocationCoordinate2D(latitude: 0, longitude: 0),
    CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
]




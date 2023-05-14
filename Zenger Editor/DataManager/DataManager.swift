//
//  DataManager.swift
//  Zenger Editor
//
//  Created by Sebastian Haslberger on 11.03.23.
//

import SwiftUI
import MapKit
import FirebaseFirestore


class DataManager: ObservableObject {
	
    
    @Published var app_year: String = "1999"
	
	var years = ["2019", "2020", "2021", "2022", "2023", "2024", "2025", "2026", "2027", "2028", "2029", "2030", "2031", "2032", "2033", "2034", "2035", "2036", "2037", "2038", "2039", "2040", "2041", "2042", "2043", "2044", "2045", "2046", "2047", "2048", "2049", "2050"]
	
	
	@Published var jagdjahr = Jagdjahr(jahr: "1999", jagdstart: Timestamp(date: Date()), jagdende: Timestamp(date: Date()))
    
    @Published var alle_staende = Staende(jahr: "1999", locations: [])
    @Published var save_button_pressed = false
    
    @Published var annotation_is_draggable = false
    @Published var changed_annotations: [MKAnnotation] = []
    
    
	@Published var routes_of_actual_year: Routes = Routes(jahr: "1999", routes: []) {
		didSet {
			for _ in self.routes_of_actual_year.routes {
				self.all_routes_views.append(Route_Settings())
			}
		}
	}
	//@Published var all_routes: [Routes] = []
	@Published var all_routes_views = [Route_Settings(expanded: false, visible: false, edit_mode: false)]
	
	@Published var alle_treiber: [Treiber] = []
	
	@Published var map_set_center = false
	@Published var show_all_routes = false
	@Published var hide_all_routes = false
	@Published var update_routes = false
	
    
	
	init()  {
		self.routes_of_actual_year.jahr = get_current_year()
        app_year = get_current_year()
		
		Task (priority: .high, operation: {
			get_locations()
		})
        get_actual_route()
		get_all_actual_treiber()
		Task {
			get_jagdjahr()
		}
		
	}
	
	
	
	
	
}


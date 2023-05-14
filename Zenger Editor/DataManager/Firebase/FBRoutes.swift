//
//  FBRoutes.swift
//  Zenger Editor
//
//  Created by Sebastian Haslberger on 05.04.23.
//


import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import MapKit


extension DataManager {
	
	func get_actual_route() {
		let db = Firestore.firestore()
        
		db.collection("Routes").whereField("jahr", isEqualTo: self.app_year).addSnapshotListener { qrysnp, error in
			
			if let qrysnp = qrysnp {
				if let first = qrysnp.documents.first {
					do {
						self.routes_of_actual_year = try first.data(as: Routes.self)
						
					} catch let error {
						print("Errore fetching data: \(error)")
					}
				}
			}
			
		}
	}
	
	func update_all_routes() {
		let db = Firestore.firestore()
		get_all_rest_years { year in
			do {
				var route = self.routes_of_actual_year
				route.jahr = year
				let _ = try
				db.collection("Routes").document(year).setData(from: route)
				
			} catch {
				print("Error (add_new_route): \(error)")
			}
			
		}
	}
	
	
	
}

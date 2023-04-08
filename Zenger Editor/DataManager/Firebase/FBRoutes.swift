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
	
	
	/*
	 
	 func get_actual_route() {
	 let db = Firestore.firestore()
	 db.collection("Routes").document(app_year).getDocument { qrysnp, error in
	 if let qrysnp = qrysnp {
	 do {
	 let _ = try self.routes_of_actual_year = qrysnp.data(as: Routes.self)
	 } catch let err {
	 print("Error fetch (get_actual_route): \(err.localizedDescription)")
	 }
	 }
	 }
	 }*/
	
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
	/*
	func get_all_routes() async {
		let db = Firestore.firestore()
		
		db.collection("Routes").addSnapshotListener { qrysnp, error in
			
			if let qrysnp = qrysnp {
				self.all_routes = qrysnp.documents.compactMap{ document in
					do {
						let x = try document.data(as: Routes.self)
						return x
					} catch let err {
						print("Error fetch (get_all_routes): \(err.localizedDescription)")
					}
					return nil
				}
			}
			
		}
	}*/
	
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

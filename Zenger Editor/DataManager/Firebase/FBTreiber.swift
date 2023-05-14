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
	
	func get_all_actual_treiber () {
		
		let db = Firestore.firestore()
		db.collection("Treiber").whereField("jahr", isEqualTo: self.app_year).addSnapshotListener { qrysnp, _error in
			if let qrysnp = qrysnp {
				
				self.alle_treiber = qrysnp.documents.compactMap{ document in
					do {
						return try document.data(as: Treiber.self)
					}
					catch {
						print("Get_all_actual_treiber: Error maping  \(error)")
					}
					return nil
				}
			}
		}
	}
	
	func update_treiber <T> (route_nr: Int, field: String, value: T) {
		let ref = Firestore.firestore().collection("Treiber")
		get_all_rest_years { year in
			ref.document("\(year) - R\(route_nr)").updateData(["\(field)" : value])
		}
	}
	/*
	func update_total_of_treiber(route_nr: Int, total: Int) {
		let ref = Firestore.firestore().collection("Treiber")
		get_all_rest_years { year in
			ref.document("\(year) - R\(route_nr)").updateData(["total" : total])
		}
	}*/
	
	
	
	///SETUP ONLY
	func setup_add_treiber() {
		
		let setup = SetupData()
		let db = Firestore.firestore()
		for x in setup.all_years.indices {
			print(setup.all_years.indices)
			for idx in routes_of_actual_year.routes.indices {
				
				let ref = db.collection("Treiber").document("\(setup.all_years[x]) - R\(idx)")
				
				let treiber = Treiber(jahr: setup.all_years[x], route: idx, treiber: "Nicht besetzt", total: routes_of_actual_year.routes[idx].route_numbers.count-1, done_staende: 0, km: get_km(route_nr: idx), done_km: 0)
				
				do {
					let _ = try ref.setData(from: treiber)
				} catch {
					print(error)
				}
			}
		}
		
	}
	
}

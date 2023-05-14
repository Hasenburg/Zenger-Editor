//
//  FBJagdjahr.swift
//  Zenger Editor
//
//  Created by Sebastian Haslberger on 14.05.23.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import MapKit


extension DataManager {
	
	
	func get_jagdjahr() {
		
		let db = Firestore.firestore()
		
		db.collection("Jagdzeiten").document(app_year).addSnapshotListener { qrysnp, error in
			if let qrysnp = qrysnp {
				do {
					self.jagdjahr = try qrysnp.data(as: Jagdjahr.self)
				} catch {
					print("get_jagdjahr \(error.localizedDescription)")
				}
			}
		}
	}
	
	
	func set_jagdjahr(start: Date, end: Date) {
		
		let start_date = Timestamp(date: start)
		let end_date = Timestamp(date: end)
		
		let jagdjahr = Jagdjahr(jahr: app_year, jagdstart: start_date, jagdende: end_date)
		
		let ref = Firestore.firestore().collection("Jagdzeiten").document(app_year)
		
		do {
			try ref.setData(from: jagdjahr)
		} catch {
			print("Set_Jagdjahr \(error.localizedDescription)")
		}
		
		
	}
	
}

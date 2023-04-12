//
//  Firebase.swift
//  Zenger Editor
//
//  Created by Sebastian Haslberger on 10.02.23.
//


import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import MapKit


extension DataManager {
    
    
	
    
    func get_locations() {
        
            let db = Firestore.firestore()
        db.collection("Stand_Locations").document(app_year).addSnapshotListener { qrynap, error in
            if let qrynap = qrynap {
                do {
                    self.alle_staende = try qrynap.data(as: Staende.self)
                } catch {
                    print("Error (get_locations): \(error.localizedDescription)")
                
            }
                
                
            }
        }
        
    }
	
    func save_location_changes() {
        let db = Firestore.firestore()
        
        get_all_rest_years { year in
            do {
                var staende = self.alle_staende
                staende.jahr = year
                try db.collection("Stand_Locations").document(year).setData(from: staende)

            } catch {
                print("Error (save_location_changes): \(error.localizedDescription)")
            }
        }
        get_locations()
    }
    
    
}




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
    
    
    func gett_locations() async {
        let db = Firestore.firestore()
        do {
            self.alle_staende = try await db.collection("Stand_Locations").document(app_year).getDocument(as: Staende.self)
        } catch {
            print("Error (get_locations): \(error.localizedDescription)")
        }
    }
    
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
    /*
     func get_locations() {
     let group = DispatchGroup()
     
     let db = Firestore.firestore()
     db.collection("Stand_Locations").document(app_year).getDocument { doc, error in
     if let err = error {
     print("ERROR: GETLocations")
     print(err.localizedDescription)
     return
     }
     
     DispatchQueue.main.async {
     group.enter()
     if let doc = doc, doc.exists {
     do {
     self.alle_staende = try doc.data(as: Staende.self)
     } catch let erry {
     print("ERROR:GETLocations Doc \(erry)")
     }
     group.leave()
     
     }
     }
     }
     
     group.notify(queue: .main) {
     self.alle_staende_loaded = true
     }
     }
     */
    
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




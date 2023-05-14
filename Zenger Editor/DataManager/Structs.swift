//
//  Structs.swift
//  Zenger Editor
//
//  Created by Sebastian Haslberger on 10.02.23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import MapKit

struct Jagdjahr: Codable {
    var jahr: String
    var jagdstart: Timestamp
    var jagdende: Timestamp
}

struct Staende: Identifiable, Codable {
	
	@DocumentID var id: String?
	var jahr: String
	var locations: [GeoPoint]
	
}

struct Routes: Identifiable, Codable {
	@DocumentID var id: String?
	var jahr: String
	var routes: [Route]
	
}

struct Route: Codable {
	var route_numbers: [Int]
    var used: Bool
	
}

struct Route_Settings: Codable {
    var expanded: Bool = false {
        ///Set edit_mode to false, when expanded view disappears
        willSet (newValue) {
            if newValue == false {
                edit_mode = false
            }
        }
    }
    var visible: Bool = false {
        didSet (oldValue){
            
        }
    }
	var edit_mode: Bool = false
	
}


struct Treiber: Identifiable, Codable {
	@DocumentID var id: String?
	var jahr: String
	var route: Int
	var treiber: String
	var total: Int
	var done_staende: Int
	var km: Double
	var done_km: Double
	
}


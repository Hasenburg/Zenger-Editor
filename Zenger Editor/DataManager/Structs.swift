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
	
}

struct Route_View: Codable {
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


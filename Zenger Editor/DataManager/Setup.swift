//
//  Setup.swift
//  Zenger Editor
//
//  Created by Sebastian Haslberger on 10.02.23.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class SetupData: ObservableObject {
    
    let all_years = ["2019", "2020", "2021", "2022", "2023", "2024", "2025", "2026", "2027", "2028", "2029", "2030", "2031", "2032", "2033", "2034", "2035", "2036", "2037", "2038", "2039", "2040", "2041", "2042", "2043", "2044", "2045", "2046", "2047", "2048", "2049", "2050"]
    
    
    func addLocations() {
        let db = Firestore.firestore()
        for x in all_years.indices {
            
            let ref = db.collection("Stand_Locations").document("\(all_years[x])")
            
            let locations = Staende(jahr: "\(all_years[x])", locations: Locations)
            
            do {
                let _ = try ref.setData(from: locations)
            } catch {
                print(error)
            }
        }
    }
    
    func add_jagd_jahre() {
        
        let db = Firestore.firestore()
        
        for x in all_years.indices {
            let ref = db.collection("Jagdzeiten").document("\(all_years[x])")
            
            var dateComponents = DateComponents()
            dateComponents.year = Int(all_years[safe: x]!)
            dateComponents.month = 12
            dateComponents.day = 10
            dateComponents.timeZone = TimeZone(abbreviation: "CEST")
            dateComponents.hour = 9
            dateComponents.minute = 00
            let userCalendar = Calendar(identifier: .gregorian)
            let startDate = userCalendar.date(from: dateComponents)
            
            dateComponents.hour = 14
            dateComponents.minute = 00
            let endeDate = userCalendar.date(from: dateComponents)
            
            let time = Jagdjahr(jahr: all_years[x], jagdstart: Timestamp(date: startDate!), jagdende: Timestamp(date: endeDate!))
            
            do {
                let _ = try ref.setData(from:time)
            } catch {
                print(error)
            }
        }
    }
    
    var Locations = [
        GeoPoint(latitude: 48.282074, longitude: 11.753423),
        GeoPoint(latitude: 48.286350, longitude: 11.752594),
        GeoPoint(latitude: 48.285030, longitude: 11.756457),
        GeoPoint(latitude: 48.285660, longitude: 11.760449),
        GeoPoint(latitude: 48.288375, longitude: 11.756384),
        GeoPoint(latitude: 48.282156, longitude: 11.756804),
        GeoPoint(latitude: 48.282291, longitude: 11.759722),
        GeoPoint(latitude: 48.283888, longitude: 11.763349),
        GeoPoint(latitude: 48.296440, longitude: 11.769589),
        GeoPoint(latitude: 48.283813, longitude: 11.766361),
        GeoPoint(latitude: 48.282745, longitude: 11.767006),
        GeoPoint(latitude: 48.281876, longitude: 11.769693),
        GeoPoint(latitude: 48.285313, longitude: 11.770928),
        GeoPoint(latitude: 48.282069, longitude: 11.771333),
        GeoPoint(latitude: 48.285064, longitude: 11.773408),
        GeoPoint(latitude: 48.287436, longitude: 11.772958),
        GeoPoint(latitude: 48.287954, longitude: 11.771348),
        GeoPoint(latitude: 48.289525, longitude: 11.772810),
        GeoPoint(latitude: 48.290832, longitude: 11.771648),
        GeoPoint(latitude: 48.283636, longitude: 11.773671),
        GeoPoint(latitude: 48.292861, longitude: 11.773709),
        GeoPoint(latitude: 48.284230, longitude: 11.758675),
        GeoPoint(latitude: 48.297040, longitude: 11.775138),
        GeoPoint(latitude: 48.298002, longitude: 11.775465),
        GeoPoint(latitude: 48.294852, longitude: 11.774368),
        GeoPoint(latitude: 48.292690, longitude: 11.771520),
        GeoPoint(latitude: 48.287850, longitude: 11.754731),
        GeoPoint(latitude: 48.299254, longitude: 11.774461),
        GeoPoint(latitude: 48.284187, longitude: 11.753743),
        GeoPoint(latitude: 48.294497, longitude: 11.766336),
        GeoPoint(latitude: 48.293562, longitude: 11.766357),
        GeoPoint(latitude: 48.292035, longitude: 11.765755),
        GeoPoint(latitude: 48.294161, longitude: 11.763869),
        GeoPoint(latitude: 48.293591, longitude: 11.761708),
        GeoPoint(latitude: 48.292360, longitude: 11.763438),
        GeoPoint(latitude: 48.291680, longitude: 11.763557),
        GeoPoint(latitude: 48.290670, longitude: 11.762457),
        GeoPoint(latitude: 48.289053, longitude: 11.765481),
        GeoPoint(latitude: 48.289864, longitude: 11.769767),
        GeoPoint(latitude: 48.295175, longitude: 11.764827),
        GeoPoint(latitude: 48.288745, longitude: 11.760020),
        GeoPoint(latitude: 48.288123, longitude: 11.760888),
        GeoPoint(latitude: 48.288417, longitude: 11.762843),
        GeoPoint(latitude: 48.287116, longitude: 11.762057),
        GeoPoint(latitude: 48.286426, longitude: 11.757369),
        GeoPoint(latitude: 48.286686, longitude: 11.765102),
        GeoPoint(latitude: 48.287328, longitude: 11.767133),
        GeoPoint(latitude: 48.279872, longitude: 11.758877),
        GeoPoint(latitude: 0, longitude: 0),
        GeoPoint(latitude: 0, longitude: 0),
        GeoPoint(latitude: 0, longitude: 0)
    ]
    
    
}

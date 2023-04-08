//
//  MapView.swift
//  NewMap
//
//  Created by Sebastian Haslberger on 07.02.23.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    typealias UIViewType = MKMapView
        
    
    ///  Muss ein EnvironementObject bleiben
	@EnvironmentObject var dm: DataManager
	
    
    ///  Changes_made muss drinnen bleiben als Binding.
    ///  Wenn als environementObject, dann resetet sich die Location der Staende immer wieder.
    @Binding var changes_made: Bool
    
    
    
    @State var changed_staende: [MKAnnotation] = []
    
    
    
    
    /// Center of Map
    let coordinate = CLLocationCoordinate2D(latitude: 48.286912, longitude: 11.764172)
    let span = MKCoordinateSpan(latitudeDelta: 0.027, longitudeDelta: 0.027)
    
    
    
    
    
    func makeCoordinator() -> MapView.Coordinator {
        return MapView.Coordinator(_parent: self, changes_made: $changes_made)
    }
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        let map = MKMapView()
        map.mapType = .satelliteFlyover
        
        map.region = MKCoordinateRegion(center: self.coordinate, span: self.span)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        
        map.delegate = context.coordinator
        
        return map
        
    }
    
	
}

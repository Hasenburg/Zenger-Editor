//
//  ContentView.swift
//  Zenger Editor
//
//  Created by Sebastian Haslberger on 09.02.23.
//

import SwiftUI
import MapKit


struct ContentView: View {
	@StateObject var dm = DataManager()
	
	@State var annotation_is_draggable = false
	@State var changes_made = false
	
	@State var showRouteView = false {
		willSet {
			if newValue {
				show_Jagdjahr_button = false
			}
		}
	}
	
	@State var show_Jagdjahr_button = false
	@State var show_Jagdjahr_settings = false
	
	var body: some View {
		ZStack {
			MapView(changes_made: $changes_made)
				.edgesIgnoringSafeArea(.all)
			
			ChangeStaendeView(showRouteView: $showRouteView, changes_made: $changes_made)
			
			AlignButton(which_corner: .bottomRight) {
				NavigationButton(systemImage: "house") {
					dm.map_set_center.toggle()
				}
			}
			
			if show_Jagdjahr_button {
				AlignButton(which_corner: .topLeft) {
					
					NavigationButton(systemImage: "calendar") {
						show_Jagdjahr_settings.toggle()
					}
				}
				
			}
			
			Routes_View(showRouteView: $showRouteView)
			RouteButton_View(showRouteView: $showRouteView)
			
			YearPicker(show: $showRouteView, show_Jagdjahr_button: $show_Jagdjahr_button)
			
			
		}
		.sheet(isPresented: $show_Jagdjahr_settings, content: {
			Jagdjahr_View(show_Jagdjahr_settings: $show_Jagdjahr_settings)
		})
		
		.onAppear {
			//let setup = SetupData()
			//setup.addLocations()
			//setup.add_jagd_jahre()
		}
		.environmentObject(dm)
	}
}


struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}

struct NavigationButton: View {
	var systemImage: String
	var color_foreground: Color = .primary
	var color_background: Color = Color(.systemGray6)
	var size: CGFloat = 50
	var font_size: Font = .title2
	var pressed: () -> Void
	var body: some View {
		Button {
			pressed()
		} label: {
			
			Image(systemName: systemImage)
				.font(font_size)
				.foregroundColor(color_foreground)
				.background(
					Circle()
						.foregroundColor(color_background)
						.frame(width: size, height: size)
				)
				.shadow(radius: 0)
		}
		
	}
}

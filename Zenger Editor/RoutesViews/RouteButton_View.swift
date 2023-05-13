//
//  RouteViewButton.swift
//  Zenger Editor
//
//  Created by Sebastian Haslberger on 02.03.23.
//

import SwiftUI

struct RouteButton_View: View {
	@EnvironmentObject var dm: DataManager
	@Binding var showRouteView: Bool
	
	@State var color: Color = .primary
	
	
	var body: some View {
		
		AlignButton(which_corner: .bottomLeft) {
			VStack (spacing: 40){
				if showRouteView {
                    NavigationButton(systemImage: "eye.fill", color_foreground: dm.check_route_visibility(), size: 40, font_size: .subheadline) {
						if dm.check_route_visibility() == .primary {
							dm.toggle_visibility(on: true)
                            dm.toggle_expansion(on: true)
						} else {
							dm.toggle_visibility(on: false)
                            dm.toggle_expansion(on: false)
						}
					}
					.onReceive(dm.$routes_of_actual_year) { outp in
						color = dm.check_route_visibility()
					}
					.transition(.move(edge: .bottom).combined(with: .opacity))
				}
				
				NavigationButton(systemImage: "point.topleft.down.curvedto.point.bottomright.up.fill", color_foreground: showRouteView ? .accentColor : .primary) {
					withAnimation {
						showRouteView.toggle()
						dm.toggle_visibility(on: false)
						if dm.annotation_is_draggable == true {
							dm.annotation_is_draggable = false
						}
					}
				}
			}
		}
	}
}

struct RouteViewButton_Previews: PreviewProvider {
	static var previews: some View {
		RouteButton_View(showRouteView: .constant(true))
			.environmentObject(DataManager())
	}
}

//
//  RouteView.swift
//  Zenger Editor
//
//  Created by Sebastian Haslberger on 10.02.23.
//

import SwiftUI
import MapKit

struct Routes_View: View {
	@EnvironmentObject var dm: DataManager
	
	@State var selectedIdx = 99
	@Binding var showRouteView: Bool
	
	var view_height: CGFloat = 70
	
	var body: some View {
		VStack {
			if showRouteView {
				ZStack {
					VStack{
						Rectangle()
							.foregroundColor(Color(.white))
							.frame(width: UIScreen.main.bounds.width, height: showRouteView ? view_height : 0)
						Spacer()
					}
					ScrollView (.horizontal) {
							HStack {
								Group {
									ForEach(dm.routes_of_actual_year.routes.indices, id: \.self) { idx in
										VStack {
											SingleRoute_View(route_nr: idx, route_view: $dm.all_routes_views[idx])
												.scaledToFit()
												.padding(.top, 5) //fit in rect
												.onTapGesture {
													selectedIdx = idx
												}
											Spacer()
										}
									}
									VStack {
										NavigationButton(systemImage: "plus", color_foreground: .white, color_background: .indigo) {
											dm.routes_of_actual_year.routes.append(Route(route_numbers: [0], used: false))
											dm.update_all_routes()
										}
										.shadow(radius: 2)
										.padding(.leading, 15)
										.padding(.trailing, 25)
										.padding(.top, 23)
										Spacer()
									}
								}
							
						}.padding(.horizontal, 10)
					}
					
				}
				.transition(AnyTransition.opacity.combined(with: .move(edge: .trailing)))
				.animation(.easeOut(duration: 3), value: 1)
				
			}
			Spacer()
		}
		.onReceive(dm.$routes_of_actual_year) { _ in
			for _ in dm.routes_of_actual_year.routes {
				dm.all_routes_views.append(Route_Settings())
			}
		}
		
	}
}

struct RouteView_Previews: PreviewProvider {
	static var previews: some View {
		Routes_View(showRouteView: .constant(true))
			.environmentObject(DataManager())
	}
}

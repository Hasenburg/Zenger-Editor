//
//  RouteView.swift
//  Zenger Editor
//
//  Created by Sebastian Haslberger on 10.02.23.
//

import SwiftUI
import MapKit

struct RouteView: View {
	
	@EnvironmentObject var dm: DataManager
	
	@State var selectedIdx = 99
	@Binding var showRouteView: Bool
	
	
	var view_height: CGFloat = 70
	
	
	var body: some View {
		VStack {
			
			if showRouteView {
				ZStack {
					ZStack {
						ScrollView (.horizontal) {
							HStack {
								ForEach(dm.routes_of_actual_year.routes.indices, id: \.self) { idx in
                                    SingleRouteView(route_nr: idx, route_view: $dm.all_routes_views[idx])
										.onTapGesture {
											selectedIdx = idx
										}
								}
                                
                                NavigationButton(systemImage: "plus", color_foreground: .white, color_background: .indigo) {
                                    dm.routes_of_actual_year.routes.append(Route(route_numbers: []))
                                    dm.update_all_routes()
                                    
                                }
                                .shadow(radius: 2)
                                .padding(.leading, 15)
							}.padding(.leading, 10)
						}/*
						HStack {
							Spacer()
							.offset(y:80)
						}*/
					}
					.frame(height: showRouteView ? view_height : 0)
					.background(
						RoundedRectangle(cornerRadius: 30)
							.foregroundColor(Color(.systemGray6))
							.frame(width: UIScreen.main.bounds.width*3, height: showRouteView ? view_height : 0)
					)
					
				}
				.transition(AnyTransition.opacity.combined(with: .move(edge: .trailing)))
				.animation(.easeOut(duration: 3), value: 1)
				
			}
			Spacer()
			
		}
		.onReceive(dm.$routes_of_actual_year) { _ in
			for _ in dm.routes_of_actual_year.routes {
				dm.all_routes_views.append(Route_View())
			}
		}
		
	}
}

struct RouteView_Previews: PreviewProvider {
	static var previews: some View {
		RouteView(showRouteView: .constant(true))
			.environmentObject(DataManager())
	}
}

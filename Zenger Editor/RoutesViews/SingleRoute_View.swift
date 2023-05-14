//
//  SingleRouteView.swift
//  Zenger Editor
//
//  Created by Sebastian Haslberger on 19.02.23.
//

import SwiftUI

struct SingleRoute_View: View {
	
	@EnvironmentObject var dm: DataManager
	var route_nr: Int
	
	@Binding var route_view: Route_Settings
	
	@State var showAlert = false
	
	fileprivate func switchOffAllOtherEditModes() {
		if route_view.edit_mode == false {
			route_view.edit_mode = true
			for x in dm.routes_of_actual_year.routes.indices {
				if x != route_nr {
					if dm.all_routes_views[x].edit_mode == true {
						dm.all_routes_views[x].edit_mode = false
					}
				}
			}
		} else {
			route_view.edit_mode = false
		}
	}
	
	
	
	var body: some View {
		VStack {
			RouteData_View(route_nr: route_nr, route_view: $route_view)
			
			
			if route_view.expanded {
				
				VStack (spacing: 25) {
					NavigationButton(systemImage: "pencil", color_foreground: route_view.edit_mode ? .accentColor : .primary, size: 30, font_size: .caption) {
						switchOffAllOtherEditModes()
					}
					.transition(.move(edge: .top).combined(with: .opacity))
					
					if route_view.edit_mode {
						let used = dm.check_treiber(route_nr: route_nr) != "Nicht besetzt" ? true : false
						NavigationButton(systemImage: used ? "checkmark.circle" : "x.circle", color_foreground: used ? .white : .black, color_background: used ? .green : .yellow, size: 30, font_size: .caption) {
							if used {
								showAlert.toggle()
							}
						}
						
						NavigationButton(systemImage: "trash", color_foreground: .white, color_background: .red, size: 30, font_size: .caption) {
							route_view.visible = false
							dm.routes_of_actual_year.routes.remove(at: route_nr)
							dm.all_routes_views.remove(at:route_nr)
							dm.update_all_routes()
						}
					}
				}
				.padding(.top, 15)
				.alert(isPresented: $showAlert) {
					Alert(
						title: Text("Bist du sicher?"),
						message: Text("Das setzt den Treiber zurück"),
						primaryButton: .destructive(Text("Yes"), action: {
							dm.update_treiber(route_nr: route_nr, field: "treiber", value: "Nicht besetzt")
						}),
						secondaryButton: .default(Text("No")) //<-- use default here
					)
				}
			}
		}
	}
}



struct SingleRouteView_Previews: PreviewProvider {
	
	static var previews: some View {
		SingleRoute_View(route_nr: 0, route_view: .constant(Route_Settings()))
			.environmentObject(DataManager())
	}
}


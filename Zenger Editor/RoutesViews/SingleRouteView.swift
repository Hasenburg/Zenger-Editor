//
//  SingleRouteView.swift
//  Zenger Editor
//
//  Created by Sebastian Haslberger on 19.02.23.
//

import SwiftUI

struct SingleRouteView: View {
    
    @EnvironmentObject var dm: DataManager
    var route_nr: Int
    
    @Binding var route_view: Route_View
		
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
        ZStack {
			kmView(nr: route_nr)
            Route_Nr_View_Button(route_nr: route_nr, route_view: $route_view)
            
			if route_view.expanded {
				
				VStack (spacing: 25) {
					NavigationButton(systemImage: "eye", color_foreground: route_view.visible ? .accentColor : .primary, size: 30, font_size: .caption) {
						route_view.visible.toggle()
					}
					.transition(.move(edge: .top).combined(with: .opacity))

					NavigationButton(systemImage: "pencil", color_foreground: route_view.edit_mode ? .accentColor : .primary, size: 30, font_size: .caption) {
						switchOffAllOtherEditModes()
					}
					.transition(.move(edge: .top).combined(with: .opacity))
					
					if route_view.edit_mode {
						NavigationButton(systemImage: "trash", color_foreground: .white, color_background: .red, size: 30, font_size: .caption) {
							route_view.visible = false
							dm.routes_of_actual_year.routes.remove(at: route_nr)
							dm.all_routes_views.remove(at:route_nr)
							dm.update_all_routes()
						}
					}
				}.padding(.top, route_view.edit_mode ? 215 : 175)
			}
		}.frame(height: 350)
    }
}
/*
struct SingleRouteView: View {
    
    @EnvironmentObject var dm: DataManager
    var route_nr: Int
        
    fileprivate func switchOffAllOtherEditModes() {
        if dm.all_routes_views[route_nr].edit_mode == false {
            dm.all_routes_views[route_nr].edit_mode = true
            for x in dm.routes_of_actual_year.routes.indices {
                if x != route_nr {
                    if dm.all_routes_views[x].edit_mode == true {
                        dm.all_routes_views[x].edit_mode = false
                    }
                }
            }
        } else {
            dm.all_routes_views[route_nr].edit_mode = false
        }
    }
    
    var body: some View {
        ZStack {
            kmView(nr: route_nr)
            
            Text("#\(route_nr)")
                .font(.title2)
                .foregroundColor(color_scheme_route[route_nr].forground)
                .frame(width: 75, height: 50)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundColor(color_scheme_route[route_nr].background)
                )
                .onTapGesture {
                    withAnimation {
                        /*if dm.all_routes_views[route_nr].expanded {
                            dm.all_routes_views[route_nr].edit_mode = false
                        }*/
                        dm.all_routes_views[route_nr].expanded.toggle()
                    }
                }
            if dm.all_routes_views[route_nr].expanded {
                
                VStack (spacing: 25) {
                    NavigationButton(systemImage: "eye", color_foreground: dm.all_routes_views[route_nr].visible ? .accentColor : .primary, size: 30, font_size: .caption) {
                        dm.all_routes_views[route_nr].visible.toggle()
                    }
                    .transition(.move(edge: .top).combined(with: .opacity))

                    NavigationButton(systemImage: "pencil", color_foreground: dm.all_routes_views[route_nr].edit_mode ? .accentColor : .primary, size: 30, font_size: .caption) {
                        switchOffAllOtherEditModes()
                        
                    }
                    .transition(.move(edge: .top).combined(with: .opacity))
                    
                    if dm.all_routes_views[route_nr].edit_mode {
                        NavigationButton(systemImage: "trash", color_foreground: .white, color_background: .red, size: 30, font_size: .caption) {
                            // Delete Route
                            dm.all_routes_views[route_nr].visible = false
                            dm.routes_of_actual_year.routes.remove(at: route_nr)
                            dm.all_routes_views.remove(at:route_nr)
                            dm.update_all_routes()
                        }
                    }
                }.padding(.top, dm.all_routes_views[route_nr].edit_mode ? 215 : 175)
            }
        }.frame(height: 350)
    }
}
*/
struct SingleRouteView_Previews: PreviewProvider {
    
    static var previews: some View {
        SingleRouteView(route_nr: 0, route_view: .constant(Route_View()))
            .environmentObject(DataManager())
    }
}
extension Collection where Indices.Iterator.Element == Index {
    public subscript(safe index: Index) -> Iterator.Element? {
        return (startIndex <= index && index < endIndex) ? self[index] : nil
    }
}

struct kmView: View {
	@EnvironmentObject var dm: DataManager
	var nr: Int
	
	var body: some View {
		ZStack {
			RoundedRectangle(cornerRadius: 10)
				.frame(width: 45, height: 50)
				.foregroundColor(Color(.systemGray))
			Text("\(dm.get_km(route_nr: nr), specifier: "%.1f")")
				.font(.subheadline)
				.offset(CGSize(width: 0, height: 14))
		}
		.offset(CGSize(width: 0, height: 19))
	}
}

struct Route_Nr_View_Button: View {
    var route_nr: Int
    @Binding var route_view: Route_View
    var body: some View {
        Text("#\(route_nr)")
            .font(.title2)
            .foregroundColor(color_scheme_route[route_nr].forground)
            .frame(width: 75, height: 50)
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(color_scheme_route[route_nr].background)
            )
            .onTapGesture {
                withAnimation {
                    route_view.expanded.toggle()
                }
            }
    }
}

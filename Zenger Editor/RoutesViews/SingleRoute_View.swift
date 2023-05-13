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
            //kmView(nr: route_nr)
            // Route_Nr_View_Button(route_nr: route_nr, route_view: $route_view)
            
            
            if route_view.expanded {
                
                VStack (spacing: 25) {
                    NavigationButton(systemImage: "pencil", color_foreground: route_view.edit_mode ? .accentColor : .primary, size: 30, font_size: .caption) {
                        switchOffAllOtherEditModes()
                    }
                    .transition(.move(edge: .top).combined(with: .opacity))
                    
                    if route_view.edit_mode {
                        NavigationButton(systemImage: dm.routes_of_actual_year.routes[route_nr].used ? "checkmark.circle" : "x.circle", color_foreground: .white, color_background: .primary, size: 30, font_size: .caption) {
                            dm.routes_of_actual_year.routes[route_nr].used.toggle()
                            dm.update_all_routes()
                        }
                        
                        NavigationButton(systemImage: "trash", color_foreground: .white, color_background: .red, size: 30, font_size: .caption) {
                            route_view.visible = false
                            dm.routes_of_actual_year.routes.remove(at: route_nr)
                            dm.all_routes_views.remove(at:route_nr)
                            dm.update_all_routes()
                        }
                    }
                }//.padding(.top, route_view.edit_mode ? 255 : 135)
                .padding(.top, 5)
            }
        }//.frame(maxHeight: UIScreen.main.bounds.height*0.3)
    }
}



struct SingleRouteView_Previews: PreviewProvider {
    
    static var previews: some View {
        SingleRoute_View(route_nr: 0, route_view: .constant(Route_Settings()))
            .environmentObject(DataManager())
    }
}
/*
 struct kmView: View {
 @EnvironmentObject var dm: DataManager
 var nr: Int
 
 var body: some View {
 ZStack {
 RoundedRectangle(cornerRadius: 10)
 .frame(width: 45, height: 50)
 .foregroundColor(Color(.systemGray))
 Text("\(dm.get_km(route_nr: nr), specifier: "%.1f")")
 .font(.callout)
 .offset(CGSize(width: 0, height: 14))
 }
 .offset(CGSize(width: 0, height: 19))
 }
 }
 
 struct Route_Nr_View_Button: View {
 var route_nr: Int
 @Binding var route_view: Route_Settings
 var body: some View {
 ZStack {
 Text("N°")
 .font(.caption2)
 .offset(x:-10, y: -15)
 Text("\(route_nr)")
 .font(.title2)
 }
 .foregroundColor(color_scheme_route[route_nr].forground)
 .frame(width: 75, height: 50)
 .background(
 RoundedRectangle(cornerRadius: 15)
 .foregroundColor(color_scheme_route[route_nr].background)
 )
 .onTapGesture {
 withAnimation {
 route_view.expanded.toggle()
 route_view.visible.toggle()
 }
 }
 }
 }*/

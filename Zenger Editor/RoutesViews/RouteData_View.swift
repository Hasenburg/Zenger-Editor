//
//  RouteData_View.swift
//  Zenger Editor
//
//  Created by Sebastian Haslberger on 07.05.23.
//

import SwiftUI

struct RouteData_View: View {
    @EnvironmentObject var dm: DataManager
    var route_nr: Int
    @Binding var route_view: Route_Settings
    
    var total_width: CGFloat = 70
    var total_height: CGFloat = 60
    var radius: CGFloat = 15
    
    var body: some View {
        VStack {
            
            ZStack {
                Text("N°")
                    .offset(x:-20, y:-10)
                    .font(.caption2)
                Text("\(route_nr)")
                    .font(.title2)
                    .frame(height: total_height*0.55)
            }.foregroundColor(color_scheme_route[route_nr].forground)
            
            HStack (spacing: 0) {
                ZStack {
                    Text("km")
                        .font(.caption2)
                        .offset(y:-13)
                        .foregroundColor(Color(.systemGray4))
                    Text("\(dm.get_km(route_nr: route_nr), specifier: "%.1f")")
                        .font(.caption)
                }
                .padding(3)
                .frame(width: total_width/2)
                .background{
                    RoundedCorners(color:Color(.systemGray4), bl:radius)
                }
                
                ZStack {
                    Text("#")
                        .font(.caption2)
                        .offset(y:-13)
                        .foregroundColor(Color(.systemGray5))
                    Text("\(dm.routes_of_actual_year.routes[route_nr].route_numbers.count-1)")
                        .font(.caption)
                }
                .padding(3)
                .frame(width: total_width/2)
                .background{
                    RoundedCorners(color:Color(.systemGray5), br:radius)
                }
            }
            .frame(height: total_height*0.15)
        }.frame(width: total_width, height: total_height)
            .background{
                RoundedCorners(color: color_scheme_route[route_nr].background, tl: radius, tr: radius, bl: radius, br: radius)
            }
        
        .onTapGesture {
            withAnimation {
                route_view.expanded.toggle()
                route_view.visible.toggle()
            }
        }
    }
}

struct RouteData_View_Previews: PreviewProvider {
    static var previews: some View {
        RouteData_View(route_nr: 0, route_view: .constant(Route_Settings()))
            .environmentObject(DataManager())
    }
}

struct RoundedCorners: View {
    var color: Color = .blue
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                
                let w = geometry.size.width
                let h = geometry.size.height
                
                // Make sure we do not exceed the size of the rectangle
                let tr = min(min(self.tr, h/2), w/2)
                let tl = min(min(self.tl, h/2), w/2)
                let bl = min(min(self.bl, h/2), w/2)
                let br = min(min(self.br, h/2), w/2)
                
                path.move(to: CGPoint(x: w / 2.0, y: 0))
                path.addLine(to: CGPoint(x: w - tr, y: 0))
                path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
                path.addLine(to: CGPoint(x: w, y: h - br))
                path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
                path.addLine(to: CGPoint(x: bl, y: h))
                path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
                path.addLine(to: CGPoint(x: 0, y: tl))
                path.addArc(center: CGPoint(x: tl, y: tl), radius: tl, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
                path.closeSubpath()
            }
            .fill(self.color)
        }
    }
}

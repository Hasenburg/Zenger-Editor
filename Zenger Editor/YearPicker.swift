//
//  YearPicker.swift
//  Zenger Editor
//
//  Created by Sebastian Haslberger on 03.04.23.
//

import SwiftUI

struct YearPicker: View {
	@EnvironmentObject var dm: DataManager
	@Binding var show: Bool
	@State var expanded = false
	
	@State var indexOfyear = 0
	
	var body: some View {
		if !show {
			VStack {
				HStack (spacing: 20){
					if expanded {
						Button {
							if indexOfyear > 0 {
								indexOfyear -= 1
								dm.app_year = dm.years[indexOfyear]
								dm.get_actual_route()
								//dm.routes_of_actual_year = dm.all_routes[indexOfyear]
							}
						} label: {
							Image(systemName: "arrowtriangle.left.fill")
								.foregroundColor(Color(.white))
						}
					}
					
					Button {
						expanded.toggle()
					} label: {
						Text(dm.years[indexOfyear])
							.foregroundColor(.white)
					}
					.background(
						RoundedRectangle(cornerSize: CGSize(width: 15, height: 15))
							.frame(width: 70, height: 35)
							.foregroundColor(Color(.darkGray))
					)
					if expanded {
						Button {
							if indexOfyear < dm.years.count-1 {
								indexOfyear += 1
								dm.app_year = dm.years[indexOfyear]
								dm.get_actual_route()
								//dm.routes_of_actual_year = dm.all_routes[indexOfyear]
							}
						} label: {
							Image(systemName: "arrowtriangle.right.fill")
								.foregroundColor(Color(.white))
						}
					}
				}
				.padding(.top, 10)
				
				Spacer()
			}
			.onAppear() {
				indexOfyear = dm.years.firstIndex(of: dm.app_year)!
			}
		}
	}
}

struct YearPicker_Previews: PreviewProvider {
	static var previews: some View {
		YearPicker(show: .constant(false))
			.environmentObject(DataManager())
	}
}

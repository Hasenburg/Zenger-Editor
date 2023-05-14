//
//  Jagdjahr_View.swift
//  Zenger Editor
//
//  Created by Sebastian Haslberger on 14.05.23.
//

import SwiftUI

struct Jagdjahr_View: View {
	@EnvironmentObject var dm: DataManager
	
	@Binding var show_Jagdjahr_settings: Bool
	
	@State var start = Date()
	@State var ende = Date()
	
	var body: some View {
		if show_Jagdjahr_settings {
			VStack {
				Text("Jagdzeit").font(.title)
				Text("\(dm.app_year)").font(.largeTitle)
				DatePicker("Start", selection: $start)
				DatePicker("Ende", selection: $ende)
				HStack (spacing: 20) {
					Button {
						dm.set_jagdjahr(start: start, end: ende)
						
					} label: {
							Text("Save")
					}
					.buttonStyle(.borderedProminent)
					
					Button {
						show_Jagdjahr_settings.toggle()
					} label: {
							Text("Cancel")
					}
					.buttonStyle(.bordered)
					.foregroundColor(.red)
				}
				.padding(.top, 20)
			}
			.padding(55)
			.onAppear{
				start = dm.jagdjahr.jagdstart.dateValue()
				ende = dm.jagdjahr.jagdende.dateValue()
			}
		}
	}
}

struct Jagdjahr_View_Previews: PreviewProvider {
	static var previews: some View {
		Jagdjahr_View(show_Jagdjahr_settings: .constant(true))
			.environmentObject(DataManager())
	}
}

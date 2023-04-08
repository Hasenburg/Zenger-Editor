//
//  ChangeStaendeView.swift
//  Zenger Editor
//
//  Created by Sebastian Haslberger on 02.03.23.
//

import SwiftUI

struct ChangeStaendeView: View {
    @EnvironmentObject var dm: DataManager
    
    @Binding var showRouteView: Bool
    @Binding var changes_made: Bool {
        willSet {
            if !newValue {
                dm.changed_annotations.removeAll()
            }
        }
    }
    
    var body: some View {
        if !showRouteView {
            ZStack {
                if dm.annotation_is_draggable && changes_made {
                    AlignButton(which_corner: .topLeft) {
                        NavigationButton(systemImage: "checkmark", color_foreground: .white, color_background: .green) {
                            dm.save_button_pressed.toggle()
							
                            //MARK: Turn off Draggable & Changes Made Mode
                            changes_made.toggle()
                            dm.annotation_is_draggable.toggle()
                        }
                    }
                }
                AlignButton(which_corner: .topRight) {
                    NavigationButton(systemImage: dm.annotation_is_draggable ? "x.circle" : "pencil", color_foreground: dm.annotation_is_draggable ? .red : .primary) {
                        dm.annotation_is_draggable.toggle()
                        //dm.getLocations()
                        if changes_made == true {
                            changes_made.toggle()
                        }
					}
                }
            }
        }
    }
}

struct ChangeStaendeView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeStaendeView(showRouteView: .constant(false), changes_made: .constant(false))
            .environmentObject(DataManager())
    }
}

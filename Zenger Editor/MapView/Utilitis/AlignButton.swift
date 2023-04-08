//
//  AlignButton.swift
//  Zenger Editor
//
//  Created by Sebastian Haslberger on 11.02.23.
//

import SwiftUI

struct AlignButton<Content: View>: View {
    var which_corner: corner
    @ViewBuilder let content: Content
    
    var body: some View {
        VStack {
			if which_corner == .bottomLeft || which_corner == .bottomRight || which_corner == .bottomCenter {
                Spacer()
            }
            
            HStack {
                if which_corner == .bottomRight || which_corner == .topRight || which_corner == .bottomCenter {
                    Spacer()
                }
                
                content.shadow(color: .gray, radius: 3, x: 0, y: 0)
                
                if which_corner == .bottomLeft || which_corner == .topLeft || which_corner == .bottomCenter {
                    Spacer()
                }
            }
            if which_corner == .topLeft || which_corner == .topRight {
                Spacer()
            }
        }.padding(50)
    }
}

enum corner {
    case bottomLeft
    case bottomRight
	case bottomCenter
    case topLeft
    case topRight
    case topCenter
}



//
//  Style.swift
//  Zenger Editor
//
//  Created by Sebastian Haslberger on 10.02.23.
//

import SwiftUI



struct myColors {
    var background: Color
    var forground: Color
	var r:Double
	var g:Double
	var b:Double
    var uicolor: UIColor
    
    init(_ r:Double, _ g: Double, _ b: Double) {
        background = Color(red: r/255, green: g/255, blue: b/255)
		self.r = r/255
		self.g = g/255
		self.b = b/255
        self.uicolor = UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
        if r+g+b > 370 {
            forground = Color.black
        } else {
            forground = Color.white
        }
    }
    
}


var color_scheme_route = [
    myColors(2, 103, 193),  //blue,
    myColors(90, 42, 39),  //dark red,
    myColors(252, 100, 113),  //bright pink,
    myColors(255, 159, 28),  // orange peel,
    myColors(134, 22, 87),  //purple,
    myColors(219, 173, 106),  //yellow,
    myColors(2, 1, 34),  //oxford blue,
    myColors(218, 44, 56),  //red,
    myColors(134, 131, 109),  //battleship gray,
    myColors(147, 225, 216),  //cyan blue,
    myColors(255, 166, 158),  //lightpink,
    myColors(156, 102, 21),  // golden brown,
    myColors(221, 237, 170),  //tea green,
    myColors(125, 112, 186),  //amnethyst,
    myColors(10, 129, 209),  //blue,
    myColors(219, 84, 97),  //indian red,
    myColors(224, 214, 138),  //kind of yellow,
    myColors(204, 75, 194),  //steel pink,
    myColors(169, 222, 249),  // uranium blue,
    myColors(81, 23, 48),  //thyrian purple,
    myColors(0, 217, 192), //türkis
    
    
]

/*
var color_scheme_route = [
    myColors(background: Color(red:2/255, green: 103/255, blue: 193/255), forground: Color.white), //blue,
    myColors(background: Color(red:90/255, green: 42/255, blue: 39/255), forground: Color.white), //dark red,
    myColors(background: Color(red:252/255, green: 100/255, blue: 113/255), forground: Color.black), //bright pink,
    myColors(background: Color(red:255/255, green: 159/255, blue: 28/255), forground: Color.black), // orange peel,
    myColors(background: Color(red:134/255, green: 22/255, blue: 87/255), forground: Color.white), //purple,
    myColors(background: Color(red:219/255, green: 173/255, blue: 106/255), forground: Color.black), //yellow,
    myColors(background: Color(red:2/255, green: 1/255, blue: 34/255), forground: Color.white), //oxford blue,
    myColors(background: Color(red:218/255, green: 44/255, blue: 56/255), forground: Color.white), //red,
    myColors(background: Color(red:134/255, green: 131/255, blue: 109/255), forground: Color.black), //battleship gray,
    myColors(background: Color(red:147/255, green: 225/255, blue: 216/255), forground: Color.black), //cyan blue,
    myColors(background: Color(red:255/255, green: 166/255, blue: 158/255), forground: Color.black), //lightpink,
    myColors(background: Color(red:156/255, green: 102/255, blue: 21/255), forground: Color.white), // golden brown,
    myColors(background: Color(red:221/255, green: 237/255, blue: 170/255), forground: Color.black), //tea green,
    myColors(background: Color(red:125/255, green: 112/255, blue: 186/255), forground: Color.white), //amnethyst,
    myColors(background: Color(red:10/255, green: 129/255, blue: 209/255), forground: Color.white), //blue,
    myColors(background: Color(red:219/255, green: 84/255, blue: 97/255), forground: Color.white), //indian red,
    myColors(background: Color(red:224/255, green: 214/255, blue: 138/255), forground: Color.white), //kind of yellow,
    myColors(background: Color(red:204/255, green: 75/255, blue: 194/255), forground: Color.white), //steel pink,
    myColors(background: Color(red:169/255, green: 222/255, blue: 249/255), forground: Color.white), // uranium blue,
    myColors(background: Color(red:81/255, green: 23/255, blue: 48/255), forground: Color.white), //thyrian purple,
    myColors(background: Color(red:0/255, green: 217/255, blue: 192/255), forground: Color.white)//türkis
    
    
]
*/


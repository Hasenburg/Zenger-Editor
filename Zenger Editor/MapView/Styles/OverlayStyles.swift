//
//  OverlayStyles.swift
//  Zenger Editor
//
//  Created by Sebastian Haslberger on 11.03.23.
//

import MapKit


extension MKPolyline {
    struct ColorHolder {
        static var _color: UIColor?
    }
    var color: UIColor? {
        get {
            return ColorHolder._color
        }
        set(newValue) {
            ColorHolder._color = newValue
        }
    }
}

extension MKCircle {
	struct ColorHolder {
		static var _color: UIColor?
	}
	var color: UIColor? {
		get {
			return ColorHolder._color
		}
		set(newValue) {
			ColorHolder._color = newValue
		}
	}
}

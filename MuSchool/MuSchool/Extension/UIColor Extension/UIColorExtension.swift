//
//  UIColorExtension.swift
//  MuSchool
//
//  Created by Evince Development on 20/09/21.
//

import Foundation
import UIKit
import SwiftUI

extension UIColor {
    static var appTheme: UIColor {
        get {
            return UIColor.init(red: 10/255, green: 25/255, blue: 70/255, alpha: 1)
        }
    }
    
    static var lightBackground: UIColor {
        get {
            return UIColor.init(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        }
    }
}

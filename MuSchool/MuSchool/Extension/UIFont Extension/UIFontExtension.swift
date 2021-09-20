//
//  UIFontExtension.swift
//  MuSchool
//
// Created by Evince Development on 20/09/21.
//

import Foundation
import UIKit
import SwiftUI

extension Font {
    
    static func CustomBold(size: CGFloat) -> Font {
        Font.custom(ConstantManager.FontNames.kCustomBold, size: size)
    }
    
    static func CustomHeavy(size: CGFloat) -> Font {
        Font.custom(ConstantManager.FontNames.kCustomHeavy, size: size)
    }
    
    static func CustomLight(size: CGFloat) -> Font {
        Font.custom(ConstantManager.FontNames.kCustomLight, size: size)
    }
    
    static func CustomMedium(size: CGFloat) -> Font {
        Font.custom(ConstantManager.FontNames.kCustomMedium, size: size)
    }
    
    static func CustomRegular(size: CGFloat) -> Font {
        Font.custom(ConstantManager.FontNames.kCustomRegular, size: size)
    }
    
    static func CustomSemiBold(size: CGFloat) -> Font {
        Font.custom(ConstantManager.FontNames.kCustomSemiBold, size: size)
    }
}

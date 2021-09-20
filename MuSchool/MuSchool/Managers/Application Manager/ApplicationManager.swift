//
//  ApplicationManager.swift
//  MuSchool
//
//  Created by Evince Development on 20/09/21.
//

import Foundation
import IQKeyboardManagerSwift
import SwiftUI

class ApplicationManager {
    
    static let shared  = ApplicationManager()
    
    private init() {}
    
    func prepareThirdParty() {
        ReachabilityManager.shared.doSetupReachability()
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.toolbarTintColor = UIColor.appTheme
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = LocalizableConstants.ButtonNames.done
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.previousNextDisplayMode = .default
    }
}

//
//  ConstantManager.swift
//  MuSchool
//
//  Created by Evince Development on 20/09/21.
//

import Foundation
import UIKit

struct ConstantManager {
    
    // Userdefault constants
    
    static var scenedelegate : SceneDelegate {
        return UIApplication.shared.delegate as! SceneDelegate
    }
    
    static var appdelegate : AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    struct BaseURL {
        static let apiBaseUrl =  "http://api.coinlayer.com/"
    }
    
    struct APINames {
        static let cryptoList = "list?\(APIKey.kaccess_key)=\(APIKey.kAPIKey)"
        static let currentRateList = "live?\(APIKey.kaccess_key)=\(APIKey.kAPIKey)"
    }
    
    struct userdefaultKeys {
        static let nointernet = "noInternet"
    }
    
    struct appcolorNames {
        static let AppThemeColor = "AppTheme"
        static let AppThemeColorSecond = "AppThemeSecond"
        static let offWhite = "OffWhite"
    }
    
    struct FontNames {
        static let kCustomBold = "Gilroy-Bold"
        static let kCustomHeavy = "Gilroy-Heavy"
        static let kCustomLight = "Gilroy-Light"
        static let kCustomMedium = "Gilroy-Medium"
        static let kCustomRegular = "Gilroy-Regular"
        static let kCustomSemiBold = "Gilroy-SemiBold"
    }
}

// MARK: - INTERNET CHECK
func IS_INTERNET_AVAILABLE() -> Bool {
    return ReachabilityManager.shared.isInternetAvailableForAllNetworks()
}

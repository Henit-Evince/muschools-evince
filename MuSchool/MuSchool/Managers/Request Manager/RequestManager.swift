//
//  RequestManager.swift
//  MuSchool
//
// Created by Evince Development on 20/09/21.
//

import Foundation
import UIKit
import SwiftUI
import Alamofire

typealias SuccessHandler = (_ result:Any , _ status : Int) -> Void
typealias FailureHandler = (_ error:Error) -> Void

class RequestManager: NSObject {
    class func postAPI(urlPart:String,parameters:Dictionary<String,Any>,successResult:@escaping SuccessHandler,failureResult:@escaping FailureHandler){
        let accessToken = UserDefaults.standard.object(forKey: "LIAccessToken")
        let header : HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(accessToken ?? "")"
        ]
        
        //            view.showIndicator()
        var finalUrl = ConstantManager.BaseURL.apiBaseUrl + urlPart
        
        finalUrl = finalUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        print("\n\nfinal URL For POST is \(finalUrl) \n and Header is \(header) \n\n Parameter is \n \(parameters)")
        
        AF.request(finalUrl, method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted, headers: header).responseJSON { (response) in
            //                view.hideIndicator()
            switch response.result {
            case let .success(value):
                successResult(value, (response.response?.statusCode)!)
            case let .failure(error):
                failureResult(error)
            }
        }
    }
}

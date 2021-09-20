//
//  ReachabilityManager.swift
//  MuSchool
//
//  Created by Evince Development on 20/09/21.
//

import Foundation
import Reachability
import Alamofire

class ReachabilityManager: NSObject {
    
    var reachability = try! Reachability()
    
    // MARK: - SHARED MANAGER
    static let shared: ReachabilityManager =  ReachabilityManager()
    var didChangeReachabilityStatus: ((Bool)->Void)?
    
    func isInternetAvailableForAllNetworks() -> Bool {
        return Connectivity.isConnectedToInternet //(reachability.connection != .unavailable)
    }
    
    func doSetupReachability() {
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        
        reachability.whenReachable = { reachability in
            if let validReachabilityChangeHandler = self.didChangeReachabilityStatus {
                if reachability.connection == .wifi {
                    print("Reachable via WiFi")
                } else {
                    print("Reachable via Cellular")
                }
                validReachabilityChangeHandler(true)
            } else {
                
            }
        }
        
        reachability.whenUnreachable = { reachability in
            if let validReachabilityChangeHandler = self.didChangeReachabilityStatus {
                print("Not reachable")
                validReachabilityChangeHandler(false)
            } else {
                
            }
        }
        
        do {
            try reachability.startNotifier()
        }
        catch {
            print("Unable to start notifier")
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi:
            print("Reachable via WiFi")
        case .cellular:
            print("Reachable via Cellular")
        case .unavailable:
            print("Network not reachable")
        case .none:
            print("Network none")
        }
    }
    
    deinit {
        reachability.stopNotifier()
    }
}

class Connectivity {
    class var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}

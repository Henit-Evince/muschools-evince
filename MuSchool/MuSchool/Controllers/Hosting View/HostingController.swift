//
//  HostingController.swift
//  MuSchool
//
//  Created by Evince Development on 20/09/21.
//


import Foundation
import SwiftUI

class HostingController<ContentView>: UIHostingController<ContentView> where ContentView : View {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
}

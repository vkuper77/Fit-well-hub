//
//  Fit_well_hubApp.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 5.12.23.
//

import SwiftUI

@main
struct Fit_well_hubApp: App {
    @State private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(modelData)
        }
    }
}

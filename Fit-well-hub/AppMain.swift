//
//  Fit_well_hubApp.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 5.12.23.
//

import SwiftUI

@main
struct AppMain: App {
    @State private var modelData = CreateTrainingProgramViewModel()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(modelData)
        }
    }
}

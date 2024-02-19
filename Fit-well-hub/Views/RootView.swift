//
//  RootView.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 17.12.23.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var app: AppViewModel
        
    var body: some View {
        if app.isFirstRunApp && !app.isAuth {
            OnboardingView()
        } else if !app.isFirstRunApp && !app.isAuth {
            RegistrationView()
        } else if app.isAuth {
            MainTabView()
        }
        
    }
}

#Preview {
    RootView()
}

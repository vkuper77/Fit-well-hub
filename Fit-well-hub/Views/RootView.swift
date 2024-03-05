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
        Group {
            if shouldShowOnboardingView {
                OnboardingView()
            } else if shouldShowRegistrationView {
                RegistrationView()
            } else if app.isAuth {
                MainTabView()
            }
        }
    }
    
    private var shouldShowOnboardingView: Bool {
        return app.isFirstRunApp && !app.isAuth
    }
    
    private var shouldShowRegistrationView: Bool {
        return !app.isFirstRunApp && !app.isAuth
    }
}

#Preview {
    RootView()
}

//
//  MainTabView.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 19.02.24.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var app: AppViewModel
    var body: some View {
        Text("Authenticated")
        Spacer().frame(height: 50)
        Button("Logout") {
            Task {
                do {
                    try await Authentication.logout()
                    app.isAuth = false
                    UserDefaults.standard.removeObject(forKey: KeysLocalStorage.accessToken.rawValue)
                    UserDefaults.standard.removeObject(forKey: KeysLocalStorage.refreshToken.rawValue)
                } catch {
                    print("Error logging out: \(error)")
                }
            }
        }
    }
}

#Preview {
    MainTabView()
}

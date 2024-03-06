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
                try await app.logout()
            }
        }
    }
}

#Preview {
    MainTabView()
}

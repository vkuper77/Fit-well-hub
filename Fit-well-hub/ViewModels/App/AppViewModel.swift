//
//  AppViewModel.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 19.02.24.
//

import SwiftUI

@MainActor class AppViewModel: ObservableObject {
    @Published var isFirstRunApp = true
    @Published var isAuth = false
    
    init() {
        initApp()
    }
    
    private func initApp() -> Void {
        if UserDefaults.standard.bool(forKey: "hasAppRunBefore") {
            isFirstRunApp = false
        } else {
            isFirstRunApp = true
            UserDefaults.standard.set(true, forKey: "hasAppRunBefore")
        }
        
        if UserDefaults.standard.bool(forKey: "isAuth") {
            isAuth = false
        } else {
            isAuth = true
            UserDefaults.standard.set(true, forKey: "isAuth")
        }
        
//        let isHasToken = ((UserDefaults.standard.string(forKey: KeysLocalStorage.accessToken.rawValue)) != nil)
//        isAuth = isHasToken
        
    }
    
    func logout() async throws -> Void {
        do {
            isAuth = false
            UserDefaults.standard.removeObject(forKey: "isAuth")
            try await Authentication.logout()
        } catch {
            print("Error logging out: \(error)")
        }
    }
}



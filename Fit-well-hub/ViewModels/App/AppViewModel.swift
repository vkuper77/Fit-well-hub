//
//  AppViewModel.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 19.02.24.
//

import SwiftUI

class AppViewModel: ObservableObject {
    
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
        let isHasToken = ((UserDefaults.standard.string(forKey: KeysLocalStorage.accessToken.rawValue)) != nil)
        isAuth = isHasToken
    }
}



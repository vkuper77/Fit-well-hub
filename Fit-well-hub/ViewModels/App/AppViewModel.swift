//
//  AppViewModel.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 19.02.24.
//

import SwiftUI

final class AppViewModel: ObservableObject {
    
    @Published var isFirstRunApp = true
    @Published var isAuth = false
    
    init() {
        initApp()
    }
    
    private func initApp() -> Void {
        let isHasToken = ((UserDefaults.standard.string(forKey: KeysLocalStorage.accessToken.rawValue)) != nil)
        isAuth = isHasToken
        isFirstRunApp = !isHasToken
    }
}



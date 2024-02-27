//
//  AuthorizationViewModel.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 19.02.24.
//

import SwiftUI

@MainActor class AuthorizationViewModel: ObservableObject {
    @Published var isLinkRegistrationScreen: Bool = false
    @Published var isLinkCreatePasswordScreen: Bool = false
    
    @Published var login: String = ""
    @Published var password: String = ""
    
    @Published var isLoading: Bool = false
    @Published var isShowPass: Bool = false

    @Published var errorMessage: String = ""
    @Published var isErrorEmail: Bool = false
    
    func submit () async throws -> Void {
        guard login.isValidEmail else {
            isErrorEmail = true
            return
        }
        
        isLoading = true
        do {
            let requestBody = ["email": login, "password": password]
            try await Authentication.login(requestBody: requestBody)
            isLoading = false
        }catch {
            isLoading = false
            switch error {
            case FetchError.customError(let message):
                self.errorMessage = parseErrorMessage(message: message)
            default:
                print("An unknown error occurred")
            }
            throw error
        }
        
    }
    
    var isButtonEnabled: Bool {
        login.count > 0 && password.count > 0 && errorMessage.isEmpty && !isErrorEmail
    }
}

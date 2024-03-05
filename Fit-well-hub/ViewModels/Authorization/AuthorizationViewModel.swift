//
//  AuthorizationViewModel.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 19.02.24.
//

import SwiftUI

@MainActor class AuthorizationViewModel: ObservableObject {
    // MARK: - Published Properties
        @Published var isLinkRegistrationScreen: Bool = false
        @Published var isLinkCreatePasswordScreen: Bool = false
        @Published var login: String = ""
        @Published var password: String = ""
        @Published var isLoading: Bool = false
        @Published var isShowPass: Bool = false
        @Published var errorMessage: String = ""
        @Published var isErrorEmail: Bool = false
        
        // MARK: - Computed Properties
        var isButtonEnabled: Bool {
            return !login.isEmpty && !password.isEmpty && errorMessage.isEmpty && !isErrorEmail
        }
        
        // MARK: - Methods
        func submit() async throws {
            guard login.isValidEmail else {
                isErrorEmail = true
                throw FetchError.customError("Неверный формат email")
            }
            
            isLoading = true
            do {
                let requestBody = ["email": login, "password": password]
                try await Authentication.login(requestBody: requestBody)
                isLoading = false
            } catch {
                isLoading = false
                switch error {
                case FetchError.customError(let message):
                    self.errorMessage = parseErrorMessage(message: message)
                default:
                    print("Произошла неизвестная ошибка")
                }
                throw error
            }
        }
}

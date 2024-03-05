//
//  PasswordRecoveryViewModel.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 4.03.24.
//

import Foundation

@MainActor class PasswordRecoveryViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var errorMessage: String = ""
    @Published var isLinkActive: Bool = false
    @Published var isLoading: Bool = false
    
    var isButtonEnabled: Bool {
        return !email.isEmpty && errorMessage.isEmpty
    }
    
    func submit () async throws -> Void {
        guard email.isValidEmail else {
            errorMessage = "Неправильный формат электронной почты."
            return
        }
        
        isLoading = true
        
        do {
            let requestBody = ["email": email]
            try await Authentication.sendCode(requestBody: requestBody)
            isLinkActive = true
        } catch {
            switch error {
            case FetchError.customError(let message):
                self.errorMessage = parseErrorMessage(message: message)
            default:
                print("An unknown error occurred")
            }
        }
        
        isLoading = false
    }
}

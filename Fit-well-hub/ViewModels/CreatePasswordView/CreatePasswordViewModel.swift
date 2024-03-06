//
//  CreatePasswordViewModel.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 5.03.24.
//

import Foundation

@MainActor class CreatePasswordViewModel: ObservableObject {
    @Published var isLinkActive: Bool = false
    
    @Published var password: String = ""
    @Published var repeatPassword: String = ""
    
    @Published var isShowPass: Bool = false
    @Published var errorMessage: String = ""
    
    @Published var isLoading: Bool = false
    
    var isButtonEnabled: Bool {
        return !password.isEmpty
        && !repeatPassword.isEmpty
        && errorMessage.isEmpty
    }
    
    func submit () async throws -> Void {
        guard password == repeatPassword else {
            errorMessage = "Пароль не совпадают"
            return
        }
        
        isLoading = true
        
        do {
            let requestBody = ["password": password]
            try await Authentication.changePassword(requestBody: requestBody)
            
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

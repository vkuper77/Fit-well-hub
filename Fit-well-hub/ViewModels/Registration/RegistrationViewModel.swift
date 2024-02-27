//
//  RegistrationModel.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 18.02.24.
//

import SwiftUI

@MainActor final class RegistrationViewModel: ObservableObject {
    @Published var isLinkActiveCodeScreen: Bool = false
    @Published var isLinkAuthorizationScreen: Bool = false
    
    @Published var email: String = ""
    @Published var pass: String = ""
    @Published var repeatPass: String = ""
    
    @Published var isShowPass: Bool = false
    @Published var isLoading: Bool = false
    
    @Published var errorMessage: String = ""
    @Published var isErrorEmail: Bool = false
    @Published var isErrorPass: Bool = false
    
    var isButtonEnabled: Bool {
        return !pass.isEmpty
        && !repeatPass.isEmpty
        && !email.isEmpty
        && errorMessage.isEmpty
        && !isErrorEmail
        && !isErrorPass
    }
    
    func clear () {
        errorMessage = ""
        isErrorEmail = false
        email = ""
    }
    
    func submit () {
        guard email.isValidEmail else {
            isErrorEmail = true
            return
        }
        
        guard pass == repeatPass else {
            isErrorPass = true
            return
        }
        
        Task {
            self.isLoading = true
            
            do {
                let requestBody = ["email": email, "password": pass]
                let (responseData) = try await Authentication.registerUsser(requestBody: requestBody)
                self.isLinkActiveCodeScreen = true
                
                let decoder = JSONDecoder()
                let data = try decoder.decode(UserResponse.self, from: responseData)
                print(data)
            } catch {
                switch error {
                case FetchError.customError(let message):
                    self.errorMessage = parseErrorMessage(message: message)
                default:
                    print("An unknown error occurred")
                }
            }
            
            self.isLoading = false
        }
    }
}

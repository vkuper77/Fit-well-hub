//
//  CodeViewModel.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 25.02.24.
//

import Foundation

@MainActor class CodeViewModel: ObservableObject {
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    
    func activateCode(code: String) async throws -> Void {
        do {
            let requestBody = ["code": code]
            try await Authentication.activateUser(requestBody: requestBody)
        } catch {
            switch error {
            case FetchError.customError(let message):
                self.errorMessage = parseErrorMessage(message: message)
                removeErrorMessageAfterDelay()
            default:
                print("An unknown error occurred")
            }
            throw error
        }
    }
    
    func sendCodeRegistration() async throws -> Void {
        do {
            try await Authentication.sendCodeRegistration()
        } catch {
            switch error {
            case FetchError.customError(let message):
                self.errorMessage = parseErrorMessage(message: message)
                removeErrorMessageAfterDelay()
            default:
                print("An unknown error occurred")
            }
            throw error
        }
    }
    
    func sendCode(email: String) async throws -> Void {
        do {
            let requestBody = ["email": email]
            try await Authentication.sendCode(requestBody: requestBody)
        } catch {
            switch error {
            case FetchError.customError(let message):
                self.errorMessage = parseErrorMessage(message: message)
                removeErrorMessageAfterDelay()
            default:
                print("An unknown error occurred")
            }
            throw error
        }
    }
    
    func validateCode(code: String) async throws -> Void {
        do {
            let requestBody = ["code": code]
            try await Authentication.validateCode(requestBody: requestBody)
        } catch {
            switch error {
            case FetchError.customError(let message):
                self.errorMessage = parseErrorMessage(message: message)
                removeErrorMessageAfterDelay()
            default:
                print("An unknown error occurred")
            }
            throw error
        }
    }
    
    private func removeErrorMessageAfterDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.errorMessage = ""
        }
    }
}

//
//  Authentication.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 25.02.24.
//

import Foundation


class Authentication {
    static func registerUsser(requestBody: [String: String]) async throws -> Data {
        try await instance.post(route: "/registration", body: requestBody)
    }
    
    static func activateUser(requestBody: [String: String]) async throws -> Data {
        try await instance.post(route: "/activate", body: requestBody)
    }
    
    static func sendCode() async throws -> Data {
        try await instance.post(route: "/resendCode", body: nil)
    }
    
    static func login(requestBody: [String: String]) async throws -> Data {
        try await instance.post(route: "/login", body: requestBody)
    }
    
    static func logout() async throws -> Data {
        try await instance.post(route: "/logout", body: nil)
    }
}

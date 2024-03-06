//
//  NetworkManager.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 25.02.24.
//
import SwiftUI

enum FetchError: Error {
    case invalidResponse
    case httpError(Int)
    case decodingError
    case refreshTokenError
    case customError(String)
}

struct ResponseData: Decodable {
    let accessToken: String?
    let refreshToken: String?
}

//func clearTokens() {
//    UserDefaults.standard.removeObject(forKey: KeysLocalStorage.accessToken.rawValue)
//    UserDefaults.standard.removeObject(forKey: KeysLocalStorage.refreshToken.rawValue)
//}

class NetworkManager {
    private let baseUrl: String
    
    @AppStorage(KeysLocalStorage.accessToken.rawValue) private var accessToken: String?
    @AppStorage(KeysLocalStorage.refreshToken.rawValue) private var refreshToken: String?
    
    init(url: String) {
        self.baseUrl = url
        self.accessToken = UserDefaults.standard.string(forKey: KeysLocalStorage.accessToken.rawValue)
    }
    
    func get(route: String) async throws -> Data {
        let url = "\(baseUrl)\(route)"
        let (data) = try await fetchData(url: url, method: "GET", headers: getHeaders())
        await handleAuthorizationResponse(data)
        return data
    }
    
    func post(route: String, body: Any?) async throws -> Data {
        let url = "\(baseUrl)\(route)"
        let (data) = try await fetchData(url: url, method: "POST", headers: getHeaders(), body: body)
        await handleAuthorizationResponse(data)
        return data
    }
    
    func put(route: String, body: Any) async throws -> Data {
        let url = "\(baseUrl)\(route)"
        let (data) = try await fetchData(url: url, method: "PUT", headers: getHeaders(), body: body)
        await handleAuthorizationResponse(data)
        return data
    }
    
    func delete(route: String) async throws -> Data {
        let url = "\(baseUrl)\(route)"
        let (data) = try await fetchData(url: url, method: "DELETE", headers: getHeaders())
        await handleAuthorizationResponse(data)
        return data
    }
    
    private func getHeaders() -> [String: String] {
        var headers = ["Content-Type": "application/json"]
        if let token = accessToken {
            headers["Authorization"] = "Baerer \(token)"
        }
        return headers
    }
    
    private func handleAuthorizationResponse(_ data: Data) async {
        let decoder = JSONDecoder()
        if let responseData = try? decoder.decode(ResponseData.self, from: data) {
            if let accessToken = responseData.accessToken {
                self.accessToken = accessToken
            }
            if let refreshToken = responseData.refreshToken {
                self.refreshToken = refreshToken
            }
        }
    }
    
    private func fetchData(url: String, method: String, headers: [String: String], body: Any? = nil) async throws -> (Data) {
        guard let url = URL(string: url) else {
            throw FetchError.customError("Invalid URL")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        for (key, value) in headers {
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        if let body = body {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse, !(200..<300).contains(httpResponse.statusCode) {
            if let errorMessage = String(data: data, encoding: .utf8) {
                throw FetchError.customError(errorMessage)
            } else {
                throw FetchError.customError("Server error")
            }
        }
        
        return (data)
    }
}

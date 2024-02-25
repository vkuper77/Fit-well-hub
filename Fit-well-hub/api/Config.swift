//
//  Config.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 25.02.24.
//

import Foundation

enum KeysLocalStorage: String {
    case accessToken
    case refreshToken
}

struct NetworkConfiguration {
    static var baseUrl: String = "http://localhost:3000/api"
}

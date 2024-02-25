//
//  User.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 25.02.24.
//

import Foundation

struct User: Decodable, Identifiable {
    let id: String
    let email: String
    let isActivated: Bool
}

struct UserResponse: Decodable {
    let accessToken: String
    let refreshToken: String
    let user: User
}

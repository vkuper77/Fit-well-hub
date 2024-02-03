//
//  helpers.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 17.12.23.
//

import Foundation

func isValidEmail(_ email: String) -> Bool {
    let emailRegex = #"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"#
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
    return emailPredicate.evaluate(with: email)
}

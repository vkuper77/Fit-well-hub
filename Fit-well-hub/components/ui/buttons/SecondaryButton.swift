//
//  SecondaryButton.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 9.12.23.
//

import SwiftUI

struct SecondaryButton: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.system(size: 16))
            .frame(maxWidth: .infinity)
            .frame(height: 54)
            .cornerRadius(6)
            .foregroundColor(Color("black"))
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color("black"), lineWidth: 1)
            )
    }
}

#Preview {
    SecondaryButton(title: "Title")
}

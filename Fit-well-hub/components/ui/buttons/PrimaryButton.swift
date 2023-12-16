//
//  PrimaryButton.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 9.12.23.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.system(size: 16))
            .frame(maxWidth: .infinity)
            .frame(height: 54)
            .foregroundColor(.white)
            .background(Color("black"))
            .cornerRadius(6)
    }
}

#Preview {
    PrimaryButton(title: "Title")
}

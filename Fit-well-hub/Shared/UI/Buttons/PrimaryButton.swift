//
//  PrimaryButton.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 9.12.23.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    let loading: Bool
    var body: some View {
        VStack{
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [.secondaryOrange, .primaryOrange]),
                    startPoint: UnitPoint(x: 0, y: 0),
                    endPoint: UnitPoint(x: 1, y: 1)
                )
                if loading {
                    ProgressView().tint(Color.white)
                } else {
                    Text(title)
                        .font(.custom("MontserratAlternates-SemiBold", size: 16))
                        .foregroundColor(.white)
                }
            }
        }
        .frame(height: 60)
        .frame(maxWidth: .infinity)
        .cornerRadius(20)
    }
}

#Preview {
    PrimaryButton(title: "Title", loading: false)
}

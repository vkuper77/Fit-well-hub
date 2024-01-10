//
//  BackButton.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 16.12.23.
//

import SwiftUI

struct BackButton: View {

    let action: () -> Void
    var colorPrimary = Color(.black)
    var colorSecondary = Color(.white)
    
    var body: some View {
        Button(action: {
            action()
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 13)
                    .fill(colorPrimary)
                    .frame(width: 48, height: 48)
                Image(systemName: "chevron.left")
                    .resizable()
                    .frame(width: 8, height: 14)
                    .foregroundColor(colorSecondary)
            }
        }
    }
}

#Preview {
    BackButton(action: {
        print("press")
    }, colorPrimary: .black, colorSecondary: .white)
}

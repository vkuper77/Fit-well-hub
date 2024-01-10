//
//  BackButton.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 16.12.23.
//

import SwiftUI

struct BackButton: View {

    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 13)
                    .fill(Color("orange-secondary"))
                    .frame(width: 48, height: 48)
                Image(systemName: "chevron.left")
                    .resizable()
                    .frame(width: 8, height: 14)
                    .foregroundColor(.white)
            }
        }
    }
}

#Preview {
    BackButton {
        print("press BackButton")
    }
}

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
            Image(systemName: "chevron.backward.circle.fill")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(Color("grey"))
        }
    }
}

#Preview {
    BackButton {
        print("press BackButton")
    }
}

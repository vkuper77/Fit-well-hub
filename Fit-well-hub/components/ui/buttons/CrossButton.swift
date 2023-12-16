//
//  CrossButton.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 16.12.23.
//

import SwiftUI

struct CrossButton: View {
    let action: () -> Void
    var body: some View {
        Button(action: {
            action()
        }) {
            Image(systemName: "xmark.circle.fill")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(Color("grey"))
        }
    }
}

#Preview {
    CrossButton {
        print("press CrossButton")
    }
}

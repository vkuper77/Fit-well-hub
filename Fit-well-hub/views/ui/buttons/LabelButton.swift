//
//  LabelButton.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 10.01.24.
//

import SwiftUI

struct LabelButton: View {
    var selected: Bool
    var title: String
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 13)
                    .fill(selected ? Color("orange-secondary") : Color("grey-light"))
                    .frame(width: 48, height: 48)
                Text(title)
                    .font(.custom("MontserratAlternates-SemiBold", size: 16))
                    .textCase(.uppercase)
                    .foregroundColor(selected ? .white : Color("black-primary"))
            }.frame(width: 48, height: 48)
        }
        .frame(width: 48, height: 48)
        .cornerRadius(13)
    }
}

#Preview {
    LabelButton(selected: true, title: "пн")
}

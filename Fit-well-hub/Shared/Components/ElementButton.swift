//
//  ElementButton.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 9.01.24.
//

import SwiftUI

struct ElementButton: View {
    
    var selected: Bool
    var title: String
    var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center, spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(title)
                        .font(.custom("MontserratAlternates-SemiBold", size: 16))
                        .foregroundColor(selected ? .white : .primaryBlack)
                    Text(text)
                        .font(.custom("MontserratAlternates-Regular", size: 16))
                        .foregroundColor(selected ? .white : .primaryBlack)
                        .multilineTextAlignment(.leading)
                }.frame(maxWidth: .infinity, alignment: .leading)
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .frame(width: 38, height: 38)
                    .foregroundColor(selected ? .white : .secondaryGrey)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 24)
        .padding(.horizontal, 16)
        .background(selected ? Color.secondaryOrange : Color.secondaryGrey)
        .cornerRadius(13)
    }
}

#Preview {
    ElementButton(selected: true, title: "Title", text: "tetxt text text")
}

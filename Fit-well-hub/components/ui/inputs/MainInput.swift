//
//  MainInput.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 16.12.23.
//

import SwiftUI

struct MainInput: View {
    @Binding var value: String
    var placeholder: String
    var maxCharacterCount: Int?
    
    var body: some View {
        ZStack(alignment: .trailing) {
            TextField(placeholder, text: $value)
                .padding(EdgeInsets(top: 18, leading: 16, bottom: 18, trailing: 16))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("grey"), lineWidth: 1)
                )
                .font(.system(size: 16))
                .foregroundColor(Color("black"))
                if let maxCount = maxCharacterCount {
                    Text("\(value.count)/\(maxCount)")
                        .foregroundColor(Color("grey-light"))
                        .font(.system(size: 16))
                        .padding(.trailing, 16)
                }
        }
        .onChange(of: value) { newValue in
            if let maxCount = maxCharacterCount, newValue.count > maxCount {
                value = String(newValue.prefix(maxCount))
            }
        }
        Spacer().frame(height: 0)
    }
}

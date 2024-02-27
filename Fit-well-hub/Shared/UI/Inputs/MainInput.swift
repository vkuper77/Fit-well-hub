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
    var label: String
    
    var maxCharacterCount: Int?
    var isError: Bool?
    
    var body: some View {
        ZStack(alignment: .leading) {
            TextField(placeholder, text: $value)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .padding(EdgeInsets(top: 20, leading: 24, bottom: 20, trailing: 24))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(isError ?? false ? Color.primaryError : Color.secondaryOrange, lineWidth: 1)
                )
                .font(.custom("MontserratAlternates-Regular", size: 16))
                .foregroundColor(.primaryBlack)
            
                HStack(alignment: .center, spacing: 0) {
                    RoundedRectangle(cornerRadius: 0)
                        .fill(.white)
                        .frame(width: 5, height: 12)
                    Text(label)
                        .font(.custom("MontserratAlternates-Bold", size: 10))
                        .background(.white)
                        .foregroundColor(.primaryOrange)
                    RoundedRectangle(cornerRadius: 0)
                        .fill(.white)
                        .frame(width: 5, height: 21)
                }.padding(EdgeInsets(top: -42, leading: 24, bottom: 0, trailing: 0))
        }
        .onChange(of: value) {_ , newValue in
            if let maxCount = maxCharacterCount, newValue.count > maxCount {
                value = String(newValue.prefix(maxCount))
            }
        }
        Spacer().frame(height: 0)
    }
}

#Preview {
    MainInput(value: .constant(""), placeholder: "ыыыы", label: "Emal", isError: false)
}

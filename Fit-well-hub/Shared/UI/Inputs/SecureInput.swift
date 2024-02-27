//
//  SecureInput.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 17.12.23.
//

import SwiftUI

struct SecureInput: View {
    @Binding var value: String
    @Binding var isShowValue: Bool
    
    @FocusState private var isTextFieldFocused: Bool
    @FocusState private var isSecureFieldFocused: Bool
    
    var label: String
    var placeholder: String
    var isShowIcon: Bool
    var isError: Bool?
    
    var body: some View {
        ZStack(alignment: .leading) {
            ZStack(alignment: .trailing) {
                VStack{
                        if isShowValue {
                            TextField(placeholder, text: $value)
    //                        .focused($isTextFieldFocused)
                        } else {
                            SecureField(placeholder, text: $value)
    //                        .focused($isSecureFieldFocused)
                        }
                    }
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .frame(height: 21)
                    .padding(EdgeInsets(top: 20, leading: 24, bottom: 20, trailing: 24))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(isError ?? false ? Color.primaryError : Color.secondaryOrange, lineWidth: 1)
                    )
                    .font(.custom("MontserratAlternates-Regular", size: 16))
                    .foregroundColor(.primaryBlack)
                
                if isShowIcon {
                    Image(systemName: isShowValue ? "eye.slash.fill" : "eye.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 17, height: 17)
                        .foregroundColor(.primaryOrange)
                        .padding(.trailing, 16)
                        .onTapGesture {
                            isShowValue.toggle()
    //                        if isShowValue {
    //                            isTextFieldFocused = true
    //                        } else {
    //                            isSecureFieldFocused = true
    //                        }
                        }
                }
            }
            Spacer().frame(height: 0)
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
    }
}

#Preview {
    SecureInput(value: .constant(""), isShowValue: .constant(false), label: "Пароль", placeholder: "Введите пароль...", isShowIcon: true)
}

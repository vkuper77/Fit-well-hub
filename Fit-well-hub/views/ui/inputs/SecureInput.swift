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
    
    var placeholder: String
    var isShowIcon: Bool
    
    var body: some View {
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
                .padding(EdgeInsets(top: 18, leading: 16, bottom: 18, trailing: 16))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("grey"), lineWidth: 1)
                )
                .font(.system(size: 16))
                .foregroundColor(Color("black-custom"))
            
            if isShowIcon {
                Image(systemName: isShowValue ? "eye.slash.fill" : "eye.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color("black"))
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
    }
}

#Preview {
    SecureInput(value: .constant(""), isShowValue: .constant(false), placeholder: "sss", isShowIcon: true)
}

//
//  CreatePasswordScreenView.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 17.12.23.
//

import SwiftUI

struct CreatePasswordView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var isLinkActive: Bool = false
    
    @State var pass: String = ""
    @State var repeatPass: String = ""
    
    @State var isShowPass: Bool = false
    @State var isErrorPass: Bool = false
    
    var isButtonEnabled: Bool {
           return !pass.isEmpty
        && !repeatPass.isEmpty
        && !isErrorPass
    }
    
    func submit () {
        
        if pass != repeatPass {
            isErrorPass = true
        } else {
            isLinkActive = true
        }
        
    }
    
    var body: some View {
        NavigationStack {
            MaskScreenView(topComponent: VStack {
                Spacer().frame(height: 40)
                Text("Восстановление пароля")
                    .font(.custom("MontserratAlternates-Bold", size: 24))
                    .foregroundColor(.white)
                Spacer().frame(height: 16)
                Text("Придумайте новый пароль")
                    .font(.custom("MontserratAlternates-Regular", size: 16))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                Spacer().frame(height: 34)
            }, bottomComponent: VStack {
                Spacer().frame(height: 62)
                
                VStack {
                    SecureInput(value: $pass, isShowValue: $isShowPass, label: "Пароль", placeholder: "Введите пароль...", isShowIcon: true)
                    Spacer().frame(height: 16)
                    SecureInput(value: $repeatPass, isShowValue: $isShowPass, label: "Пароль", placeholder: "Повторите пароль...", isShowIcon: false)
                }.onChange(of: repeatPass) {
                    isErrorPass = false
                }.onChange(of: pass) {
                    isErrorPass = false
                }
                
                if isErrorPass {
                    Spacer().frame(height: 4)
                    HStack {
                        Text("Пароли не совпадают")
                            .multilineTextAlignment(.leading)
                            .font(.custom("MontserratAlternates-Regular", size: 12))
                            .foregroundColor(.primaryError)
                            Spacer()
                    }
                    .padding(.leading, 16)
                }
                
                Spacer().frame(height: 24)
                
                Button {
                    submit()
                } label: {
                    PrimaryButton(title: "Подтвердить", loading: false)
                        .opacity(!isButtonEnabled ? 0.5 : 1)
                }
                
                Spacer()
            }.padding(.horizontal, 16))
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    BackButton(action: { presentationMode.wrappedValue.dismiss() }, colorPrimary: .white, colorSecondary: .secondaryOrange
                    )
                }
            }
            NavigationLink(destination: AuthorizationView(), isActive: $isLinkActive) {
                EmptyView()
            }
        }
    }
}

#Preview {
    CreatePasswordView()
}

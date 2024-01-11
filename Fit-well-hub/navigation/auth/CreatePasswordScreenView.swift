//
//  CreatePasswordScreenView.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 17.12.23.
//

import SwiftUI

struct CreatePasswordScreenView: View {
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
            VStack {
                Spacer().frame(height: 33)
                SecureInput(value: $pass, isShowValue: $isShowPass, label: "pass", placeholder: "Пароль", isShowIcon: true)
                Spacer().frame(height: 12)
                SecureInput(value: $repeatPass, isShowValue: $isShowPass, label: "pass", placeholder: "Повторите пароль", isShowIcon: false)
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
                        .font(.system(size: 12))
                        .foregroundColor(Color("error"))
                        Spacer()
                }
                .padding(.leading, 16)
            }
            
            Spacer().frame(height: 12)
            
            Button {
                submit()
            } label: {
                PrimaryButton(title: "Подтвердить")
                    .opacity(!isButtonEnabled ? 0.4 : 1)
            }
            
            Spacer()
                .navigationBarBackButtonHidden(true)
                .navigationBarTitle("Создайте новый пароль", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        BackButton { presentationMode.wrappedValue.dismiss() }
                    }
                }
            
            NavigationLink(destination: AuthorizationScreenView(), isActive: $isLinkActive) {
                EmptyView()
            }
            
        }.padding(.horizontal, 16)
    }
}

#Preview {
    CreatePasswordScreenView()
}

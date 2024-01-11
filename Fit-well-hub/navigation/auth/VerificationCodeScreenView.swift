//
//  VerificationСodeScreenView.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 17.12.23.
//

import SwiftUI

struct VerificationCodeScreenView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var code: String = ""
    @State var isLinkActive: Bool = false
    
    func submit() {
        isLinkActive = true
    }
    
    var body: some View {
        NavigationStack{
            Spacer().frame(height: 48)
            
            Text("Код отправлен на почту")
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(Color("black-custom"))
            
            Text("r.sanchez1992gmail.com")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(Color("black-custom"))
            
            Spacer().frame(height: 16)
            
            MainInput(value: $code, placeholder: "Код", label: "Код")
                .onSubmit {
                    submit()
                }
            Spacer()
            
            Text("Запросить код \(Text("еще раз.").underline(true, color: Color("black-custom")))")
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(Color("black-custom"))
                .onTapGesture {
                    print("press")
                }
            
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("Код верификации", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    BackButton { presentationMode.wrappedValue.dismiss() }
                }
            }
            
            NavigationLink(destination: CreatePasswordScreenView(), isActive: $isLinkActive) {
                EmptyView()
            }
            
        }.padding(EdgeInsets(top: 0, leading: 16, bottom: 32, trailing: 16) )
    }
}

#Preview {
    VerificationCodeScreenView()
}

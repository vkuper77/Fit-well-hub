//
//  VerificationСodeScreenView.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 17.12.23.
//

import SwiftUI

struct VerificationCodeView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var code: String = ""
    @State private var isLinkActive: Bool = false
    
    func submit() {
        isLinkActive = true
    }
    
    var body: some View {
        NavigationStack{
            MaskScreenView(topComponent: VStack {
                Spacer().frame(height: 40)
                Text("Восстановление пароля")
                    .font(.custom("MontserratAlternates-Bold", size: 24))
                    .foregroundColor(.white)
                Spacer().frame(height: 16)
                Text("Код отправлен на email")
                    .font(.custom("MontserratAlternates-Regular", size: 16))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                Text("r.sanchez1992gmail.com")
                    .font(.custom("MontserratAlternates-Semibold", size: 16))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                Spacer().frame(height: 34)
            }, bottomComponent: VStack {               
                Spacer().frame(height: 62)
                CodeInput(numberOfFiled: 4)
                Spacer()
                Text("Запросить код \(Text("еще раз.").underline(true, color: Color.secondaryOrange))")
                    .font(.custom("MontserratAlternates-Regular", size: 16))
                    .foregroundColor(.secondaryOrange)
                    .onTapGesture {
                        print("press")
                    }
            })
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    BackButton(action: { presentationMode.wrappedValue.dismiss() }, colorPrimary: .white, colorSecondary: .secondaryOrange
                    )
                }
            }
            
            NavigationLink(destination: CreatePasswordView(), isActive: $isLinkActive) {
                EmptyView()
            }
        }
    }
}

#Preview {
    VerificationCodeView()
}

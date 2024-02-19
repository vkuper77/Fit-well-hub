//
//  VerificationСodeScreenView.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 17.12.23.
//

import SwiftUI

struct VerificationCodeView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var app: AppViewModel
    
    func submit(value: String) {
        guard value.count == 4 else { return }
        app.isAuth = true
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
                CodeInput(numberOfFiled: 4, callback: submit)
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
        }
    }
}

#Preview {
    VerificationCodeView()
}

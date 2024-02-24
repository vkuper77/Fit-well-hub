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
    @StateObject var timer = TimerViewModel()
    @State var isActiveLinkCreatePassword = false
    
    let title: String
    let typeSubmit: String
    
    func submit(value: String) {
        guard value.count == 4 else { return }
        
        switch typeSubmit {
        case "registration":
            app.isAuth = true
        case "recovery-pass":
            isActiveLinkCreatePassword = true
        default:
            return
        }
    }
    
    var body: some View {
        NavigationStack {
            MaskScreenView(topComponent: VStack {
                Spacer().frame(height: 40)
                Text(title)
                    .font(.custom("MontserratAlternates-Bold", size: 24))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
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
                Text("Запросить код \(timer.isStarted ? Text(timer.timerStringValue) : Text("еще раз.").underline(true, color: Color.secondaryOrange))")
                    .font(.custom("MontserratAlternates-Regular", size: 16))
                    .foregroundColor(.secondaryOrange)
                    .onTapGesture { timer.startTimer() }
                    .disabled(timer.isStarted)
            })
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    BackButton(action: { presentationMode.wrappedValue.dismiss() }, colorPrimary: .white, colorSecondary: .secondaryOrange
                    )
                }
            }
            .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
                if timer.isStarted { timer.updateTimer() }
            }
            NavigationLink(destination: CreatePasswordView(), isActive: $isActiveLinkCreatePassword) {
                EmptyView()
            }
        }
    }
}

#Preview {
    VerificationCodeView(title: "", typeSubmit: "")
}

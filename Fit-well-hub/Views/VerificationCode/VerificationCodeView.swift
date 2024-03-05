//
//  VerificationСodeScreenView.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 17.12.23.
//

import SwiftUI

enum TypeSubmit: String {
    case RecoveryPassword = "recovery-password"
}

struct VerificationCodeView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var app: AppViewModel
    @StateObject var timer = TimerViewModel()
    @StateObject var viewModelCode = CodeViewModel()
    
    @State var isActiveLinkCreatePassword = false
    
    let title: String
    let email: String
    let typeSubmit: String
    
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
                Text(email)
                    .font(.custom("MontserratAlternates-Semibold", size: 16))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                Spacer().frame(height: 34)
            }, bottomComponent: VStack {
                Spacer().frame(height: 62)
                CodeInput(numberOfFiled: 4, isError: !viewModelCode.errorMessage.isEmpty, callback: submit)
                if !viewModelCode.errorMessage.isEmpty {
                    Text(viewModelCode.errorMessage)
                        .multilineTextAlignment(.center)
                        .font(.custom("MontserratAlternates-Regular", size: 12))
                        .foregroundColor(.primaryError)
                        .padding(.top, 4)
                }
                Spacer()
                Text("Запросить код \(timer.isStarted ? Text(timer.timerStringValue) : Text("еще раз.").underline(true, color: Color.secondaryOrange))")
                    .font(.custom("MontserratAlternates-Regular", size: 16))
                    .foregroundColor(.secondaryOrange)
                    .onTapGesture { sendCodeRegistration()}
                    .disabled(timer.isStarted)
            })
            .navigationBarBackButtonHidden(true)
            .toolbar {
               if typeSubmit == "recovery-pass" {
                    ToolbarItem(placement: .navigationBarLeading) {
                        BackButton(action: { presentationMode.wrappedValue.dismiss() }, colorPrimary: .white, colorSecondary: .secondaryOrange
                        )
                    }
                }
            }
            .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
                if timer.isStarted { timer.updateTimer() }
            }
            NavigationLink(destination: CreatePasswordView(email: email), isActive: $isActiveLinkCreatePassword) {
                EmptyView()
            }
        }
    }
    
    func submit(value: String) {
        guard value.count == 4 else { return }
        Task {
            do {
                if(typeSubmit == TypeSubmit.RecoveryPassword.rawValue) {
                    try await viewModelCode.validateCode(email: email, code: value)
                    isActiveLinkCreatePassword = true
                } else {
                    try await viewModelCode.activateCode(code: value)
                    app.isAuth = true
                }
            } catch {
                print(error)
            }
        }
    }
    
    func sendCodeRegistration() {
        Task{
            do {
                timer.startTimer()
                if(typeSubmit == TypeSubmit.RecoveryPassword.rawValue) {
                    try await viewModelCode.sendCode(email: email)
                } else {
                    try await viewModelCode.sendCodeRegistration()
                }
            } catch {
                timer.stopTimer()
                print(error)
            }
        }
    }
}

#Preview {
    VerificationCodeView(title: "", email: "test", typeSubmit: "")
}

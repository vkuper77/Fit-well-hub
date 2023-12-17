//
//  VerificationСodeScreenView.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 17.12.23.
//

import SwiftUI

struct VerificationCodeScreenView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationStack{
            Spacer()
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("Код верификации", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    CrossButton { presentationMode.wrappedValue.dismiss() }
                }
            }
        }.padding(.horizontal, 16)
    }
}

#Preview {
    Verification_odeScreenView()
}

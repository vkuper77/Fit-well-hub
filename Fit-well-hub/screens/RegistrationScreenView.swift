//
//  RegistrationScreen.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 9.12.23.
//

import SwiftUI

struct RegistrationScreenView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            Text("RegistrationScreen")
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("Регистрация", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    CrossButton { presentationMode.wrappedValue.dismiss() }
                }
            }
        }
    }
}

#Preview {
    RegistrationScreenView()
}

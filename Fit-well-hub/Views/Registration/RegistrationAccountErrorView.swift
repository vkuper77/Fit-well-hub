//
//  RegistrationAccountErrorView.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 5.03.24.
//

import SwiftUI

struct RegistrationAccountErrorView: View {
    let viewModel: RegistrationViewModel
    var body: some View {
        if viewModel.isErrorEmail {
            HStack {
                Text("Неправильный формат электронной почты.")
                    .multilineTextAlignment(.leading)
                    .font(.custom("MontserratAlternates-Regular", size: 12))
                    .foregroundColor(.primaryError)
                Spacer()
            }.padding(.top, 4)
        }
        
        if !viewModel.errorMessage.isEmpty {
            HStack {
                Text(viewModel.errorMessage)
                    .multilineTextAlignment(.leading)
                    .font(.custom("MontserratAlternates-Regular", size: 12))
                    .foregroundColor(.primaryError)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
            }.padding(.top, 4)
        }
    }
}

#Preview {
    RegistrationAccountErrorView(viewModel: RegistrationViewModel())
}

//
//  RegistrationTopView.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 5.03.24.
//

import SwiftUI

struct RegistrationTopView: View {
    var body: some View {
        VStack {
            Spacer().frame(height: 40)
            Text("Регистрация")
                .font(.custom("MontserratAlternates-Bold", size: 24))
                .foregroundColor(.white)
            Spacer().frame(height: 16)
            Text("Добро пожаловать, дорогой друг,\nв мир заботы о себе!")
                .font(.custom("MontserratAlternates-Regular", size: 16))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            Spacer().frame(height: 34)
        }
    }
}

#Preview {
    RegistrationTopView()
}

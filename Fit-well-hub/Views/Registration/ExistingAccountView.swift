//
//  ExistingAccountView.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 5.03.24.
//

import SwiftUI

struct ExistingAccountView: View {
    @Binding var isLinkActive: Bool
    var body: some View {
        HStack(spacing: 16) {
            Text("Уже есть аккаунт?")
                .font(.custom("MontserratAlternates-Regular", size: 12))
                .foregroundColor(.primaryOrange)
            
            Button {
                isLinkActive = true
            } label: {
                Text("Авторизироваться")
                    .font(.custom("MontserratAlternates-SemiBold", size: 12))
                    .foregroundColor(.primaryOrange)
            }
        }
    }
}

#Preview {
    ExistingAccountView(isLinkActive: .constant(false))
}

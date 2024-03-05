//
//  SocialLoginButtons.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 5.03.24.
//

import SwiftUI

struct SocialLoginButtons: View {
    var body: some View {
        HStack {
            Rectangle()
                .fill(Color.primaryGrey)
                .frame(maxWidth: .infinity)
                .frame(height: 0.5)
            Text("Или войти с помощью")
                .frame(width: 195)
                .font(.custom("MontserratAlternates-Regular", size: 16))
                .foregroundColor(.primaryGrey)
            Rectangle()
                .fill(Color.primaryGrey)
                .frame(maxWidth: .infinity)
                .frame(height: 0.5)
        }
        
        HStack(spacing: 16) {
            Button{
                
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 18)
                        .fill(Color.secondaryGrey)
                        .frame(width: 112, height: 59)
                    Image("apple-logo")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
            }
            
            Button {
                
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 18)
                        .fill(Color.secondaryGrey)
                        .frame(width: 112, height: 59)
                    Image("google-logo")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
            }
        }
    }
}

#Preview {
    SocialLoginButtons()
}

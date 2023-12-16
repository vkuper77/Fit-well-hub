//
//  ContentView.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 5.12.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        VStack() {
            Text("FitWellHub")
                .font(.system(size: 24, weight: .semibold))
                .padding(.top, 118)
            
            Spacer()
            
            VStack{
                Button{
                    
                } label: {
                    Text("Войти")
                        .font(.system(size: 16))
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .cornerRadius(6)
                        .foregroundColor(Color("black"))
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color("black"), lineWidth: 1)
                        )
                }
                
                Spacer().frame(height: 16)
                
                
                Button{
                    
                } label: {
                    Text("Регистрация")
                        .font(.system(size: 16))
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .foregroundColor(.white)
                        .background(Color("black"))
                        .cornerRadius(6)
                }
                
                Spacer().frame(height: 16)
                
                Text("Регистрируясь, я принимаю")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 12))
                    .foregroundColor(Color("black"))
                
                Text("Политику конфиденциальности")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 12))
                    .foregroundColor(Color("black"))
                    .underline()
                    .onTapGesture {
                        print("press")
                    }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 32)
            
        }
    }
}

#Preview {
    ContentView()
}

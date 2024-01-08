//
//  MaskScreenView.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 8.01.24.
//

import SwiftUI

struct MaskScreenView<ChildTopComponent: View, ChildBottomComponent: View>: View {
    
    var topComponent: ChildTopComponent
    var bottomComponent: ChildBottomComponent
    
    var body: some View {
            VStack {
                VStack {
                    ZStack {}
                        .frame(maxWidth: .infinity)
                        .background(Color("orange-secondary"))
                    
                    VStack {
                        topComponent
                    }
                        .frame(maxWidth: .infinity)
                        .background(Color("orange-secondary"))
                        .cornerRadius(79, corners: [.bottomRight])
                }
                .frame(maxWidth: .infinity)
                .background(.white)
                
                VStack {
                    bottomComponent
                }
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    .cornerRadius(79, corners: [.topLeft])
                
                ZStack{}
                    .frame(maxWidth: .infinity)
                    .background(.white)
            }
                .frame(maxWidth: .infinity)
                .background(Color("orange-secondary"))
        
        }
}

#Preview {
    MaskScreenView(topComponent: Spacer(), bottomComponent: Spacer())
}

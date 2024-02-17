//
//  ContentView.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 5.12.23.
//

import SwiftUI


struct OnboardingView: View {
    var body: some View {
        NavigationStack {
            MaskScreenView(topComponent: Spacer(), bottomComponent: FooterContent())
        }
    }
}


#Preview {
    OnboardingView()
}

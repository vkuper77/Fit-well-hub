//
//  CodeInput.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 21.01.24.
//

import SwiftUI

struct CodeInput: View {
    let numberOfFiled: Int
    @State var value: [String]
    @State private var oldValue = ""
    @FocusState private var fieldFocus: Int?
    
    init(numberOfFiled: Int) {
        self.numberOfFiled = numberOfFiled
        self.value = Array(repeating: "", count: numberOfFiled)
    }
    
    var body: some View {
        HStack(spacing: 24) {
            ForEach(0..<numberOfFiled, id: \.self ){ index in
                VStack {
                    TextField("", text: $value[index], onEditingChanged: {editing in
                        if editing {
                            oldValue = value[index]
                        }
                    })
                        .font(.custom("MontserratAlternates-Regular", size: 32))
                        .foregroundColor(Color("black-primary"))
                        .multilineTextAlignment(.center)
                        .frame(width: 56, height: 49)
                        .padding(.top, 9)
                        .keyboardType(.numberPad)
                        .focused($fieldFocus, equals: index)
                        .tag(index)
                        .onChange(of: value[index]) { newValue in
                            if value[index].count > 1 {
                                let currentValue = Array(value[index])
                                
                                if currentValue[0] == Character(oldValue){
                                    value[index] = String(value[index].suffix(1))
                                } else{
                                    value[index] = String(value[index].prefix(1))
                                }
                            }
                            if !newValue.isEmpty {
                                if (index == numberOfFiled - 1) {
                                    fieldFocus = nil
                                } else {
                                    fieldFocus = (fieldFocus ?? 0) + 1
                                }
                            } else {
                                fieldFocus = (fieldFocus ?? 0) - 1
                            }
                        }
                    Rectangle()
                        .fill(Color("orange-secondary"))
                        .frame(width: 56, height: 1)
                        
                }
            }
        }
    }
}

#Preview {
    CodeInput(numberOfFiled: 4)
}

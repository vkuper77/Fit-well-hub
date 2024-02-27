//
//  CodeInput.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 21.01.24.
//

import SwiftUI

struct CodeInput: View {
    let callback: (String) -> Void
    let numberOfFiled: Int
    var isError: Bool
    @State var value: [String]
    @State private var oldValue = ""
    @FocusState private var fieldFocus: Int?
    
    init(numberOfFiled: Int, isError: Bool, callback: @escaping (String) -> Void) {
        self.numberOfFiled = numberOfFiled
        self.value = Array(repeating: "", count: numberOfFiled)
        self.callback = callback
        self.isError = isError
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
                        .foregroundColor(.primaryBlack)
                        .multilineTextAlignment(.center)
                        .frame(width: 56, height: 49)
                        .padding(.top, 9)
                        .keyboardType(.numberPad)
                        .focused($fieldFocus, equals: index)
                        .tag(index)
                        .onSubmit { callback(value.joined()) }
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
                                    callback(value.joined())
                                    fieldFocus = nil
                                } else {
                                    fieldFocus = (fieldFocus ?? 0) + 1
                                }
                            } else {
                                fieldFocus = (fieldFocus ?? 0) - 1
                            }
                        }
                    Rectangle()
                        .fill(isError ? Color.error : Color.secondaryOrange)
                        .frame(width: 56, height: 1)
                }
            }
        }
    }
}

#Preview {
    CodeInput(numberOfFiled: 4, isError: false, callback: { value in })
}

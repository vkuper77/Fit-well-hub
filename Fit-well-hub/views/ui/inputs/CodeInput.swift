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
        HStack{
            ForEach(0..<numberOfFiled, id: \.self ){ index in
                TextField("", text: $value[index], onEditingChanged: {editing in
                    if editing {
                        oldValue = value[index]
                    }
                })
                    .keyboardType(.numberPad)
                    .frame(width: 48, height: 48)
                    .background(.gray.opacity(0.1))
                    .cornerRadius(5)
                    .multilineTextAlignment(.center)
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
            }
        }
    }
}

#Preview {
    CodeInput(numberOfFiled: 4)
}

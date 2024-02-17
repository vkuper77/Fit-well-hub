//
//  DurationTrainingView.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 10.01.24.
//

import SwiftUI

struct DurationTrainingView: View {
    @State private var modelData = CreateTrainingProgramViewModel()
    @State private var weekdaysAbbreviated: [String] = []
    
    @Binding var currentDuration: CommonData?
    @Binding var currentDays: [String]
    
    func initDays() -> Void {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        weekdaysAbbreviated = dateFormatter.shortWeekdaySymbols.map { $0.lowercased() }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 23) {
            VStack{
                Text("Дни тренировок")
                    .font(.custom("MontserratAlternates-SemiBold", size: 18))
                    .foregroundColor(.primaryBlack)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack(spacing: 4) {
                    ForEach(weekdaysAbbreviated, id: \.self) { day in
                        Button {
                                if currentDays.contains(day) {
                                    currentDays.removeAll { $0 == day }
                                } else {
                                    currentDays.append(day)
                                }
                            } label: {
                                LabelButton(selected: currentDays.contains(day), title: day)
                        }
                    }
                }
            }
            VStack(alignment: .leading, spacing: 16) {
                Text("Продолжительность")
                    .font(.custom("MontserratAlternates-SemiBold", size: 18))
                    .foregroundColor(.primaryBlack)

                ForEach(modelData.durationTraining, id: \.id) { level in
                    Button {
                        currentDuration = level
                    } label: {
                        ElementButton(selected: currentDuration?.id == level.id, title: level.title, text: level.text)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(EdgeInsets(top: 24, leading: 16, bottom: 0, trailing: 16))
        .onAppear { initDays() }
    }
}

#Preview {
    DurationTrainingView(currentDuration: .constant(nil), currentDays: .constant([]))
}

//
//  ModelData.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 9.01.24.
//

import SwiftUI

final class CreateTrainingProgramViewModel: ObservableObject {
    var data: [ProgramParametersData] = loadData("programParametersData.json")
    
    @Published var levelsTraining: [CommonData] = []
    @Published var goalsTraining: [CommonData] = []
    @Published var durationTraining: [CommonData] = []
    @Published var weekdaysAbbreviated: [String] = []
    
    @Published var isLinkActiveRegistrationScreen: Bool = false
    
    @Published var indexAnim: Double = 1.0
    @Published var index: Int = 1
    
    @Published var level: CommonData?
    @Published var goal: CommonData?
    @Published var duration: CommonData?
    @Published var daysTraining: [String] = []
    
    init() {
        levelsTraining = data.first?.levelTraining ?? []
        goalsTraining = data.first?.goalTraining ?? []
        durationTraining = data.first?.durationTraining ?? []
        self.initDays()
    }
    
    private func initDays() -> Void {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        weekdaysAbbreviated = dateFormatter.shortWeekdaySymbols.map { $0.lowercased() }
    }
}

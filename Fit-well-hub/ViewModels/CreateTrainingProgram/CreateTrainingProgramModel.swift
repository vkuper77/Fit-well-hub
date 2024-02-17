//
//  ModelData.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 9.01.24.
//

import Foundation

@Observable
class CreateTrainingProgramViewModel {
    var data: [ProgramParametersData] = load("programParametersData.json")
    var trainingLevels: [CommonData] = []
    var goalTraining: [CommonData] = []
    var durationTraining: [CommonData] = []
    
    init() {
        trainingLevels = data.first?.levelTraining ?? []
        goalTraining = data.first?.goalTraining ?? []
        durationTraining = data.first?.durationTraining ?? []
    }
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
            
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

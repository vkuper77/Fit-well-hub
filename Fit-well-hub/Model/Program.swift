//
//  ProgramParameters.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 9.01.24.
//

import Foundation

struct CommonData: Decodable {
    let id: Int
    let title: String
    let text: String
}

struct ProgramParametersData: Decodable {
    let levelTraining: [CommonData]
    let goalTraining: [CommonData]
    let durationTraining: [CommonData]
}

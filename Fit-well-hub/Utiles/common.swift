//
//  common.swift
//  Fit-well-hub
//
//  Created by Vitali Kupratsevich on 18.02.24.
//

import Foundation

func loadData<T: Decodable>(_ filename: String) -> T {
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

func parseErrorMessage(message: String) -> String {
    if let jsonData = message.data(using: .utf8),
       let json = try? JSONSerialization.jsonObject(with: jsonData) as? [String: Any],
       let errorMessage = json["message"] as? String {
        return errorMessage
    } else {
        return message
    }
}

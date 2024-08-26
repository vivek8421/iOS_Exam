//
//  Localjson.swift
//  iOS_Exam
//
//  Created by Neosoft on 26/08/24.
//

import Foundation

class LocalJSONManager {
    
    static let shared = LocalJSONManager()
    
    private init() {}
    
    enum JSONError: Error {
        case fileNotFound
        case decodingFailed(Error)
    }
    
    func loadJSON<T: Decodable>(filename: String, type: T.Type) -> Result<T, JSONError> {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            return .failure(.fileNotFound)
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(T.self, from: data)
            return .success(jsonData)
        } catch {
            return .failure(.decodingFailed(error))
        }
    }
}

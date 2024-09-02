//
//  Localjson.swift
//  iOS_Exam
//
//  Created by Neosoft on 26/08/24.
//

import Foundation

protocol FileReaderProtocol {
    func loadDataFrom<T: Decodable>(file: String, type: String, decodingType: T.Type) -> Result<T, CustomError>
}

final class FileReader: FileReaderProtocol {
    func loadDataFrom<T: Decodable>(file: String, type: String, decodingType: T.Type) -> Result<T, CustomError> {
        guard let path = Bundle.main.url(forResource: file, withExtension: type) else {
            return .failure(.fileNotFound)
        }
        do {
            let data = try Data(contentsOf: path)
            let response = try JSONDecoder().decode(T.self, from: data)
            return .success(response)
        } catch {
            return .failure(.decodingFailed(error))
        }
    }
}

enum CustomError: LocalizedError {
    case fileNotFound
    case decodingFailed(Error)
}

//
//  DataService.swift
//  iOS_Exam
//
//  Created by Neosoft on 02/09/24.
//

import Foundation


protocol TeamsRepositoryProtocol {
    func getTeamsData() -> Result<[Team], CustomError>
}

class TeamsRepository: TeamsRepositoryProtocol {
    private let fileReader: FileReaderProtocol = FileReader()
    
    func getTeamsData() -> Result<[Team], CustomError> {
        let result = fileReader.loadDataFrom(file: "CricketTeams", type: "json", decodingType: Teams.self)
        switch result {
        case .success(let response) :
            return .success(response.teams ?? [])

        case .failure(let error) :
            return .failure(error)
        }
    }
}

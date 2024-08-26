//
//  HomeViewModel.swift
//  iOS_Exam
//
//  Created by Neosoft on 26/08/24.
//

import Foundation

final class HomeViewModel {
    private let localJSONManager = LocalJSONManager.shared
    
    var cricketTeams: [Team] = []
    
    func fetchData() {
        let result = localJSONManager.loadJSON(filename: "DataResponse", type: CricketModel.self)
        
        switch result {
        case .success(let response) :
            cricketTeams = response.teams
            
        case .failure(let error) : print(error)
        }
    }
}

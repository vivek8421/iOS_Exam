//
//  HomeViewModel.swift
//  iOS_Exam
//
//  Created by Neosoft on 26/08/24.
//

import Foundation

final class HomeViewModel {
    private let localJSONManager = LocalJSONManager.shared
    
    var refresh: (() -> Void)?
    var cricketTeams: [Team] = []
    var selectedTeamPlayer: [Player] = [] {
        didSet {
            if let refresh {
                refresh()
            }
        }
    }
    
    func didChangeTeam(index: Int) {
        print(index)
        selectedTeamPlayer = cricketTeams[index].players
    }
    
    func fetchData() {
        let result = localJSONManager.loadJSON(filename: "DataResponse", type: CricketModel.self)
        
        switch result {
        case .success(let response) :
            cricketTeams = response.teams
            selectedTeamPlayer = response.teams.first?.players ?? []
            
        case .failure(let error) : print(error)
        }
    }
}

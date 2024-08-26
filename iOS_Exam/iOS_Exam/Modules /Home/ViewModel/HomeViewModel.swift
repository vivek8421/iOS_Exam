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
    var selectedFilterTeamPlayers: [Player] = [] {
        didSet {
            if let refresh {
                refresh()
            }
        }
    }
    var selectedPlayer: [Player] = [] 
    
    func didChangeTeam(index: Int, searchText: String) {
        selectedPlayer = cricketTeams[index].players
        didSearchPlayer(text: searchText)
    }
    
    func didSearchPlayer(text: String) {
        if text.isEmpty {
            selectedFilterTeamPlayers = selectedPlayer
        } else {
            selectedFilterTeamPlayers = selectedPlayer.filter { $0.name.lowercased().contains(text.lowercased()) }
        }
    }
    
    func fetchData() {
        let result = localJSONManager.loadJSON(filename: "DataResponse", type: CricketModel.self)
        
        switch result {
        case .success(let response) :
            cricketTeams = response.teams
            selectedFilterTeamPlayers = response.teams.first?.players ?? []
            selectedPlayer = selectedFilterTeamPlayers
            
        case .failure(let error) : print(error)
        }
    }
}

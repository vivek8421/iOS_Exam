//
//  HomeViewModel.swift
//  iOS_Exam
//
//  Created by Neosoft on 26/08/24.
//

import Foundation

protocol TeamViewModelProtocol {
    var teams: [Team]  { get set }
    var successBlock: (() -> Void)? { get set }
    var failureBlock: ((_ errorMessage: String) -> Void)? { get set }
    var filterTeamPlayers: [Player] { get set}
    var selectedPlayers: [Player] { get set }
    func didChangeTeam(index: Int, searchText: String)
    func didSearchPlayer(text: String)
    func fetchData()
}

final class TeamViewModel: TeamViewModelProtocol {
  
    private let repository: TeamsRepositoryProtocol = TeamsRepository()
    
    var successBlock: (() -> Void)?
    var failureBlock: ((_ errorMessage: String) -> Void)?
    var teams: [Team] = []
    var selectedPlayers: [Player] = []
    var filterTeamPlayers: [Player] = [] {
        didSet {
            if let successBlock {
                successBlock()
            }
        }
    }
    
    func didChangeTeam(index: Int, searchText: String) {
        selectedPlayers = teams[index].players ?? []
        didSearchPlayer(text: searchText)
    }
    
    func didSearchPlayer(text: String) {
        if text.isEmpty {
            filterTeamPlayers = selectedPlayers
        } else {
            filterTeamPlayers = selectedPlayers.filter { ($0.name?.lowercased() ?? "").contains(text.lowercased()) }
        }
    }
    
    func fetchData() {
        let result = repository.getTeamsData()

        switch result {
        case .success(let teams) :
            self.teams = teams
            selectedPlayers = teams.first?.players ?? []
            filterTeamPlayers = teams.first?.players ?? []
            
        case .failure(let error) :
            failureBlock?(error.localizedDescription)
        }
        
    }
}

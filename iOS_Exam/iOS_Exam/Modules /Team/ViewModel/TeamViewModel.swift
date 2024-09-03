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
    var selectedIndex: Int { get set }
    func didChangeTeam(index: Int, searchText: String)
    func getSelectedCountryPlayers() -> [Player]
    func didSearchPlayer(text: String)
    func didCancelSearch()
    func fetchData()
}

final class TeamViewModel: TeamViewModelProtocol {
  
    private let repository: TeamsRepositoryProtocol = TeamsRepository()
    
    var successBlock: (() -> Void)?
    var failureBlock: ((_ errorMessage: String) -> Void)?
    
    var teams: [Team] = []
    var selectedIndex: Int = 0
    var filterTeamPlayers: [Player] = [] {
        didSet {
            if let successBlock {
                successBlock()
            }
        }
    }
    
    func didChangeTeam(index: Int, searchText: String) {
        selectedIndex = index
        didSearchPlayer(text: searchText)
    }
    
    func didSearchPlayer(text: String) {
        let players = teams[selectedIndex].players ?? []
        if text.isEmpty {
            filterTeamPlayers = players
        } else {
            filterTeamPlayers = players.filter {
                ($0.name?.lowercased() ?? "").contains(text.lowercased())
            }
        }
    }
    
    func getSelectedCountryPlayers() -> [Player] {
        return teams[selectedIndex].players ?? []
    }
    
    func didCancelSearch() {
        filterTeamPlayers = teams[selectedIndex].players ?? []
    }
    
    func fetchData() {
        let result = repository.getTeamsData()

        switch result {
        case .success(let teams) :
            self.teams = teams
            selectedIndex = 0
            filterTeamPlayers = teams.first?.players ?? []
            
        case .failure(let error) :
            failureBlock?(error.localizedDescription)
        }
        
    }
}

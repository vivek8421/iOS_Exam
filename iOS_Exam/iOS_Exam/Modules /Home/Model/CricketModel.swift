//
//  Model.swift
//  iOS_Exam
//
//  Created by Neosoft on 26/08/24.
//

import Foundation

// MARK: - CricketModel
struct CricketModel: Codable {
    let teams: [Team]
}

// MARK: - Team
struct Team: Codable {
    let country, teamImageURL: String
    let players: [Player]

    enum CodingKeys: String, CodingKey {
        case country
        case teamImageURL = "teamImageUrl"
        case players
    }
}

// MARK: - Player
struct Player: Codable {
    let name: String
    let role: Role
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case name, role
        case imageURL = "imageUrl"
    }
}

enum Role: String, Codable {
    case allRounder = "All-rounder"
    case batsman = "Batsman"
    case bowler = "Bowler"
    case wicketkeeperBatsman = "Wicketkeeper-Batsman"
}


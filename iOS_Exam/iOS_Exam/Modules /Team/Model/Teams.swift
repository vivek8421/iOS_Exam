//
//  Model.swift
//  iOS_Exam
//
//  Created by Neosoft on 26/08/24.
//

import Foundation

struct Teams: Codable {
    var teams: [Team]?
}

struct Team: Codable {
    var country: String?
    var teamId: Int?
    var teamImageURL: String?
    var players: [Player]?

    enum CodingKeys: String, CodingKey {
        case country
        case teamId
        case teamImageURL = "teamImageUrl"
        case players
    }
}

struct Player: Codable, Hashable {
    var name: String?
    var role: String?
    var playerId: Int?

    enum CodingKeys: String, CodingKey {
        case name, role
        case playerId
    }
}

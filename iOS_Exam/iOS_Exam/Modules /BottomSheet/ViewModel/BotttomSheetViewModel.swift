//
//  BotttomSheetViewModel.swift
//  iOS_Exam
//
//  Created by Neosoft on 26/08/24.
//

import Foundation

protocol BottomSheetViewModelProtocol {
    var player: [Player] { get set }
    func topThreeCharacters() -> BottomSheetModel
    func getCharacterCountString(result: CharacterOccurrenceData) -> String
}

final class BottomSheetViewModel: BottomSheetViewModelProtocol {
    var player: [Player] = []
    
    func topThreeCharacters() -> BottomSheetModel {
        let names = player.map { $0.name }
        var charCount: [Character: Int] = [:]
        for string in names {
            for char in string ?? "" {
                if char != " " {
                    charCount[char, default: 0] += 1
                }
            }
        }
        let sortedCharCount = charCount.sorted { $0.value > $1.value }
        let topThree = sortedCharCount.prefix(3).map { CharacterOccurrenceData(character: String($0.key), count: $0.value) }
        let bottomSheetData = BottomSheetModel(characterOccurence: topThree)
        return bottomSheetData
    }
    
    func getCharacterCountString(result: CharacterOccurrenceData) -> String {
        return "\(result.character?.capitalized) = \(result.count)"
    }
}



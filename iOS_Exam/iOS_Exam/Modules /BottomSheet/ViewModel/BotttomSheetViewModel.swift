//
//  BotttomSheetViewModel.swift
//  iOS_Exam
//
//  Created by Neosoft on 26/08/24.
//

import Foundation

final class BottomSheetViewModel {
    func getOnlyPlayer(playeres: [Player]) -> [String] {
        return playeres.map { $0.name }
    }
    
    func topThreeCharacters(in array: [String]) -> BottomSheetModel {
        var charCount: [Character: Int] = [:]
        for string in array {
            for char in string {
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
    
    func getString(result: CharacterOccurrenceData) -> String {
        return "\(result.character.capitalized) = \(result.count)"
    }
}



//
//  BottomSheetModel.swift
//  iOS_Exam
//
//  Created by Neosoft on 26/08/24.
//

import Foundation

struct BottomSheetModel {
    let characterOccurence: [CharacterOccurrenceData]?
}

struct CharacterOccurrenceData: Hashable {
    let character: String?
    let count: Int?
}

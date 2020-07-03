//
//  DataStore.swift
//  re-wise
//
//  Created by Mikolaj Witkowski on 02/05/2020.
//  Copyright © 2020 Mikolaj Witkowski. All rights reserved.
//

import SwiftUI
import CoreData


struct FlashCardData: Identifiable {
    var id = UUID()
    var qna: [[String]]
    var title: String
    var description: String
}

struct Sets: Identifiable {
    var id = UUID()
   var sets: [FlashCardData]
}


var firstSet = FlashCardData.init(qna: [["... was the founder of Republic of China", "Sun Zhong Shan"], ["What was the name of the last emperor of China?", "Pu Yi"], ["What is the name of the first Chinese emperor?", "Qin Shi Huang"], ["What is the name of the most influential philosopher of ancient China?", "Confucius"], ["Under whose rule did the Mongolian tribes unite in 1206?", "Genghis Khan"], ["Who was the founder of the Daoist philosophy?", "Lao Zi"]], title: "Sinology Quiz", description: "Test your knowledge of Chinese history!")

var secondSet = FlashCardData.init(qna: [["Pb", "Lead"], ["H", "Hydrogen"], ["O2", "Oxygen"], ["K", "Potasium"], ["Na", "Sodium"]], title: "Chemical Elements", description: "Learn chemical elements the fun way!")

var thirdSet = FlashCardData.init(qna: [["What is the symbol of House Stark?", "A Direwolf."],["What is the symbol of House Lannister?", "A Lion."], ["What's the symbol of House Bolton?", "A Flayed Man."], ["What is the symbol of House Tully?", "A Fish"], ["What is the symbol of House Frey?", "Twin Towers."]], title: "House Symbols", description: "Are you a true fan of Game of Thrones? ")

var allSets = Sets.init(sets: [firstSet, secondSet, thirdSet])

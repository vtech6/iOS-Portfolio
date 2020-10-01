//
//  DataStore.swift
//  DecodeChinese
//
//  Created by Mikolaj Witkowski on 03/09/2020.
//

import Foundation

//The code below is simply the JSON structure unpacked with Codable.

struct JSONFile: Codable {
    var words: [Word]
}

struct Word: Codable {
    var id: Int
    var word_order: Int
    var hanzi: String
    var pinyin: String
    var measure_word: String
    var meaning: String
    var word_class: String
    var audio: String
    var sentence: Sentence
    var characters: [Characters]
}

struct Sentence: Codable {
    var hanzi: String
    var pinyin: String
    var meaning: String
}

struct Characters: Codable {
    var id: Int
    var hanzi: String
    var pinyin: String
    var pinyin_tone: Int
    var meaning: String
    var radical: Radical
    var component: [Component]
    var etymology_note: EtymologyNote
}

struct Radical: Codable {
    var hanzi: String
    var variation: [String]
    var pinyin: String
    var pinyin_tone: Int
    var meaning: String
}

struct Component: Codable {
    var hanzi: String
    var pinyin: String
    var pinyin_tone: Int
    var meaning: String
}

struct EtymologyNote: Codable {
    var character_decomposition: String
    var decomposition_notes: String
    var image: [FileName]
}

struct FileName: Codable {
    var file_name: String
}

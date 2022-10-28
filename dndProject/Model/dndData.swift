//
//  dndData.swift
//  dndProject
//
//  Created by Chad Parr on 10/26/22.
//

import Foundation

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var index: String
    var name: String
    var url: String
}

struct Spells: Codable {
    var desc: Array<String>
}

struct SpellsandDescription: Codable {
    var id: Int
    var name: String
    var desc: Array<String>
}

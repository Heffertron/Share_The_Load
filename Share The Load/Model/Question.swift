//
//  Question.swift
//  Share The Load
//
//  Created by Christopher Hefferman on 12/01/2021.
//

import Foundation

struct Question: Codable {
    let id: Int
    let trilogy: String
    let film: String
    let title: String
    let correctAnswerId: Int
    let answers: [Answer]
}

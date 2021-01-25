//
//  Question.swift
//  Share The Load
//
//  Created by Christopher Hefferman on 12/01/2021.
//

import Foundation
import RealmSwift

final class Question: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var trilogy: String = ""
    @objc dynamic var film: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var correctAnswerId: Int = 0
    var answers = List<Answer>()
    
    var correctAnswer: Answer {
        var correctAnswer = Answer()

        for answer in answers {
            if answer.id == 1 {
                correctAnswer = answer
            }
        }
        return correctAnswer
    }
    
//    var correctAnswer: Answer {
//        answers.first { $0.id == 1 }!
//    }
}

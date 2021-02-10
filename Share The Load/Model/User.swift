//
//  User.swift
//  Share The Load
//
//  Created by Christopher Hefferman on 12/01/2021.
//

import Foundation
import RealmSwift

final class User: Object {
    private(set) var answeredQuestions = List<Int>()
    
    func appendAnsweredQuestion(id: Int) {
        guard !answeredQuestions.contains(id) else { return }
        answeredQuestions.append(id)
    }
    
    func removeAnsweredQuestion(questionAnswered: Int) {
//        questionAnswered.id
//
//        guard !answeredQuestions.contains(id) else { return }
//        answeredQuestions.remove(at: questionAnswered.id)
    }
    
    func resetAnsweredQuestions() {
        answeredQuestions.removeAll()
    }
}

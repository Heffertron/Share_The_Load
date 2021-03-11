//
//  User.swift
//  Share The Load
//
//  Created by Christopher Hefferman on 12/01/2021.
//

import Foundation
import RealmSwift

final class User: Object {
    private(set) var answeredQuestionIds = List<Int>()
    
    func appendAnsweredQuestion(id: Int) {
        guard !answeredQuestionIds.contains(id) else { return }
        answeredQuestionIds.append(id)
    }
    
    func removeAnsweredQuestion(questionAnsweredId: Int) {
        guard !answeredQuestionIds.contains(questionAnsweredId) else { return }
        answeredQuestionIds.remove(at: questionAnsweredId)
    }
    
    func resetAnsweredQuestions() {
        answeredQuestionIds.removeAll()
    }
}

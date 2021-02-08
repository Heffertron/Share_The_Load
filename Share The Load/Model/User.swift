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
    
    /// Had a question on this in our Twitter regarding whether we should be 'removing' the Question object from Realm or just filtering out a list of id's when we access the data from Realm.
    ///If we can talk this through on a call, then I can crack on
    func removeAnsweredQuestion(questionAnswered: Question) {
//        questionAnswered.id
//
//        guard !answeredQuestions.contains(id) else { return }
//        answeredQuestions.remove(at: questionAnswered.id)
        
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(questionAnswered)
            }

        } catch {
            print("Error removing from Realm: \(error.localizedDescription)")
        }
        
    }
    
    
    func resetAnsweredQuestions() {
        answeredQuestions.removeAll()
    }
}

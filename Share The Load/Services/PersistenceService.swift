//
//  PersistanceService.swift
//  Share The Load
//
//  Created by Christopher Hefferman on 13/01/2021.
//

import Foundation
import RealmSwift

protocol PersistenceServiceType {
    var answeredIds: [Int] { get }
    func save(ids: [Int])
    func save(questions: [Question])
    func getQuestions() -> [Question]
}

/// Massive temporary hack to get save logic working
/// We'll need a UserService to always give us the same instance of a user rather than this global properties
/// Global properties are very bad.
var user = User()

class PersistenceService: PersistenceServiceType {
    
    var answeredIds: [Int] = []
    
    func save(ids: [Int]) {
        for id in ids {
            user.appendAnsweredQuestion(id: id)
        }
        
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(user)
            }
        } catch {
            print("Error: \(error)")
        }
    }
    
    func save(questions: [Question]) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(questions)
            }
            print("Saved to Realm")
        } catch {
            print("Error: \(error)")
        }
    }
    
    func getQuestions() -> [Question] {
        var questionsFromRealm: [Question] = []
        
        do {
            let realm = try Realm()
            let realmQuestions = realm.objects(Question.self)
            questionsFromRealm = Array(realmQuestions)
            
        } catch {
            print("Error: \(error)")
        }
        
        return questionsFromRealm
    }
}

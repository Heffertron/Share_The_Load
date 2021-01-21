//
//  PersistanceService.swift
//  Share The Load
//
//  Created by Christopher Hefferman on 13/01/2021.
//

import Foundation
import RealmSwift

protocol PersistanceServiceType {
    var answeredIds: [Int] { get }
    func save(id: [Int])
    func save(questions: [Question])
    func getQuestions() -> [Question]
}


class PersistanceService: PersistanceServiceType {
    
    var answeredIds: [Int] = []
    
    
    func save(id: [Int]) {
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(id)
        }
    }
    
    
    func save(questions: [Question]) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(questions)
            }
        } catch {
            print("Error: \(error)")
        }
    }
    
    
    func getQuestions() -> [Question] {
        var questionsFromRealm = [Question()]
        
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

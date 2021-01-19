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
        
    }
    
    
    func save(questions: [Question]) {
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(questions)
        }
    }
    
    
    func getQuestions() -> [Question] {
        let realm = try! Realm()
        let realmQuestions = realm.objects(Question.self)
        let questionsFromRealm = Array(realmQuestions)
        return questionsFromRealm
    }
}

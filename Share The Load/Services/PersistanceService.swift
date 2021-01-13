//
//  PersistanceService.swift
//  Share The Load
//
//  Created by Christopher Hefferman on 13/01/2021.
//

import Foundation

protocol PersistanceServiceType {
    func save(quiz: Quiz)
    func getQuiz() -> Quiz
    func save(id: [Int])
    var answeredIds: [Int] { get set }
}


class PersistanceService: PersistanceServiceType {
    func save(quiz: Quiz) {
        
    }
    
    func getQuiz() -> Quiz {
        let quiz = Quiz()

        return quiz
    }
    
    func save(id: [Int]) {
        
    }
    
    var answeredIds: [Int] = []
    
    
}

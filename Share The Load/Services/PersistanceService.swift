//
//  PersistanceService.swift
//  Share The Load
//
//  Created by Christopher Hefferman on 13/01/2021.
//

import Foundation

protocol PersistanceServiceType {
    var answeredIds: [Int] { get }
    func save(id: [Int])
    func save(quiz: Quiz)
    func getQuiz() -> Quiz
}


class PersistanceService: PersistanceServiceType {
    var answeredIds: [Int] = []
    
    func save(id: [Int]) {
        
    }
    
    func save(quiz: Quiz) {
        
    }
    
    func getQuiz() -> Quiz {
        let quiz = Quiz()

        return quiz
    }    
}

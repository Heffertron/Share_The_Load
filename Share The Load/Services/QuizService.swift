//
//  QuizService.swift
//  Share The Load
//
//  Created by Christopher Hefferman on 13/01/2021.
//

import Foundation

protocol QuizServiceType {
    func quiz(completion: @escaping(Result<Quiz, Error>) -> ())
}


class QuizService: QuizServiceType {
    func quiz(completion: @escaping (Result<Quiz, Error>) -> ()) {
        
    }
}

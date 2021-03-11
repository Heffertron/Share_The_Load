//
//  UserService.swift
//  Share The Load
//
//  Created by Christopher Hefferman on 13/01/2021.
//

import Foundation

protocol UserServiceType {
    func fetchAnswerIds(completion: @escaping (Result<[Int], Error>) -> ())
}

class UserService: UserServiceType {
    func fetchAnswerIds(completion: @escaping (Result<[Int], Error>) -> ()) {
        
    }
}

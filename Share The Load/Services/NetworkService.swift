//
//  NetworkService.swift
//  Share The Load
//
//  Created by Christopher Hefferman on 12/01/2021.
//

import Foundation
import Firebase

protocol NetworkServiceType {
    func fetchQuiz(completion: @escaping (Result<[Question], Error>) -> ())
}

class NetworkService: NetworkServiceType {
    func fetchQuiz(completion: @escaping (Result<[Question], Error>) -> ()) {
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
        
            do {
                let value = snapshot.value as Any
            
                let jsonData = try JSONSerialization.data(withJSONObject: value as Any, options: .prettyPrinted)
                let questions = try JSONDecoder().decode([Question].self, from: jsonData)
                
                completion(.success(questions))
            } catch {
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }) { (error) in
            print(error.localizedDescription)
            completion(.failure(error))
        }
    }
}

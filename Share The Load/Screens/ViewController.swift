//
//  ViewController.swift
//  Share The Load
//
//  Created by Christopher Hefferman on 10/01/2021.
//

import UIKit
import Firebase
import RealmSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchQuiz()
    }
    
    private func fetchQuiz() {
        let persistanceService = PersistanceService()
        if persistanceService.getQuestions().isEmpty {
            //TODO: This is temporary for now as it was pulling the questions from Firebase every time and therefore doubling each time the app was launched
            let networkService = NetworkService()
            
            networkService.fetchQuiz() { result in
                switch result {
                case .success(let allQuestions):
                    print("Success")
                    persistanceService.save(questions: allQuestions)
                    
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }
}

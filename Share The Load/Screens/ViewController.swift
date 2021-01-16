//
//  ViewController.swift
//  Share The Load
//
//  Created by Christopher Hefferman on 10/01/2021.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchQuiz()
    }
    
    private func fetchQuiz() {
        let getData = NetworkService()
        
        getData.fetchQuiz() { result in
            switch result {
            case .success(let allQuestions):
                print("Questions: \(allQuestions)")
            
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}

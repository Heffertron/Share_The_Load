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
    
    private let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchQuiz()
        createButton()
    }
    
    
    private func createButton() {
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Get Questions", for: .normal)
        button.frame = view.frame
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    @objc func buttonTapped() {
        let persistanceService = PersistanceService()
        let questionsFromRealm = persistanceService.getQuestions()
        
        for question in questionsFromRealm {
            print("Question: \(question.title) || Answer: \(question.correctAnswer)")
        }
    }
    
    
    private func fetchQuiz() {
        let persistanceService = PersistanceService()
        if persistanceService.getQuestions().isEmpty {
            
            /// This is temporary for now as it was pulling the questions from Firebase every time and therefore doubling each time the app was launched
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

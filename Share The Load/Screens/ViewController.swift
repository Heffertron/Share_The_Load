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
    
    private var accessQuestionsFromDatabaseButton: UIButton = {
        let accessQuestionsFromDatabaseButton = UIButton()
        accessQuestionsFromDatabaseButton.setTitle("Access Questions from Database", for: .normal)
        accessQuestionsFromDatabaseButton.backgroundColor = .systemBlue
        accessQuestionsFromDatabaseButton.addTarget(self, action: #selector(accessQuestionsFromDatabaseButtonTapped), for: .touchUpInside)
        return accessQuestionsFromDatabaseButton
    }()

    private var removeQuestionsFromDatabaseButton: UIButton = {
        let removeQuestionsFromDatabaseButton = UIButton()
        removeQuestionsFromDatabaseButton.setTitle("Remove Question from Database", for: .normal)
        removeQuestionsFromDatabaseButton.backgroundColor = .systemRed
        removeQuestionsFromDatabaseButton.addTarget(self, action: #selector(removeQuestionsFromDatabaseButtonTapped), for: .touchUpInside)
        return removeQuestionsFromDatabaseButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchQuiz()
    }
    
    
    override func loadView() {
        let view = UIView()
        view.addSubview(accessQuestionsFromDatabaseButton)
        view.addSubview(removeQuestionsFromDatabaseButton)
        view.backgroundColor = .white
        
        let buttonHeight: CGFloat = 50
        let buttonPadding: CGFloat = 20
        
        accessQuestionsFromDatabaseButton.translatesAutoresizingMaskIntoConstraints = false
        removeQuestionsFromDatabaseButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            accessQuestionsFromDatabaseButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            accessQuestionsFromDatabaseButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: buttonPadding),
            accessQuestionsFromDatabaseButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -buttonPadding),
            accessQuestionsFromDatabaseButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            
            removeQuestionsFromDatabaseButton.topAnchor.constraint(equalTo: accessQuestionsFromDatabaseButton.bottomAnchor, constant: buttonPadding),
            removeQuestionsFromDatabaseButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: buttonPadding),
            removeQuestionsFromDatabaseButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -buttonPadding),
            removeQuestionsFromDatabaseButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])
        
        self.view = view
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        accessQuestionsFromDatabaseButton.layer.cornerRadius = accessQuestionsFromDatabaseButton.bounds.height / 2
        removeQuestionsFromDatabaseButton.layer.cornerRadius = removeQuestionsFromDatabaseButton.bounds.height / 2
    }
    
    @objc private func accessQuestionsFromDatabaseButtonTapped() {
        let persistanceService = PersistenceService()
        let questionsFromRealm = persistanceService.getQuestions()
        
        for question in questionsFromRealm {
            if let answerExists = question.correctAnswer {
                print("Question: \(question.title) || Answer: \(answerExists)")
            } else {
                print("Question: \(question.title) || Answer: No correct answer exists in database")
            }
        }
    }
    
    @objc private func removeQuestionsFromDatabaseButtonTapped() {
        print("Does nothing - need to update User object first. ")
        ///Need to add logic here once User object is updated to include valid implementation of removeAnsweredQuestionID.
    }
    
    private func fetchQuiz() {
        let persistanceService = PersistenceService()
        if persistanceService.getQuestions().isEmpty {
            
            /// This is temporary for now as it was pulling the questions from Firebase every time and therefore doubling each time the app was launched
            let networkService = NetworkService()
            
            networkService.fetchQuiz() { result in
                switch result {
                case .success(let allQuestions):
                    persistanceService.save(questions: allQuestions)
                    
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }
}


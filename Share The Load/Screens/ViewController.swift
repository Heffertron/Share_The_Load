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
    
    private var getRealmQuestionsButton = UIButton()
    private var removeFromRealmButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchQuiz()
    }
    
    override func loadView() {
        createView()
        createGetRealmQuestionsButton()
        createRemoveButton()
    }
    
    private func createView() {
        view = UIView()
        view.backgroundColor = .white
    }
    
    private func createGetRealmQuestionsButton() {
        getRealmQuestionsButton = UIButton()
        getRealmQuestionsButton.translatesAutoresizingMaskIntoConstraints = false
        getRealmQuestionsButton.setTitle("Get Questions From Realm", for: .normal)
        getRealmQuestionsButton.backgroundColor = .systemBlue
        getRealmQuestionsButton.layer.cornerRadius = 20
        getRealmQuestionsButton.addTarget(self, action: #selector(getRealmQuestionsButtonTapped), for: .touchUpInside)
        view.addSubview(getRealmQuestionsButton)
        
        NSLayoutConstraint.activate([
            getRealmQuestionsButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            getRealmQuestionsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            getRealmQuestionsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            getRealmQuestionsButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func createRemoveButton() {
        removeFromRealmButton = UIButton()
        removeFromRealmButton.translatesAutoresizingMaskIntoConstraints = false
        removeFromRealmButton.setTitle("Remove Question", for: .normal)
        removeFromRealmButton.backgroundColor = .systemRed
        removeFromRealmButton.layer.cornerRadius = 20
        removeFromRealmButton.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)
        view.addSubview(removeFromRealmButton)
        
        NSLayoutConstraint.activate([
            removeFromRealmButton.topAnchor.constraint(equalTo: getRealmQuestionsButton.bottomAnchor, constant: 20),
            removeFromRealmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            removeFromRealmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            removeFromRealmButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func getRealmQuestionsButtonTapped() {
        let persistanceService = PersistenceService()
        let questionsFromRealm = persistanceService.getQuestions()
        
        for question in questionsFromRealm {
            print("Question: \(question.title) || Answer: \(question.correctAnswer)")
        }
    }
    
    @objc private func removeButtonTapped() {
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


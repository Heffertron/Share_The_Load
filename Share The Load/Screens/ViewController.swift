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
    
    private let getRealmQuestionsButton = UIButton()
    private let removeFromRealmButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchQuiz()
        createGetRealmQuestionsButton()
        createRemoveButton()
    }
    
    
    private func createGetRealmQuestionsButton() {
        view.addSubview(getRealmQuestionsButton)
        getRealmQuestionsButton.translatesAutoresizingMaskIntoConstraints = false
        getRealmQuestionsButton.setTitle("Get Questions From Realm", for: .normal)
        getRealmQuestionsButton.frame = view.frame
        getRealmQuestionsButton.backgroundColor = .systemBlue
        getRealmQuestionsButton.layer.cornerRadius = 20
        getRealmQuestionsButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            getRealmQuestionsButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            getRealmQuestionsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            getRealmQuestionsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            getRealmQuestionsButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    private func createRemoveButton() {
        view.addSubview(removeFromRealmButton)
        removeFromRealmButton.translatesAutoresizingMaskIntoConstraints = false
        removeFromRealmButton.setTitle("Remove Question", for: .normal)
        removeFromRealmButton.frame = view.frame
        removeFromRealmButton.backgroundColor = .systemRed
        removeFromRealmButton.layer.cornerRadius = 20
        removeFromRealmButton.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            removeFromRealmButton.topAnchor.constraint(equalTo: getRealmQuestionsButton.bottomAnchor, constant: 20),
            removeFromRealmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            removeFromRealmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            removeFromRealmButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    @objc func buttonTapped() {
        let persistanceService = PersistanceService()
        let questionsFromRealm = persistanceService.getQuestions()
        
        for question in questionsFromRealm {
            print("Question: \(question.title) || Answer: \(question.correctAnswer)")
        }
    }
    
    
    @objc func removeButtonTapped() {
        let persistanceService = PersistanceService()
        let questionsFromRealm = persistanceService.getQuestions()
        
        print("Questions from Realm before removal: \(questionsFromRealm[0])")
        
        let user = User()
        user.removeAnsweredQuestion(questionAnswered: questionsFromRealm[0])
        
        print("Questions from Realm after removal: \(questionsFromRealm.count)")
    }
    
    
    private func fetchQuiz() {
        let persistanceService = PersistanceService()
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

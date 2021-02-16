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
    
    private var getRealmQuestionsButton: UIButton = {
        let getRealmQuestionsButton = UIButton()
        getRealmQuestionsButton.setTitle("Get Questions From Realm", for: .normal)
        getRealmQuestionsButton.backgroundColor = .systemBlue
        getRealmQuestionsButton.addTarget(self, action: #selector(getRealmQuestionsButtonTapped), for: .touchUpInside)
        return getRealmQuestionsButton
    }()

    private var removeFromRealmButton: UIButton = {
        let removeFromRealmButton = UIButton()
        removeFromRealmButton.setTitle("Remove Question", for: .normal)
        removeFromRealmButton.backgroundColor = .systemRed
        removeFromRealmButton.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)
        return removeFromRealmButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchQuiz()
    }
    
    
    override func loadView() {
        let view = UIView()
        view.addSubview(getRealmQuestionsButton)
        view.addSubview(removeFromRealmButton)
        view.backgroundColor = .white
        
        let buttonHeight: CGFloat = 50
        let buttonPadding: CGFloat = 20
        
        getRealmQuestionsButton.translatesAutoresizingMaskIntoConstraints = false
        removeFromRealmButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            getRealmQuestionsButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            getRealmQuestionsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: buttonPadding),
            getRealmQuestionsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -buttonPadding),
            getRealmQuestionsButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            
            removeFromRealmButton.topAnchor.constraint(equalTo: getRealmQuestionsButton.bottomAnchor, constant: buttonPadding),
            removeFromRealmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: buttonPadding),
            removeFromRealmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -buttonPadding),
            removeFromRealmButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])
        
        self.view = view
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        getRealmQuestionsButton.layer.cornerRadius = getRealmQuestionsButton.bounds.height / 2
        removeFromRealmButton.layer.cornerRadius = removeFromRealmButton.bounds.height / 2
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


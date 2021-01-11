//
//  ViewController.swift
//  Share The Load
//
//  Created by Christopher Hefferman on 10/01/2021.
//

import UIKit

class ViewController: UIViewController {
    
    private let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        troll()
    }
    
    private func troll() {
        view.addSubview(label)
        label.text = "Hello Gandalf"
        label.textAlignment = .center
        label.frame = view.frame
    }
}

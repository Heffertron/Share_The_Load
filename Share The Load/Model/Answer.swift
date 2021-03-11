//
//  Answer.swift
//  Share The Load
//
//  Created by Christopher Hefferman on 12/01/2021.
//

import Foundation
import RealmSwift

final class Answer: Object, Codable {
    @objc dynamic var title: String = ""
    @objc dynamic var id: Int = 0
}

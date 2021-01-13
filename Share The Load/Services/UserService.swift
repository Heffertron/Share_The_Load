//
//  UserService.swift
//  Share The Load
//
//  Created by Christopher Hefferman on 13/01/2021.
//

import Foundation

protocol UserServiceType {
    var answeredIds: [Int] { get set }
}


class UserService: UserServiceType {
    var answeredIds: [Int] = []
}

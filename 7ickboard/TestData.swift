//
//  TestData.swift
//  7ickboard
//
//  Created by t2023-m0074 on 4/22/24.
//

import UIKit
final class UserModel {
    struct User {
        var email: String
        var password: String
        var name: String
        var telephone: String
        var driversLicense: Bool
    }
    var users: [User] = [
        User(email: "test1234", password: "test1234", name: "test" , telephone: "010-1234-5678", driversLicense: true),
    ]
}

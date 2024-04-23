//
//  File.swift
//  7ickboard
//
//  Created by Kinam on 4/22/24.
//

import UIKit

final class UserModel {
    struct User: Encodable {
        var id: String
        var password: String
        var name: String
        var telephone: String
        var driversLicense: Bool
    }
    
    var users: [User] = [
        User(id: "test1234", password: "test1234", name: "test" , telephone: "010-1234-5678", driversLicense: true),
    ]
    
    // 비밀번호 형식 검사
    func isValidPassword(pwd: String) -> Bool {
        let passwordRegEx = "^[a-zA-Z0-9]{8,16}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: pwd)
    }
    
    // 전화번호 형식 검사
    func isValidTelephone(phone: String) -> Bool {
        let phoneRegEx = "^010\\d{8}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
        return phoneTest.evaluate(with: phone)
    }
    
    // 회원 추가
    func addUser(user: User) {
        users.append(user)
    }
}

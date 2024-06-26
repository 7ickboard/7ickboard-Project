//
//  File.swift
//  7ickboard
//
//  Created by Kinam on 4/22/24.
//

import UIKit

final class UserModel {
    struct User: Codable {
        var id: String
        var password: String
        var name: String
        var telephone: String
        var driversLicense: Bool
        var history: [History]
        
        init(id: String, password: String, name: String, telephone: String, driversLicense: Bool, history: [History] = []) {
            self.id = id
            self.password = password
            self.name = name
            self.telephone = telephone
            self.driversLicense = driversLicense
            self.history = history
        }
    }
    
    struct History: Codable {
        var startTime: Date?
        var endTime: Date?
        var kickboardName: String
        
        init(startTime: Date? = nil, endTime: Date? = nil, kickboardName: String) {
            self.startTime = startTime
            self.endTime = endTime
            self.kickboardName = kickboardName
        }
        
        func formattedTime() -> (String, String) {
                let formatter = DateFormatter()
                formatter.dateFormat = "HH:mm"

                let startTimeString = startTime.map { formatter.string(from: $0) } ?? "00:00"
                let endTimeString = endTime.map { formatter.string(from: $0) } ?? "00:00"

                return (startTimeString, endTimeString)
            }
        
    }
    
    static var users: [User] = []

    init() {
        // UserDefaults에서 저장된 사용자 데이터를 불러오기
        if let userData = UserDefaults.standard.data(forKey: "userData") {
            if let decodedData = try? JSONDecoder().decode([User].self, from: userData) {
                UserModel.users = decodedData
                return
            }
        }
        // 저장된 사용자 데이터가 없을 경우, 기본값 설정
        UserModel.users = [
            User(id: "test1234", password: "test1234", name: "test" , telephone: "010-1234-5678", driversLicense: true)
        ]
    }
    
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
        UserModel.users.append(user)
        UserModel.save() // 변경사항을 저장
    }
    
    // 사용자 데이터를 UserDefaults에 저장
    static func save() {
        if let encodedData = try? JSONEncoder().encode(UserModel.users) {
            UserDefaults.standard.set(encodedData, forKey: "userData")
        }
    }

    func removeUser(withId id: String) {
        UserModel.users = UserModel.users.filter { $0.id != id }
        UserModel.save() // 변경사항을 저장
    }
    
    func removeAllUsers() {
        UserModel.users = []
        UserModel.save() // 변경사항을 저장
    }
}

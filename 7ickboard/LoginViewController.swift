//
//  AuthViewController.swift
//  7ickboard
//
//  Created by Kinam on 4/22/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    var userModel = UserModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setIdTextField()
        setPasswordTextField()
        setButton()
        setIdPassword()
        hideKeyboard()
    }
    
    func setIdTextField() {
        idTextField.placeholder = "ID를 입력하세요"
        idTextField.addTarget(self, action: #selector(didEndOnExit), for: UIControl.Event.editingDidEndOnExit)
    }
    
    func setPasswordTextField() {
        passwordTextField.placeholder = "Password를 입력하세요"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.addTarget(self, action: #selector(didEndOnExit), for: UIControl.Event.editingDidEndOnExit)
    }
    
    func setButton() {
        signinButton.layer.cornerRadius = 12
        signupButton.layer.cornerRadius = 12
    }
    
    
    @objc func didEndOnExit(_ sender: UITextField) {
        if idTextField.isFirstResponder {
            passwordTextField.becomeFirstResponder()
        }
    }
    
    func loginCheck(id: String, pwd: String) -> Bool {
        let userModel = UserModel()
        for user in userModel.users {
            if user.id == id && user.password == pwd {
                return true // 로그인 성공
            }
        }
        return false
    }
    
    //로그인 버튼
    @IBAction func didTapLoginButton(_ sender: UIButton) {
        guard let id = idTextField.text, !id.isEmpty else {
            makeAlert(for: "아이디")
            return
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            makeAlert(for: "비밀번호")
            return
        }
        
        if userModel.isValidPassword(pwd: password) {
            let loginSuccess: Bool = loginCheck(id: id, pwd: password)
            if loginSuccess {
                print("로그인 성공")
                UserDefaults.standard.set(id, forKey: "loggedInUserId")
                UserDefaults.standard.set(password, forKey: "loggedInUserPassword")

              let tabBarController = TabBarController()
                    self.navigationController?.pushViewController(tabBarController, animated: true)

            } else {
                print("로그인 실패")
                makeAlert(for: "비밀번호")
            }
        }
    }
    
    func makeAlert(for item: String) {
        print("로그인 실패")
        let alert = UIAlertController(title: "로그인 실패", message: "\(item)이(가) 없거나 다릅니다.", preferredStyle: .alert)
        let okAlert = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(okAlert)
        present(alert, animated: true, completion: nil)
    }
    
    func setIdPassword() {
        if let savedId = UserDefaults.standard.string(forKey: "loggedInUserId"), let savedPassword = UserDefaults.standard.string(forKey: "loggedInUserPassword") {
            idTextField.text = savedId
            passwordTextField.text = savedPassword
        }
    }
}

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
    
    var userModel = UserModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setIdTextField()
        setPasswordTextField()
        setSigninButton()
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
    
    func setSigninButton() {
        signinButton.addTarget(self, action: #selector(didEndOnExit), for: UIControl.Event.editingDidEndOnExit)
    }
    
    
    @objc func didEndOnExit(_ sender: UITextField) {
        if idTextField.isFirstResponder {
            passwordTextField.becomeFirstResponder()
        }
    }
    
    func loginCheck(id: String, pwd: String) -> Bool {
        for user in userModel.users {
            if user.email == id && user.password == pwd {
                return true // 로그인 성공
            }
        }
        return false
    }
    
    //로그인 버튼
    @IBAction func didTapLoginButton(_ sender: UIButton) {
        
    }
}

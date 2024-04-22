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
            if user.id == id && user.password == pwd {
                return true // 로그인 성공
            }
        }
        return false
    }
    
    //로그인 버튼
    @IBAction func didTapLoginButton(_ sender: UIButton) {
        guard let id = idTextField.text, !id.isEmpty else { return }
        guard let password = passwordTextField.text, !password.isEmpty else { return }
        
        if userModel.isValidPassword(pwd: password) {
            if let removable = self.view.viewWithTag(101) {
                removable.removeFromSuperview()
            }
        }
        
        if userModel.isValidPassword(pwd: password) {
            let loginSuccess: Bool = loginCheck(id: id, pwd: password)
            if loginSuccess {
                print("로그인 성공")
                if let removable = self.view.viewWithTag(102) {
                    removable.removeFromSuperview()
                }
                self.performSegue(withIdentifier: "이동할 클래스", sender: self)
            } else {
                print("로그인 실패")
                let alert = UIAlertController(title: "로그인 실패", message: "아이디나 비밀번호가 다릅니다.", preferredStyle: .alert)
                let okAlert = UIAlertAction(title: "확인", style: .cancel)
                alert.addAction(okAlert)
                present(alert, animated: true, completion: nil)
            }
        }
    }
}

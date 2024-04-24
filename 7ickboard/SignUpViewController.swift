//
//  SignUpViewController.swift
//  7ickboard
//
//  Created by Kinam on 4/22/24.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    var userModel = UserModel()
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var telephoneTextField: UITextField!
    @IBOutlet weak var licenseSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextField()
        setSegmentedControl()
        hideKeyboard()
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
//        self.view.endEditing(true)
//    }
    
    func setTextField() {
        idTextField.placeholder = "id를 입력해주세요"
        passwordTextField.placeholder = "비밀번호를 입력해주세요 (영대,소,특수문자 8~16자)"
        passwordTextField.isSecureTextEntry = true
        nameTextField.placeholder = "이름을 입력해주세요"
        telephoneTextField.placeholder = "핸드폰 번호를 입력해주세요 (ex)01012345678"
        
        idTextField.delegate = self
        passwordTextField.delegate = self
        nameTextField.delegate = self
        telephoneTextField.delegate = self
        
    }
    
    func setSegmentedControl() {
        licenseSegmentedControl.selectedSegmentIndex = 1
        licenseSegmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
    }
    
    @objc func didEndOnExit(_ sender: UITextField) {
        if idTextField.isFirstResponder {
            telephoneTextField.becomeFirstResponder()
        }
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        let isLicensed = sender.selectedSegmentIndex == 0 ? true : false
        print("Is Licensed: \(isLicensed)")
    }
    
    @IBAction func signupButton(_ sender: UIButton) {
        guard let id = idTextField.text, !id.isEmpty else {
            makeAlert(for: "id")
            return
        }
        guard let pw = passwordTextField.text, !pw.isEmpty else {
            makeAlert(for: "비밀번호")
            return
        }
        guard let name = nameTextField.text, !name.isEmpty else {
            makeAlert(for: "이름")
            return
        }
        guard let tp = telephoneTextField.text, !tp.isEmpty else {
            makeAlert(for: "휴대폰번호")
            return
        }
        if userModel.isValidPassword(pwd: pw) {
            print("pw 조건 만족")
        } else {
            print("pw 조건 불충족")
            makeAlert(for: "비밀번호")
        }
        if userModel.isValidTelephone(phone: tp) {
            print("tp 조건 만족")
        } else {
            print("tp 조건 불충족")
            makeAlert(for: "휴대폰 번호")
        }
        if userModel.isValidPassword(pwd: pw) && userModel.isValidTelephone(phone: tp) {
            print("회원가입 성공")
            let selectedIndex = licenseSegmentedControl.selectedSegmentIndex
            let isLicensed = selectedIndex == 0 ? true : false
            let user = UserModel.User(id: id, password: pw, name: name, telephone: tp, driversLicense: isLicensed)
            print(userModel.users)
            userModel.removeAllUsers()
            print(userModel.users)
            userModel.addUser(user: user)
            print(userModel.users)
            makeSuccessAlert()
        } else {
            makeSignUpCheckAlert()
        }
    }
    
    func makeAlert(for item: String) {
        print("회원가입 실패")
        let alert = UIAlertController(title: "회원가입 실패", message: "\(item)이(가) 없습니다.", preferredStyle: .alert)
        let okAlert = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(okAlert)
        present(alert, animated: true, completion: nil)
    }
    
    func makeSignUpCheckAlert() {
        print("회원가입 실패")
        let alert = UIAlertController(title: "회원가입 실패", message: "잘못 작성된 란이 있습니다. 다시 작성해주세요.", preferredStyle: .alert)
        let okAlert = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(okAlert)
        present(alert, animated: true, completion: nil)
    }
    
    func makeSuccessAlert() {
        print("회원가입 성공")
        let alert = UIAlertController(title: "회원가입 성공", message: "환영합니다. 로그인 해주세요", preferredStyle: .alert)
        let okAlert = UIAlertAction(title: "확인", style: .default) {_ in
            self.dismiss(animated: true)
        }
        alert.addAction(okAlert)
        present(alert, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case idTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            nameTextField.becomeFirstResponder()
        case nameTextField:
            telephoneTextField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
    
}

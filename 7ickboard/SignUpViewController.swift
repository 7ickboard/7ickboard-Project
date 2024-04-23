//
//  SignUpViewController.swift
//  7ickboard
//
//  Created by Kinam on 4/22/24.
//

import UIKit

class SignUpViewController: UIViewController {
    
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
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
         self.view.endEditing(true)
   }
    
    func setTextField() {
        idTextField.placeholder = "id를 입력해주세요"
        passwordTextField.placeholder = "비밀번호를 입력해주세요 (영대,소,특수문자 8~16자)"
        nameTextField.placeholder = "이름을 입력해주세요"
        telephoneTextField.placeholder = "핸드폰 번호를 입력해주세요 (ex)01012345678"
    }
    
    func setSegmentedControl() {
        licenseSegmentedControl.selectedSegmentIndex = 1
        licenseSegmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
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
        guard let tp = telephoneTextField.text, !name.isEmpty else {
            makeAlert(for: "휴대폰번호")
            return
        }
        
    }
    
    func makeAlert(for item: String) {
        print("회원가입 실패")
        let alert = UIAlertController(title: "회원가입 실패", message: "\(item)이(가) 없습니다.", preferredStyle: .alert)
        let okAlert = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(okAlert)
        present(alert, animated: true, completion: nil)
        
    }
}

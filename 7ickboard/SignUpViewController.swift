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
        licenseSegmentedControl.selectedSegmentIndex = 0
        licenseSegmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        let isLicensed = sender.selectedSegmentIndex == 0 ? true : false
        print("Is Licensed: \(isLicensed)")
    }
    
    @IBAction func signupButton(_ sender: Any) {
        guard let id = idTextField.text else {
            return
        }
        guard let pw = passwordTextField.text else {
            return
        }
        guard let name = nameTextField.text else {
            return
        }
        guard let tp = telephoneTextField.text else {
            return
        }
        
    }
}

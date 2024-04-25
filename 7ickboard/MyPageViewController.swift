//
//  MyPageViewController.swift
//  7ickboard
//
//  Created by t2023-m0074 on 4/22/24.
//

import UIKit

class MyPageViewController: UIViewController, UITableViewDataSource {
    
    var userModel = UserModel()
    // KickBoard 객체의 배열 선언
    var kickboards: [KickBoard] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == historyTableView {
            return array1.count
        } else if tableView == registeredTableView {
            return array2.count
        }
        return kickboards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == historyTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageTableViewCell", for: indexPath) as? MyPageTableViewCell else { return UITableViewCell() }
            let kickboard = kickboards[indexPath.row]
//            let users = self.userModel[indexPath.row]
//            let id = users.name
//            let title = users.telephone
//                    cell.textLabel?.text = "[\(id)] \(title)"
                    return cell
     //       cell.titleLabel.text = userModel.users[indexPath.row]
       // return cell
        } else if tableView == registeredTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageTableViewCell", for: indexPath) as? MyPageTableViewCell else { return UITableViewCell() }
            let kickboard = kickboards[indexPath.row]
            cell.titleLabel.text = array2[indexPath.row]
            return cell
        }
        
        
        
      return UITableViewCell()
    }

    // 스토리보드 레이블,텍스트필드,테이블뷰,버튼 IBAction,IBOutlet
    @IBOutlet weak var profileLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    @IBOutlet weak var driverLicenseLabel: UILabel!
    @IBOutlet weak var licenseTextField: UITextField!
    
    @IBOutlet weak var kickboardUsageHistoryLabel: UILabel!
    @IBOutlet weak var historyTableView: UITableView!
    
    @IBOutlet weak var registeredKickboardLabel: UILabel!
    @IBOutlet weak var registeredTableView: UITableView!
    
    var array1 = ["1","2","3"]
    var array2 = ["q","w","e","r"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyTableView.register(UINib(nibName: "MyPageTableViewCell", bundle: nil), forCellReuseIdentifier: "MyPageTableViewCell")
        registeredTableView.register(UINib(nibName: "MyPageTableViewCell", bundle: nil), forCellReuseIdentifier: "MyPageTableViewCell")
        historyTableView.dataSource = self
        registeredTableView.dataSource = self
        // KickBoard 객체 생성, kickboards 배열에 추가
        let kickboard1 = KickBoard(name: "Kickboard 1", latitude: Double(), longitude: Double())
        let kickboard2 = KickBoard(name: "Kickboard 2", latitude: Double(), longitude: Double())
        kickboards = [kickboard1, kickboard2]
        
        let a = UserModel().users[0]
        nameTextField.text = a.name
        phoneNumberTextField.text = a.telephone
    
        if a.driversLicense == true {
            licenseTextField.text = "인증"
        } else {
            licenseTextField.text = "미인증"
        }
    }
 
    @IBAction func logoutButton(_ sender: UIButton) {
      guard let nextVC = self.storyboard? .instantiateViewController( identifier: "" ) else { return }
        self.navigationController?.popToRootViewController(animated: true)
    }
    

}

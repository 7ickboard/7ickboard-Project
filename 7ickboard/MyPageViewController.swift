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
    var kickboards = KickBoard.kickboards

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == historyTableView {
            return UserModel.users[0].history.count// UserModel.users의 첫번째 유저가 가지고 있는 history array의 개수 리턴필요
        } else if tableView == registeredTableView {
            return kickboards.count
        }
        return kickboards.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if tableView == historyTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageTableViewCell", for: indexPath) as? MyPageTableViewCell else { return UITableViewCell() }
                   
            cell.titleLabel.text = "킥보드 - \(indexPath.row + 1)\t" + UserModel.users.first!.history[indexPath.row].formattedTime().0 + " ~ " + UserModel.users.first!.history[indexPath.row].formattedTime().1

        return cell
        } else if tableView == registeredTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageTableViewCell", for: indexPath) as? MyPageTableViewCell else { return UITableViewCell() }
            let kickboard = kickboards[indexPath.row]
            cell.titleLabel.text = kickboard.name + "\(indexPath.row + 1)"
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

    override func viewDidLoad() {
        super.viewDidLoad()
        historyTableView.register(UINib(nibName: "MyPageTableViewCell", bundle: nil), forCellReuseIdentifier: "MyPageTableViewCell")
        registeredTableView.register(UINib(nibName: "MyPageTableViewCell", bundle: nil), forCellReuseIdentifier: "MyPageTableViewCell")
        historyTableView.dataSource = self
        registeredTableView.dataSource = self

        let a = UserModel.users[0]

        nameTextField.text = a.name
        phoneNumberTextField.text = a.telephone

        if a.driversLicense == true {
            licenseTextField.text = "인증"
        } else {
            licenseTextField.text = "미인증"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        historyTableView.reloadData()
        registeredTableView.reloadData()
        kickboards = KickBoard.kickboards
    }
 
    @IBAction func logoutButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "AuthView", bundle: nil)
        guard let nextVC = storyboard.instantiateViewController(identifier: "LoginView") as? LoginViewController else { return }
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(nextVC)
    }
}

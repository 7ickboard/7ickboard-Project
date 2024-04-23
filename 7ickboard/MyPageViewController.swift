//
//  MyPageViewController.swift
//  7ickboard
//
//  Created by t2023-m0074 on 4/22/24.
//

import UIKit

class MyPageViewController: UIViewController {

    
    @IBOutlet weak var profileLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var nameLabel1: UILabel!
    
    @IBOutlet weak var phoneNumber: UILabel!
    
    @IBOutlet weak var phoneNumber1: UILabel!
    
    @IBOutlet weak var driverLicenseLabel: UILabel!
    
    @IBOutlet weak var certificationLabel: UILabel!
    
    @IBOutlet weak var kickboardUsageHistoryLabel: UILabel!
    
    @IBOutlet weak var historyTableView: UITableView!
    
    @IBOutlet weak var registeredKickboardLabel: UILabel!
        
    @IBOutlet weak var registeredTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let a = UserModel().users[0]
        nameLabel.text = a.name
        nameLabel1.text = a.name
        
        
    }
    @IBAction func logoutButton(_ sender: UIButton) {
        
    }
    

}

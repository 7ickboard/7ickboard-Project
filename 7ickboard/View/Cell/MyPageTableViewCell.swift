//
//  MyPageTableViewCell.swift
//  7ickboard
//
//  Created by t2023-m0074 on 4/23/24.
//

import UIKit

class MyPageTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var titleLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  UsersTBCell.swift
//  SenecaGlobalAssignment
//
//  Created by naresh banavath on 30/04/21.
//

import UIKit

class UsersTBCell: UITableViewCell {

  @IBOutlet weak var wholeView: UIView!
  @IBOutlet weak var emailIdLb: UILabel!
  @IBOutlet weak var lastNameLb: UILabel!
  @IBOutlet weak var firstNameLb: UILabel!
  @IBOutlet weak var userImgView: UIImageView!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    userImgView.layer.cornerRadius = 3.0
    wholeView.layer.cornerRadius = 5.0
    
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  func configureCell(user : UserModel?)
  {
    if let user = user
    {
      firstNameLb.text = user.firstName
      lastNameLb.text = user.lastName
      emailIdLb.text = user.email
      userImgView.loadImageUsingCacheWithURLString(user.avatar, placeHolder: nil)
    }
  }

}

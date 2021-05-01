//
//  MoreTBCell.swift
//  SenecaGlobalAssignment
//
//  Created by naresh banavath on 30/04/21.
//

import UIKit

class MoreTBCell: UITableViewCell {
  @IBOutlet weak var wholeView: UIView!
  @IBOutlet weak var emailLb: UILabel!
  
  @IBOutlet weak var cityLb: UILabel!
  @IBOutlet weak var catchPhraselb: UILabel!
  @IBOutlet weak var companyNameLb: UILabel!
  override func awakeFromNib() {
        super.awakeFromNib()
    wholeView.layer.cornerRadius = 5.0
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  func configure(user : MoreStructElement?) {
    companyNameLb.text = user?.company?.name
    catchPhraselb.text = user?.company?.catchPhrase
    cityLb.text = user?.address?.city
    emailLb.text = user?.email
  }

}

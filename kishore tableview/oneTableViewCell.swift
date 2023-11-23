//
//  oneTableViewCell.swift
//  kishore tableview
//
//  Created by macbook on 05/07/2023.
//

import UIKit

class oneTableViewCell: UITableViewCell {
    
    @IBOutlet weak var phonelabel: UILabel!
    
    @IBOutlet weak var namelabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

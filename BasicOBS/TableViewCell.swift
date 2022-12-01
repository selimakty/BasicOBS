//
//  TableViewCell.swift
//  BasicOBS
//
//  Created by Selim on 30.11.2022.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var dersLabel: UILabel!
    
    @IBOutlet weak var vizeLAbel: UILabel!
    
    @IBOutlet weak var finalLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

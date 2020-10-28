//
//  Cell1CreateTableViewCell.swift
//  F49
//
//  Created by Le Dat on 10/15/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class Cell1CreateTableViewCell: UITableViewCell {

    var enableKeyboard: Bool = true
       var idCell: Int?
       var callBackOpenView: (() -> Void)?
       var callBackValue:  ((_ value: String) -> Void)?
    
    @IBOutlet weak var thumbnailTitleLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var thumbnailButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
            }
    
    @IBAction func buttonPressed(_ sender: Any) {
        self.callBackOpenView?()
    }
}


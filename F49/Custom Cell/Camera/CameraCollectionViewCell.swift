//
//  CameraCollectionViewCell.swift
//  F49
//
//  Created by Le Dat on 10/12/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class CameraCollectionViewCell: UICollectionViewCell {

    var callBackButton: (() -> Void)?
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func handlerCallBackButton(handler: @escaping () -> Void){
        self.callBackButton = handler
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        callBackButton?()
    }
    
}

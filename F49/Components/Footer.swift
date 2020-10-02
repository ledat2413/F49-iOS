//
//  Footer.swift
//  F49
//
//  Created by Le Dat on 10/1/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import UIKit

final class Footer: UIView{
    private static let NIB_NAME = "Footer"

    @IBOutlet var view: UIView!
    
    @IBOutlet weak var CancelButton: UIButton!
    
    override func awakeFromNib() {
           initWithNib()
           
       }
       
       private func initWithNib() {
           Bundle.main.loadNibNamed(Footer.NIB_NAME, owner: self, options: nil)
           view.translatesAutoresizingMaskIntoConstraints = false
           addSubview(view)
           setupLayout()
       }
       private func setupLayout() {
           NSLayoutConstraint.activate(
               [
                   view.topAnchor.constraint(equalTo: topAnchor),
                   view.leadingAnchor.constraint(equalTo: leadingAnchor),
                   view.bottomAnchor.constraint(equalTo: bottomAnchor),
                   view.trailingAnchor.constraint(equalTo: trailingAnchor),
               ]
           )
       }
}

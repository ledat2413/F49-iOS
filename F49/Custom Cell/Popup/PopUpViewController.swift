//
//  PopUpViewController.swift
//  F49
//
//  Created by Le Dat on 11/3/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    
    
    @IBOutlet weak var buttonContainerView: UIView!
    @IBOutlet weak var errLabel: UILabel!
    
    @IBOutlet weak var buttonCancel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPopup()
    }
    
    
    @IBAction func buttonCancelPressed(_ sender: Any) {
        removeAnimate()
    }
    
    
    func setUpPopup(){
        buttonCancel.setGradientBackground(colorOne: Colors.brightOrange, colorTwo: Colors.orange)
        buttonCancel.display20()
        buttonContainerView.displayShadowView2(shadowColor: UIColor.darkGray, borderColor: UIColor.clear, radius: 20, offSet: CGSize(width: 3, height: 0))
    }
    
    
    func showAnimate(_ text: String)
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.errLabel.text = text
            
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
            
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
    
    
}

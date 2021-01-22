//
//  AddKhachHangViewController.swift
//  F49
//
//  Created by Dat  on 1/22/21.
//  Copyright © 2021 Le Dat. All rights reserved.
//

import UIKit

class AddKhachHangViewController: BaseController {

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var cmndTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    func setupUI(){
        cancelButton.displayCornerRadius(radius: 18.0)
        createButton.displayCornerRadius(radius: 18.0)
    }
    
    @IBAction func dismissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createCustomerButtonPressed(_ sender: Any) {
        let userInfo: [String: Any] = ["name": self.nameTextField.text ?? ""]
        let nc = NotificationCenter.default
        nc.post(name: NSNotification.Name(rawValue: "customer"), object: nil, userInfo: userInfo)
        self.dismiss(animated: true, completion: nil)
    }
}

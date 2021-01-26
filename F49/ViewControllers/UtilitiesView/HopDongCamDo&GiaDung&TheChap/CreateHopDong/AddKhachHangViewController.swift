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
    
    var dataKhachHang: KhachHangLuu?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    
    func setupUI(){
        cancelButton.displayCornerRadius(radius: 18.0)
        createButton.displayCornerRadius(radius: 18.0)
    }
    
    func luuKhachHang(){
        self.showActivityIndicator(view: self.view)
        MGConnection.requestObject(APIRouter.KhachHangLuu(hoTen: nameTextField.text ?? "", soCMND: cmndTextField.text ?? "", dienThoai: phoneTextField.text ?? "", queQuan: addressTextField.text ?? ""), KhachHangLuu.self) { (result, error) in
            self.hideActivityIndicator(view: self.view)
            guard error == nil else {
                print("\(String(describing: error?.mErrorMessage))")
                self.Alert("Lỗi \(error?.mErrorMessage ?? ""). Vui lòng thử lại!!!!")
                return }
            if let result = result {
                self.dataKhachHang = result
                let userInfo: [String: Any] = ["name" : result.hoTen, "id" : result.id]
                let nc = NotificationCenter.default
                nc.post(name: NSNotification.Name(rawValue: "customer"), object: nil, userInfo: userInfo)
            }
            
        }
    }
    
    @IBAction func dismissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createCustomerButtonPressed(_ sender: Any) {
        self.luuKhachHang()
        self.dismiss(animated: true, completion: nil)
    }
}

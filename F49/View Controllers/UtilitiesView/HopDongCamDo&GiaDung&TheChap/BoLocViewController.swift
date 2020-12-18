//
//  BoLocViewController.swift
//  F49
//
//  Created by Le Dat on 9/24/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class BoLocViewController: BaseController {
    
    //MARK: --Vars
    var dataStatus: [StatusHopDong] = []
    var selectedStatus: String?
    var height: CGFloat = 0.0
    
    var callBackValue: ((_ idStatus: String?, _ text: String?) -> Void)?
    
    //MARK: --IBOutlet
    @IBOutlet weak var findTextFiled: UITextField!
    @IBOutlet weak var statusTextField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var reMakeButton: UIButton!
    
    @IBOutlet weak var bolocContainerView: UIView!
 
    @IBOutlet weak var bottomBoLocContainerView: NSLayoutConstraint!
    
    
    //MARK: --View Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        findTextFiled.delegate = self
        statusTextField.delegate = self
        
        hideKeyboardWhenTappedAround()
        
        loadStatus()
        createPickerView()
        
        doneButton.setGradientBackground(colorOne: Colors.brightOrange, colorTwo: Colors.orange)
        doneButton.displayCornerRadius(radius: 20)
        
        reMakeButton.displayCornerRadius(radius: 20)
        reMakeButton.layer.borderColor = UIColor.gray.cgColor
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.statusTextField.text =  UserHelper.getUserData(key: UserKey.BoLocTrangThai)
        self.findTextFiled.text = UserHelper.getUserData(key: UserKey.BoLocTextField)
    }
        
    
    //MARK: --IBAction
    @IBAction func reMakeButtonPressed(_ sender: Any) {
        callBackValue?(nil,nil)
        UserHelper.clearUserData(key: UserKey.BoLocTrangThai)
        UserHelper.clearUserData(key: UserKey.BoLocTextField)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        //request api
        callBackValue?(selectedStatus ?? "" ,findTextFiled.text!)
        
        self.dismiss(animated: true, completion: nil)

    }
    
    @IBAction func dismissButtonPresseed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: --Func
    
    @objc func keyboardWillShow(notification: NSNotification) {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if self.bottomBoLocContainerView.constant == 0 {
                    self.bottomBoLocContainerView.constant = keyboardSize.height
                }
                
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.bottomBoLocContainerView.constant > 0 {
            self.bottomBoLocContainerView.constant = 0
        }
        
    }
    
    
    func loadStatus(){
        MGConnection.requestArray(APIRouter.GetTrangThaiHopDong, StatusHopDong.self) { (result, error) in
            guard error == nil else {   
                print("Error \(error?.mErrorMessage ?? "") and \(error?.mErrorCode ?? 0)")
                return
            }
            if let result = result {
                self.dataStatus = result
            }
            
        }
    }
    
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        statusTextField.inputView = pickerView
        self.createToolbar(textField: statusTextField, selector: #selector(action))
    }
    
    @objc func action() {
        loadStatus()
        view.endEditing(true)
    }
    
}


extension BoLocViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataStatus.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataStatus[row].value
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedStatus = dataStatus[row].value
        statusTextField.text = selectedStatus
        UserHelper.saveUserData(statusTextField.text, key: UserKey.BoLocTrangThai)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UserHelper.saveUserData(findTextFiled.text, key: UserKey.BoLocTextField)
    }

}


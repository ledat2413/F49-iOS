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

    var callBackValue: ((_ idStatus: String?, _ text: String?) -> Void)?
    
    //MARK: --IBOutlet
    @IBOutlet weak var findTextFiled: UITextField!
    @IBOutlet weak var statusTextField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var reMakeButton: UIButton!
    
    
    //MARK: --View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadStatus()
        createPickerView()
        doneButton.setGradientBackground(colorOne: Colors.brightOrange, colorTwo: Colors.orange)
        doneButton.display20()
        reMakeButton.display20()
        reMakeButton.layer.borderColor = UIColor.gray.cgColor
    }
    
    //MARK: --IBAction
    @IBAction func reMakeButtonPressed(_ sender: Any) {
        callBackValue?(nil,nil)
        self.dismiss(animated: true, completion: nil)

    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        //request api
        callBackValue?(selectedStatus ?? "" ,findTextFiled.text!)

        self.dismiss(animated: true, completion: nil)

//        boLocPressed?.boLocPressed(status: selectedStatus!, tukhoa: findTextFiled.text!)
//
    }
    
    @IBAction func dismissButtonPresseed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: --Func
    
    func loadStatus(){
        self.showSpinner(onView: self.view)
        MGConnection.requestArray(APIRouter.GetTrangThaiHopDong, StatusHopDong.self) { (result, error) in
            self.removeSpinner()
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
           let pickerView = UIPickerView().createPicker(tf: statusTextField)
           pickerView.delegate = self
           let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(BoLocViewController.action))
           statusTextField.inputAccessoryView = toolBar
       }
       
       @objc func action() {
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
    }
}

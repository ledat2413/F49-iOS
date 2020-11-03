//
//  KhachHangViewController.swift
//  F49
//
//  Created by Le Dat on 10/17/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class KhachHangViewController: BaseController {

    //MARK: --Vars
    private var dataTimKiem: [TimKiem] = []
    var tenKH: ((_ ten: String, _ id: Int) -> Void)?
    
    //MARK: --IBOutlet
    
    @IBOutlet weak var conteinerView: UIView!
    
    @IBOutlet weak var findContainerView: UIView!
    @IBOutlet weak var findTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
        
    //MARK: --View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        // Do any additional setup after loading the view.
    }

    deinit {
        print("deinit khachhangview")
    }
    //MARK: --IBAction
    @IBAction func dismissButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func findButtonPressed(_ sender: Any) {
        loadKhachHang(findTextField.text!)

    }
    
    
    //MARK: --Func
    
    func handlerTenKH(handler: @escaping (_ ten: String, _ id: Int) -> Void){
        self.tenKH = handler
    }
    
    private func setUpUI(){
        
        //Table View
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "KhachHangHopDongTheChapTableViewCell", bundle: nil), forCellReuseIdentifier: "KhachHangHopDongTheChapTableViewCell")
        //View
        findContainerView.displayShadowView2(shadowColor: UIColor.darkGray, borderColor: UIColor.clear, radius: 0, offSet: CGSize(width: 3, height: 0))
        //Data
        loadKhachHang(findTextField.text!)
    }
    
    
    private func loadKhachHang(_ key: String){
        MGConnection.requestArray(APIRouter.TimKiemKhachHang(key: key), TimKiem.self) { (result, error) in
            guard error == nil else {
                self.Alert("Lỗi \(error?.mErrorMessage ?? ""). Vui lòng thử lại!!!!")
                return }
            if let result = result {
                self.dataTimKiem = result
                if result.isEmpty {
                    self.Alert("Không có dữ liệu")
                }
                self.tableView.reloadData()
            }
        }
    }
}

extension KhachHangViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataTimKiem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "KhachHangHopDongTheChapTableViewCell", for: indexPath) as? KhachHangHopDongTheChapTableViewCell else { fatalError() }
        let data = dataTimKiem[indexPath.row]
        cell.idLabel.text = "\(data.id)"
        cell.nameLabel.text = data.hoTen
        cell.nameLabel.textColor = UIColor.systemGreen
        cell.cmndLabel.text = data.soCMND
        cell.phoneLabel.text = data.dienThoai
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true) {
            if let tenKH = self.tenKH {
                tenKH(self.dataTimKiem[indexPath.row].hoTen, self.dataTimKiem[indexPath.row].id)
            }
        }
    }
}




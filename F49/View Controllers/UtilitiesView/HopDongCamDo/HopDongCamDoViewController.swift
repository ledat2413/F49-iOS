//
//  HopDongCamDoViewController.swift
//  F49
//
//  Created by Le Dat on 9/22/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit
import SnapKit

class HopDongCamDoViewController: UIViewController {
    
    //MARK: --Vars
    var views: [UIView] = []
    
    
    //MARK: --IBOutlet
    @IBOutlet weak var headerView: NavigationBar!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var shopContainerView: UIView!
    @IBOutlet weak var shopTextField: UITextField!
    @IBOutlet weak var segmentedControl: CustomSegmentedControl!{
        didSet{
            segmentedControl.setButtonTitles(buttonTitles: ["HĐ mở","HĐ thanh lý","HĐ tất toán"])
            segmentedControl.selectorViewColor = .orange
            segmentedControl.selectorTextColor = .orange
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        displayHeaderView()
//        selectIndex(segmentedControl)
        
    }
    
//    func selectIndex(_ sender: CustomSegmentedControl){
//        self.contentView.bringSubviewToFront(views[sender.selectedIndex])
//    }
//
    //MARK: --IBAction
    @IBAction func locButtonPressed(_ sender: Any) {
    }
    
    //MARK: --Func
    private func setUpUI(){
        views.append(HopDongMoViewController().view)
        views.append(HopDongThanhLyViewController().view)
        views.append(HopDongMoViewController().view)
        for v in views {
            contentView.addSubview(v)
            v.snp.makeConstraints { (marker) in
                marker.edges.equalTo(contentView)
            }
        }
        contentView.bringSubviewToFront(views[0])
    }
    
    
    private func displayHeaderView(){
        headerView.title = "Quản lí hợp đồng cầm đồ"
        headerView.leftButton.addTarget(self, action: #selector(backView), for: .allEvents)
        headerView.leftButton.setImage(UIImage(named: "icon-arrow-left"), for: .normal)
    }
    
    @objc func backView(){
        self.navigationController?.popViewController(animated: true)
    }
}

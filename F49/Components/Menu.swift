//
//  Menu.swift
//  F49
//
//  Created by Le Dat on 9/18/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import UIKit

class Menu: UIView{
    
    private static let NIB_NAME = "Menu"
    var dataMenu: MenuHeader?
    var callBack: ((_ index: Int) -> Void)?

    
    @IBOutlet var view: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        initWithNib()
        
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(UINib(nibName: "HeaderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HeaderCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func initWithNib() {
        Bundle.main.loadNibNamed(Menu.NIB_NAME, owner: self, options: nil)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        setupLayout()
        loadMenu()
    }
    
    func displayShadowView(_ view: UIView) {
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 0.5
        view.layer.cornerRadius = 6
    }
    
    

    
    func loadMenu(){
        MGConnection.requestObject(APIRouter.GetTopMenu, MenuHeader.self) { (result, error) in
            guard error == nil else{
                print("Error")
                return
            }
            if let result = result {
                self.dataMenu = result
                print(result)
                self.collectionView.reloadData()
            }
        }
    }
    
    func shadow(_ cell: UIView) {
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0);
        cell.layer.shadowRadius = 1.0;
        cell.layer.shadowOpacity = 0.5;
        cell.clipsToBounds = false
    }
    
    func setupLayout() {
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

extension Menu: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        callBack?(indexPath.section)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCollectionViewCell", for: indexPath) as? HeaderCollectionViewCell else {fatalError()}
        
        let img: [UIImage?] = [UIImage(named: "icon-dashboard-camdo"),UIImage(named: "icon-dashboard-dinhgia"),UIImage(named: "icon-dashboard-dogiadung")]
        let title: [String?] = ["CẦM ĐỒ","ĐỊNH GIÁ","ĐỒ GIA DỤNG"]
        
        switch indexPath.section {
        case 0:
            cell.thumbnailImageView.image = img[0]
            cell.thumbnailTitleLabel.text = title[0]
            cell.thumbnailCountLabel.text = "\(dataMenu?.camDo ?? 0)"
            displayShadowView(cell)
            
            shadow(cell)
            cell.layer.shadowPath = UIBezierPath(roundedRect:  cell.bounds, cornerRadius: cell.thumbnailView.layer.cornerRadius).cgPath
            return cell
        case 1:
            cell.thumbnailImageView.image = img[1]
            cell.thumbnailTitleLabel.text = title[1]
            cell.thumbnailCountLabel.text = "\(dataMenu?.dinhGia ?? 0)"
            displayShadowView(cell)
            
            shadow(cell)
            cell.layer.shadowPath = UIBezierPath(roundedRect:  cell.bounds, cornerRadius: cell.thumbnailView.layer.cornerRadius).cgPath
            return cell
        case 2:
            cell.thumbnailImageView.image = img[2]
            cell.thumbnailTitleLabel.text = title[2]
            cell.thumbnailCountLabel.text = "\(dataMenu?.doGiaDung ?? 0)"
            displayShadowView(cell)
            
            shadow(cell)
            cell.layer.shadowPath = UIBezierPath(roundedRect:  cell.bounds, cornerRadius: cell.thumbnailView.layer.cornerRadius).cgPath
            return cell
        default:
            return cell
        }
    }
}

extension Menu: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width)/3 - 20, height: (collectionView.frame.height) - 20)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(5)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    }
}



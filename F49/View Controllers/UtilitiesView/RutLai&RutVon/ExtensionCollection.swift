//
//  ExtensionCollection.swift
//  F49
//
//  Created by Le Dat on 10/1/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import UIKit


extension RutLaiChiTietViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if idTab == 1 {
            return 2
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ButtonFooterCollectionViewCell", for: indexPath) as? ButtonFooterCollectionViewCell else { fatalError() }
        if idTab == 1{
            switch indexPath.row {
            case 0:
                cell.thumbnailLabel.backgroundColor = UIColor.groupTableViewBackground
                cell.thumbnailLabel.text = "Từ chối"
                cell.thumbnailLabel.display20()
            case 1:
                cell.thumbnailLabel.backgroundColor = UIColor.orange
                cell.thumbnailLabel.text = "Đồng ý"
                cell.thumbnailLabel.textColor = .white
                cell.thumbnailLabel.display20()
                
            default:
                return cell
            }
        }else {
            cell.thumbnailLabel.backgroundColor = UIColor.groupTableViewBackground
            cell.thumbnailLabel.text = "Đóng"
            cell.thumbnailLabel.display20()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if idTab == 1{
            switch indexPath.row {
            case 0:
                self.navigationController?.popViewController(animated: true)
                break
            case 1:
                let params: [String: Any] = ["id": idItem, "yKien": yKienTextView.text ?? "", "trangThai": true]
                MGConnection.requestObject(APIRouter.PutDuyetRutVon(params: params), VonDauTuChiTiet.self) { (result, error) in
                    guard error == nil else {
                        print("Error: \(error?.mErrorMessage ?? "") and \(error?.mErrorCode ?? 0)")
                        self.Alert("Duyệt không thành công")
                        return
                    }
                    if let result = result {
                        self.dataChiTiet = result
                        self.Alert("Accept Completed")
                        self.navigationController?.popViewController(animated: true)
                    }
                }
                break
            default:
                break
            }
        }else {
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
}
extension RutLaiChiTietViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if idTab == 1 {
            return CGSize(width: collectionView.frame.width / 2 - 10, height: collectionView.frame.height )
            
        }else {
            return CGSize(width: collectionView.frame.width / 2 , height: collectionView.frame.height )
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if idTab == 1{
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        }else {
            return UIEdgeInsets(top: 0, left: collectionView.frame.width / 3 - 30, bottom: 0, right: 0)

        }
        
    }
}

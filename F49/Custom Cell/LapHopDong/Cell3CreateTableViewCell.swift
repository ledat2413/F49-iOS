//
//  Cell3CreateTableViewCell.swift
//  F49
//
//  Created by Le Dat on 10/15/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit
import Gallery

class Cell3CreateTableViewCell: UITableViewCell {
    
    //MARK: --Vars
    var itemImages: [UIImage?] = []
    var callBackOpenCamera: (() -> Void)?
    
    
    //MARK: --IBOutlet
    @IBOutlet weak var thumbnailCollectionView: UICollectionView!
    
    //MARK: --View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbnailCollectionView.register(UINib(nibName: "Cell3CreateCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell3CreateCollectionViewCell")
        thumbnailCollectionView.dataSource = self
        thumbnailCollectionView.delegate = self
        print(itemImages.count)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: --Func
    func loadData(_ images: [UIImage?]){
        
              itemImages = images

            print("Images \(itemImages.count)" )

            self.thumbnailCollectionView.reloadData()

        
    }
}

extension Cell3CreateTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
      guard let cell = thumbnailCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell3CreateCollectionViewCell", for: indexPath) as? Cell3CreateCollectionViewCell else { fatalError() }
        cell.imageCell3CollectionView.image = itemImages[indexPath.row]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            callBackOpenCamera?()
        default:
            break
        }
    }
}


extension Cell3CreateTableViewCell: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 65, height: 65 )
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
    }
}

//
//  CameraViewController.swift
//  F49
//
//  Created by Le Dat on 10/10/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit
import Gallery

class CameraViewController: BaseController{
    
    var imageViewPic: UIImageView?
    var gallery: GalleryController!
    var itemImages:[UIImage?] = []
    var data: Bool?
    var imgStr: String = ""
    var soHopDong: String = ""
    
    
    //MARK: --IBOutlet
    
    @IBOutlet weak var navigation: NavigationBar!
    @IBOutlet weak var cameraButton: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var footerView: UIView!
    
    @IBOutlet weak var footerCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        // Do any additional setup after loading the view.
    }
    
    //MARK: --Func
    
    func setUpUI(){
        
        //CollectioView
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CameraCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CameraCollectionViewCell")
        
        //FooterCollectionView
        footerCollectionView.register(UINib(nibName: "ButtonFooterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ButtonFooterCollectionViewCell")
        footerCollectionView.delegate = self
        footerCollectionView.dataSource = self
        
        //Navigation
        navigation.title = "Hình ảnh"
        navigation.leftButton.addTarget(self, action: #selector(backView), for: .allEvents)
        
        //Footer
        footerView.displayShadowView2(shadowColor: UIColor.darkGray, borderColor: UIColor.clear, radius: 0, offSet: CGSize(width: 3, height: 0))
        
        //
        
    }
    
    
    func popView(action: UIAlertAction){
        print("Pop View")
        NotificationCenter.default.post(name: NSNotification.Name.init("Upload"), object: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func backView(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func removeItem(){
        itemImages.removeAll()
        self.collectionView.reloadData()
        print("remove")
    }

    
    //MARK: --IBAction
    
    @IBAction func cameraButtonPressed(_ sender: Any) {
        itemImages = []
        showImageGallery()
    }
    
    private func showImageGallery(){
        
        self.gallery  = GalleryController()
        self.gallery.delegate = self
        
        Config.Camera.imageLimit = 1
        Config.tabsToShow = [.imageTab,.cameraTab]
        
        self.present(self.gallery, animated: true, completion: nil)
        
    }
}

extension CameraViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case footerCollectionView:
            return 2
        default:
            return itemImages.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case footerCollectionView:
            guard let cell = footerCollectionView.dequeueReusableCell(withReuseIdentifier: "ButtonFooterCollectionViewCell", for: indexPath) as? ButtonFooterCollectionViewCell else { fatalError() }
            switch indexPath.row {
            case 0:
                cell.thumbnailLabel.backgroundColor = UIColor.groupTableViewBackground
                cell.thumbnailLabel.text = "Huỷ"
                cell.thumbnailLabel.display20()
            case 1:
                cell.thumbnailLabel.backgroundColor = UIColor.orange
                cell.thumbnailLabel.text = "Đồng ý"
                cell.thumbnailLabel.textColor = .white
                cell.thumbnailLabel.display20()
                
            default:
                return cell
            }
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CameraCollectionViewCell", for: indexPath) as? CameraCollectionViewCell else { fatalError() }
            
            cell.thumbnailImageView.image = itemImages[indexPath.row]
            
            let imageData: Data? = resizeImage(image: itemImages[indexPath.row]!, newWidth: CGFloat(150.0)).jpegData(compressionQuality: 1)
            imgStr = imageData?.base64EncodedString(options: .lineLength64Characters) ?? ""
            
            cell.deleteButton.addTarget(self, action: #selector(removeItem), for: .allEvents)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case footerCollectionView:
            switch indexPath.row {
            case 0:
                self.navigationController?.popViewController(animated: true)
                break
            case 1:
                self.showSpinner(onView: self.view)

                MGConnection.requestBoolean(APIRouter.UploadImage(imgStr: imgStr, soHopDong: soHopDong), returnType: data) { (result, error) in
                    self.removeSpinner()
                    guard error == nil else {
                        self.Alert("Upload không thành công!")
                        return
                    }
                   let alert = UIAlertController(title: "Thông Báo", message: "Upload thành công", preferredStyle: UIAlertController.Style.alert)
                                      // add an action (button)
                               alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: self.popView))
                                      
                                      // show the alert
                                      self.present(alert, animated: true, completion: nil)
                }
                break
            default:
                break
            }
        default:
            break
        }
    }
}

extension CameraViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case footerCollectionView:
            return CGSize(width: collectionView.frame.width / 2 - 10, height: collectionView.frame.height )
        default:
            return CGSize(width: collectionView.frame.width / 4 , height: collectionView.frame.width / 4 )
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch collectionView {
        case footerCollectionView:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        default:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
    }
}

extension CameraViewController: GalleryControllerDelegate{
    
    func galleryController(_ controller: GalleryController, didSelectImages images: [Image]) {
        
        if images.count > 0 {
            Image.resolve(images: images) { (imageResolve) in
                self.itemImages = imageResolve
                self.collectionView.reloadData()

            }
        }
        controller.dismiss(animated: true, completion: nil)
    }
    
    func galleryController(_ controller: GalleryController, didSelectVideo video: Video) {
        self.collectionView.reloadData()

        controller.dismiss(animated: true, completion: nil)
    }
    
    func galleryController(_ controller: GalleryController, requestLightbox images: [Image]) {
        self.collectionView.reloadData()

        controller.dismiss(animated: true, completion: nil)
    }
    
    func galleryControllerDidCancel(_ controller: GalleryController) {
        self.collectionView.reloadData()
        controller.dismiss(animated: true, completion: nil)
    }
    
    
}

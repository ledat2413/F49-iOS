//
//  AlertView.swift
//  OPLUS
//
//  Created by Van Le on 11/23/20.
//  Copyright © 2020 Van Le. All rights reserved.
//

import UIKit

class AlertView: UIView {
    
    enum ButtonType: String {
        case Cancel
        case Agree
    }

    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var agreeButton: UIButton?
    @IBOutlet weak var cancelButton: UIButton?
    @IBOutlet weak var closeButton: UIButton?
    
    private static let shared = Bundle.main.loadNibNamed("AlertView", owner: nil, options: nil)?.first as! AlertView
    private static let sharedConfirm = Bundle.main.loadNibNamed("AlertView", owner: nil, options: nil)?[1] as! AlertView
    private static let sharedErrorNetwork = Bundle.main.loadNibNamed("AlertView", owner: nil, options: nil)?.last as! AlertView

    override func awakeFromNib() {
        super.awakeFromNib()
        self.frame = UIScreen.main.bounds
    }
    
    static func show(message: String?, selectButtonHandler: ((_ buttonType: ButtonType) -> Void)? = nil) {
        shared.show(message: message, selectButtonHandler: selectButtonHandler)
    }
    
    static func showConfirm(message: String?, selectButtonHandler: ((_ buttonType: ButtonType) -> Void)?) {
        sharedConfirm.show(message: message, selectButtonHandler: selectButtonHandler)
    }
    
    static func showErrorNetwork() {
        sharedErrorNetwork.show(message: "Không có kết nối mạng\nvui lòng thử lại.")
    }
        
    private func show(message: String?, selectButtonHandler: ((_ buttonType: ButtonType) -> Void)? = nil) {
        guard let message = message else { return }
        guard let vc = ScreenManager.topViewController() else { return }
        messageLabel.text = message
        vc.view.addSubview(self)
        self.alpha = 0
        let frame = self.contentView.frame
        self.contentView.frame.origin.y = frame.origin.y - frame.size.height
        UIView.animate(withDuration: 0.25) {
            self.alpha = 1
            self.contentView.frame.origin.y = frame.origin.y
        }
        
        self.agreeButton?.onTap { (_) in
            selectButtonHandler?(.Agree)
            self.closeView()
        }
        self.cancelButton?.onTap { (_) in
            selectButtonHandler?(.Cancel)
            self.closeView()
        }
        self.closeButton?.onTap({ (_) in
            self.closeView()
        })
        
    }
    
    fileprivate func closeView() {
        let frame = contentView.frame
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            guard let wself = self else { return }
            wself.alpha = 0
            wself.contentView.frame.origin.y = frame.origin.y - frame.size.height
            wself.alpha = 0
        }) { [weak self] (_) in
            guard let wself = self else { return }
            wself.removeFromSuperview()
        }
    }
}

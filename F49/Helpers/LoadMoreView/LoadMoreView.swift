//
//  LoadMoreView.swift
//  TTC
//
//  Created by MacBookPro on 7/17/19.
//  Copyright © 2019 Luan Tran. All rights reserved.
//

import UIKit

enum LoadMoreStatus{
    case loading
    case finished
    case haveMore
}

class LoadMoreView: UIView {
    
    @IBOutlet fileprivate weak var loadMoreIndicator: UIActivityIndicatorView!

    class func instanceFromNib() -> LoadMoreView {
        return UINib(nibName: "LoadMoreView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! LoadMoreView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
    }

    var status: LoadMoreStatus = .finished {
        didSet {
            if status == .loading {
                self.loadMoreIndicator.startAnimating()
            } else {
                self.loadMoreIndicator.stopAnimating()
            }
        }
    }
}

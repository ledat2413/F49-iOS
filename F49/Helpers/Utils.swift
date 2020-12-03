//
//  Utils.swift
//  F49
//
//  Created by Le Dat on 12/2/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import UIKit

class Utils{
    public func getNib(object: AnyClass) -> UINib {
        return UINib(nibName: getClassName(object: object), bundle: nil)
    }
    public func getClassName(object: AnyClass) -> String {
        return String(describing: object)
    }
}

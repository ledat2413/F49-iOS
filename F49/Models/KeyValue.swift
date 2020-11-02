//
//  KeyValue.swift
//  F49
//
//  Created by Le Dat on 10/20/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation


class KeyValueModel {
    var title: String = ""
    var value: Bool = false
    
    init(title: String, value: Bool) {
        self.title = title
        self.value = value
    }
    
}

class TSTheChap {
    var tenTS: String = ""
    var idTS: Int = 0
    var dinhGia: Int = 0
    var viTri: String = ""
    var moTa: String = ""
    var imgURL: String = ""
    
    init(tenTS: String,idTS: Int, dinhGia: Int, viTri: String, moTa: String, imgURL: String) {
        self.tenTS = tenTS
        self.idTS = idTS
        self.dinhGia = dinhGia
        self.viTri = viTri
        self.moTa = moTa
        self.imgURL = imgURL
    }
}

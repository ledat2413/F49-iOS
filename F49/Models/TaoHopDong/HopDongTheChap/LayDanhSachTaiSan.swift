//
//  DanhSachTaiSan.swift
//  F49
//
//  Created by Le Dat on 10/18/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import ObjectMapper

class TaiSanHDTheChap: Mappable{
    
    var id: Int = 0
    var tenVatCamCo: String = ""
    var loai: String = ""
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        tenVatCamCo <- map["tenVatCamCo"]
        loai <- map["loai"]
    }
}

class ThuocTinhTaiSanHDTheChap: Mappable{
    
    var key: String = ""
    var title: String = ""
    var dataType: String = ""
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        key <- map["key"]
        title <- map["title"]
        dataType <- map["dataType"]
    }
}

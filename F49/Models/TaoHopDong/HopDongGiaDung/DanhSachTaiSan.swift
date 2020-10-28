//
//  DanhSachTaiSan.swift
//  F49
//
//  Created by Le Dat on 10/25/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import ObjectMapper

class HDGDDSTaiSan: Mappable{
    
    var id: Int = 0
    var tenVatCamCo: String = ""
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        tenVatCamCo <- map["tenVatCamCo"]
    }
    
    
}

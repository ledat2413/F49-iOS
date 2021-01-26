//
//  KhachHangLuu.swift
//  F49
//
//  Created by Dat  on 1/25/21.
//  Copyright © 2021 Le Dat. All rights reserved.
//

import Foundation
import ObjectMapper

class KhachHangLuu: Mappable{
 
    var id: Int = 0
    var hoTen: String = ""
    var soCMND: String = ""
    var dienThoai: String = ""
    var queQuan: String = ""
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        hoTen <- map["hoTen"]
        soCMND <- map["soCMND"]
        dienThoai <- map["dienThoai"]
        queQuan <- map["queQuan"]

    }
    
    
}

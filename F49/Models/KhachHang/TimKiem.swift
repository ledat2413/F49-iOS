//
//  TimKiem.swift
//  F49
//
//  Created by Le Dat on 10/19/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import ObjectMapper

class TimKiem: Mappable{

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
        queQuan <- map[queQuan]

    }
    
    
}

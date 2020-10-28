//
//  TienKhachNhan.swift
//  F49
//
//  Created by Le Dat on 10/20/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import ObjectMapper

class SoTienKhachNhan: Mappable{
    
    var soTienCatLaiTruoc: Int = 0
    var soTienKhachNhan: Int = 0
    var ngayDongLai: String = ""
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        soTienCatLaiTruoc <- map["soTienCatLaiTruoc"]
        soTienKhachNhan <- map["soTienKhachNhan"]
        ngayDongLai <- map["ngayDongLai"]

    }
}

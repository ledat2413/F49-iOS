//
//  HDGDTinhTien.swift
//  F49
//
//  Created by Le Dat on 10/23/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import ObjectMapper

class TienKhachNhanHDGD: Mappable{
    
    var soTienCatLaiTruoc: Int = 0
    var soTienKhachNhan: Int = 0
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        soTienCatLaiTruoc <- map["soTienCatLaiTruoc"]
        soTienKhachNhan <- map["soTienKhachNhan"]
    }

}

class TinhTien: Mappable {
    
    var soTien: Int = 0
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        soTien <- map["soTien"]
    }

}

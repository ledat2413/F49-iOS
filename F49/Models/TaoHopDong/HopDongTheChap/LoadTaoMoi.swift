//
//  LoadTaoMoi.swift
//  F49
//
//  Created by Le Dat on 10/20/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import ObjectMapper

class LoadTaoMoiHDTC: Mappable{

    var ngayVay: String = ""
    var ngayVaoSo: String = ""
    var canChangeNgayVay: Bool = false
    var laiXuat: Int = 0
    var kyDongLai: Int = 0
    var catLaiTruoc: Bool = false
    var ngayDongLai: String = ""
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        ngayVay <- map["ngayVay"]
        ngayVaoSo <- map["ngayVaoSo"]
        canChangeNgayVay <- map["canChangeNgayVay"]
        laiXuat <- map["laiXuat"]
        kyDongLai <- map["kyDongLai"]
        catLaiTruoc <- map["catLaiTruoc"]
        ngayDongLai <- map["ngayDongLai"]

    }
}

//
//  HDGDLoadTaoMoi.swift
//  F49
//
//  Created by Le Dat on 10/23/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import ObjectMapper

class LoadTaoMoiHDGD: Mappable{

    var ngayVay: String = ""
    var ngayVaoSo: String = ""
    var canChangeNgayVay: Bool = false
    var soNgayTrongKy: Int = 0
    var soNgayVay: Int = 0
    var catLaiTruoc: Bool = false
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        ngayVay <- map["ngayVay"]
        ngayVaoSo <- map["ngayVaoSo"]
        canChangeNgayVay <- map["canChangeNgayVay"]
        soNgayVay <- map["soNgayVay"]
        soNgayTrongKy <- map["soNgayTrongKy"]
        catLaiTruoc <- map["catLaiTruoc"]

    }
}

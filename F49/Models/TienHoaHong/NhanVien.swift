//
//  NhanVien.swift
//  F49
//
//  Created by Le Dat on 10/7/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import ObjectMapper

class NhanVien: Mappable{

    var hoTen: String = ""
    var taiKhoan: String = ""
    var id: Int = 0
    var ngayTao: String = ""
    var email: String = ""
    var diaChi: String = ""
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        hoTen <- map["hoTen"]
        taiKhoan <- map["taiKhoan"]
        id <- map["id"]
        ngayTao <- map["ngayTao"]
        email <- map["email"]
        diaChi <- map["diaChi"]

    }
}

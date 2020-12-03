//
//  DanhSachNhanVien.swift
//  F49
//
//  Created by Le Dat on 9/30/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class DanhSachNhanVien: Object, Mappable{

    @objc dynamic var hoTen: String = ""
    @objc dynamic var taiKhoan: String = ""
    @objc dynamic var id: Int = 0

    @objc dynamic var ngayTao: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var diaChi: String = ""

    
    required convenience init?(map: Map) {
        self.init()
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

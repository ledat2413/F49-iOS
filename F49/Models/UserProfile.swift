//
//  UserProfile.swift
//  F49
//
//  Created by Le Dat on 9/8/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class UserProfile: Object, Mappable{
    
    @objc dynamic var id: Int = 0
    @objc dynamic var taiKhoan: String = ""
    @objc dynamic var hoTen: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var dienThoai: String = ""
    @objc dynamic var diaChi: String = ""
    @objc dynamic var hinh: String = ""
    @objc dynamic var phanQuyen: String = ""
    @objc dynamic var idCuaHangMacDinh: String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        taiKhoan <- map["taiKhoan"]
        hoTen <- map["hoTen"]
        email <- map["email"]
        dienThoai <- map["dienThoai"]
        diaChi <- map["diaChi"]
        hinh <- map["hinh"]
        phanQuyen <- map["phanQuyen"]
        idCuaHangMacDinh <- map["idCuaHangMacDinh"]
    }
}


//
//  HopDongTheoLoai.swift
//  F49
//
//  Created by Le Dat on 9/23/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import ObjectMapper

class HopDongTheoLoai: Mappable{
    
    @objc dynamic var id: Int = 0
    @objc dynamic var soHopDong: String = ""
    @objc dynamic var tenKhachHang: String = ""
    @objc dynamic var duNoHienTai: String = ""
    @objc dynamic var laiPhaiThu: String = ""
    @objc dynamic var maMau: String = ""
    @objc dynamic var idKhachHang: Int = 0
    @objc dynamic var soNgayQuaHan: Int = 0

    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        soHopDong <- map["soHopDong"]
        tenKhachHang <- map["tenKhachHang"]
        duNoHienTai <- map["duNoHienTai"]
        laiPhaiThu <- map["laiPhaiThu"]
        maMau <- map["maMau"]
        idKhachHang <- map["idKhachHang"]
        soNgayQuaHan <- map["soNgayQuaHan"]
    }
    
    
    
}

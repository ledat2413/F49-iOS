//
//  ThuLai.swift
//  F49
//
//  Created by Le Dat on 10/7/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import ObjectMapper

class ChiTietHopDongThuLai: Mappable{
    
    var id: Int = 0
    var soHopDong: String = ""
    var tenKhachHang: String = ""
    var noGoc: Int = 0
    var noLai: Int = 0
    var phaiThu: Int = 0
    var soTienVay: Int = 0
    var idCuaHang: Int = 0
    var tenCuaHang: String = ""
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        soHopDong <- map["soHopDong"]
        tenKhachHang <- map["tenKhachHang"]
        noGoc <- map["noGoc"]
        noLai <- map["noLai"]
        phaiThu <- map["phaiThu"]
        soTienVay <- map["soTienVay"]
        idCuaHang <- map["idCuaHang"]
        tenCuaHang <- map["tenCuaHang"]
    }

}

class LoaiGiaoDich: Mappable{
    
    var id: Int = 0
    var value: String = ""
  
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        value <- map["value"]
       
    }

}

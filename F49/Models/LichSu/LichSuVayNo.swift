//
//  LichSuVayNo.swift
//  F49
//
//  Created by Le Dat on 10/5/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import ObjectMapper

class LichSuVayNo: Mappable{
    
    var id: Int = 0
    var tenKhachHang: String = ""
    var tenCuaHang: String = ""
    var soHopDong: String = ""
    var ngayVay: String = ""
    var hinhThucVay: String = ""
    var soTien: Int = 0
    var daTra: Int = 0
    var laiDaThu: Int = 0
    var idTrangThai: Int = 0
    var tinhTrang: String = ""
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        tenKhachHang <- map["tenKhachHang"]
        tenCuaHang <- map["tenCuaHang"]
        soHopDong <- map["soHopDong"]
        ngayVay <- map["ngayVay"]
        hinhThucVay <- map["hinhThucVay"]
        soTien <- map["soTien"]
        daTra <- map["daTra"]
        laiDaThu <- map["laiDaThu"]
        idTrangThai <- map["idTrangThai"]
        tinhTrang <- map["tinhTrang"]
    }
}

class ChiTietVayNo: Mappable{
    
    var idHopDong: Int = 0
    var tenKhachHang: String = ""
    var tenCuaHang: String = ""
    var soHopDong: String = ""
    var ngayVay: String = ""
    var hinhThucVay: String = ""
    var soTien: Int = 0
    var gocDaThu: Int = 0
    var laiDaThu: Int = 0
    var idTrangThai: Int = 0
    var tinhTrang: String = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        idHopDong <- map["idHopDong"]
        tenKhachHang <- map["tenKhachHang"]
        tenCuaHang <- map["tenCuaHang"]
        soHopDong <- map["soHopDong"]
        ngayVay <- map["ngayVay"]
        hinhThucVay <- map["hinhThucVay"]
        soTien <- map["soTien"]
        gocDaThu <- map["gocDaThu"]
        laiDaThu <- map["laiDaThu"]
        idTrangThai <- map["idTrangThai"]
        tinhTrang <- map["tinhTrang"]
        
    }
    
    
}


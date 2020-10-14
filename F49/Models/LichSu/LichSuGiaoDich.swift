//
//  LichSuGiaoDich.swift
//  F49
//
//  Created by Le Dat on 10/5/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import ObjectMapper

class LichSuGiaoDich: Mappable{
    
    var id: Int = 0
    var idHopDong: Int = 0
    var idLoaiHopDong: Int = 0
    var ngayHieuLuc: String = ""
    var idLoaiGiaoDich: Int = 0
    var ngayGiaoDich: String = ""
    var noiDung: String = ""
    var nhanVien: String = ""
    var idNguoiDung: Int = 0
    var choVay: Int = 0
    var thuVe: Int = 0
    var thuLai: Int = 0
    var laiTraLai: Int = 0
    var phiPhat: Int = 0
    var phiKhac: Int = 0
    var noGoc: Int = 0
    var noLai: Int = 0
    var ghiChu: String = ""
    var soHopDong: String = ""
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        idHopDong <- map["idHopDong"]
        idLoaiHopDong <- map["idLoaiHopDong"]
        ngayHieuLuc <- map["ngayHieuLuc"]
        idLoaiGiaoDich <- map["idLoaiGiaoDich"]
        noiDung <- map["noiDung"]
        nhanVien <- map["nhanVien"]
        idNguoiDung <- map["idNguoiDung"]
        choVay <- map["choVay"]
        thuVe <- map["thuVe"]
        thuLai <- map["thuLai"]
        laiTraLai <- map["laiTraLai"]
        phiPhat <- map["phiPhat"]
        phiKhac <- map["phiKhac"]
        noGoc <- map["noGoc"]
        noLai <- map["noLai"]
        ghiChu <- map["ghiChu"]
        soHopDong <- map["soHopDong"]
        ngayGiaoDich <- map["ngayGiaoDich"]

    }

}


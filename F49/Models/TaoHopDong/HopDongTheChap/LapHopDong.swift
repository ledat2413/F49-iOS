//
//  LapHopDong.swift
//  F49
//
//  Created by Le Dat on 10/20/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import ObjectMapper


class SoHopDong: Mappable{
    
    var soHopDong: String = ""
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        soHopDong <- map["soHopDong"]
    }
}

class LapHopDong: Mappable{
    
    var thongTinHopDong: ThongTinHopDong?
    var dsTaiSanTheChap: [DSTaiSanTheChap] = []
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        thongTinHopDong <- map["ThongTinHopDong"]
        dsTaiSanTheChap <- map["DSTaiSanTheChap"]
    }
}

class DSTaiSanTheChap: Mappable{
    
    var tenVatCamCo: String = ""
    var idVatCamCo: Int = 0
    var hangSanXuat: String = ""
    var hinhAnh: [Images] = []
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        tenVatCamCo <- map["TenVatCamCo"]
        idVatCamCo <- map["IDVatCamCo"]
        hangSanXuat <- map["HangSanXuat"]
        hinhAnh <- map["HinhAnh"]

    }
    
    
}

class Images: Mappable{
    
    var name: String = ""
    var dataAsURL: String = ""
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        name <- map["Name"]
        dataAsURL <- map["DataAsURL"]
    }
}

class ThongTinHopDong: Mappable{
            
    var idCuaHang: Int = 0
    var idKhachHang: Int = 0
    var ngayVay: String = ""
    var ngayVaoSo: String = ""
    var soTienVay: Int = 0
    var laiXuat: Double = 0.0
    var soNgayVay: Int = 0
    var ngayCatLai: String = ""
    var catLaiTruoc: Bool = false
    var soTienCatLaiTruoc: Int = 0
    var soTienThuPhi: Int = 0
    var soTienKhachNhan: Int = 0
    var ghiChu: String = ""
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        idCuaHang <- map["IDCuaHang"]
        idKhachHang <- map["IDKhachHang"]
        ngayVay <- map["NgayVay"]
        ngayVaoSo <- map["NgayVaoSo"]
        soTienVay <- map["SoTienVay"]
        laiXuat <- map["LaiXuat"]
        soNgayVay <- map["SoNgayVay"]
        ngayCatLai <- map["NgayCatLai"]
        catLaiTruoc <- map["CatLaiTruoc"]
        soTienCatLaiTruoc <- map["SoTienCatLaiTruoc"]
        soTienThuPhi <- map["SoTienThuPhi"]
        soTienKhachNhan <- map["SoTienKhachNhan"]
        ghiChu <- map["GhiChu"]

    }
}

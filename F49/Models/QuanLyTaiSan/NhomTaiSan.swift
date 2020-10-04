//
//  NhomTaiSan.swift
//  F49
//
//  Created by Le Dat on 10/2/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import ObjectMapper

class NhomTaiSan: Mappable{
    
    var id: Int = 0
    var tenNhom: String = ""
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        tenNhom <- map["tenNhom"]
    }
}

class TenTaiSan: Mappable{
    
    var id: Int = 0
    var tenVatCamCo: String = ""
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        tenVatCamCo <- map["tenVatCamCo"]
    }
}

class TabTrangThaiTaiSan: Mappable{
    
    var id: Int = 0
    var tenTrangThai: String = ""
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        tenTrangThai <- map["tenTrangThai"]
    }
}

class DanhSachTaiSan: Mappable{
    
    var id: Int = 0
    var idHopDong: Int = 0
    var idVatCamCo: Int = 0
    var hangSanXuat: String = ""
    var dongSanPham: String = ""
    var bienSoXe: String = ""
    var soKhung: String = ""
    var soMay: String = ""
    var dungTich: String = ""
    var mauSac: String = ""
    var tinhTrang: String = ""
    var soChoNgoi: Int = 0
    var modelCode: String = ""
    var dinhGia: Int = 0
    var dangKy: String = ""
    var tenDangKy: String = ""
    var coChiaKhoa: Bool = false
    var ckxkcc: String = ""
    var cpu: String = ""
    var ram: String = ""
    var hdd: String = ""
    var vga: String = ""
    var manHinh: String = ""
    var matKhau: String = ""
    var imei: String = ""
    var moTa: String = ""
    var trangThai: Int = 0
    var tenTrangThai: String = ""
    var giaThanhLy: String = ""
    var ngayThanhLy: String = ""
    var idKhachHangVangLai: String = ""
    var ngayMuon: String = ""
    var ngayTra: String = ""
    var ngayLuuKho: String = ""
    var viTriTreoDo: String = ""
    var soTienDatLai: String = ""
    var tenVatCamCo: String = ""
    var soHopDong: String = ""
    var idLoaiHopDong: Int = 0
    var hoTen: String = ""
    var dienThoai: String = ""
    var diaChi: String = ""
    var soTienVay: Int = 0
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
        idHopDong <- map["idHopDong"]
        idVatCamCo <- map["idVatCamCo"]
        hangSanXuat <- map["hangSanXuat"]
        dongSanPham <- map["dongSanPham"]
        bienSoXe <- map["bienSoXe"]
        soKhung <- map[soKhung]
        soMay <- map["soMay"]
        dungTich <- map["dungTich"]
        mauSac <- map["mauSac"]
        tinhTrang <- map["tinhTrang"]
        soChoNgoi <- map["soChoNgoi"]
        modelCode <- map["modelCode"]
        dinhGia <- map["dinhGia"]
        dangKy <- map["dangKy"]
        tenDangKy <- map[tenDangKy]
        coChiaKhoa <- map["coChiaKhoa"]
        ckxkcc <- map["ckxkcc"]
        cpu <- map["cpu"]
        ram <- map["ram"]
        hdd <- map["hdd"]
        vga <- map["vga"]
        manHinh <- map["manHinh"]
        matKhau <- map["matKhau"]
        imei <- map["imei"]
        moTa <- map["moTa"]
        trangThai <- map["trangThai"]
        tenTrangThai <- map["tenTrangThai"]
        giaThanhLy <- map["giaThanhLy"]
        ngayThanhLy <- map["ngayThanhLy"]
        idKhachHangVangLai <- map["idKhachHangVangLai"]
        ngayMuon <- map["ngayMuon"]
        ngayTra <- map["ngayTra"]
        ngayLuuKho <- map["ngayLuuKho"]
        viTriTreoDo <- map["viTriTreoDo"]
        soTienDatLai <- map["soTienDatLai"]
        tenVatCamCo <- map["tenVatCamCo"]
        soHopDong <- map["soHopDong"]
        idLoaiHopDong <- map["idLoaiHopDong"]
        hoTen <- map["hoTen"]
        dienThoai <- map["dienThoai"]
        diaChi <- map["diaChi"]
        soTienVay <- map["soTienvay"]
        
    }
}

class TaiSanChiTiet: Mappable{
    
    var id: Int = 0
    var soHopDong: String = ""
    var tenVatCamCo: String = ""
    var moTa: String = ""
    var tenTrangThai: String = ""
    var ngayLuuKho: String = ""
    var ngayTra: String = ""
    var xkxkcc: String = ""
    var coChiaKhoa: Bool = false
    var matKhau: String = ""
    var viTriDeDo: String = ""
    var ngayThanhLy: String = ""
    var giaThanhLy: String = ""
    
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        soHopDong <- map["soHopDong"]
        tenVatCamCo <- map["tenVatCamCo"]
        moTa <- map["moTa"]
        tenTrangThai <- map["tenTrangThai"]
        ngayLuuKho <- map["ngayLuuKho"]
        ngayTra <- map["ngayTra"]
        xkxkcc <- map["xkxkcc"]
        coChiaKhoa <- map["coChiaKhoa"]
        matKhau <- map["matKhau"]
        viTriDeDo <- map["viTriDeDo"]
        ngayThanhLy <- map["ngayThanhLy"]
        giaThanhLy <- map["giaThanhLy"]

    }
    
    
}

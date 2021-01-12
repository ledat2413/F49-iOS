//
//  VonDauTuChiTiet.swift
//  F49
//
//  Created by Le Dat on 9/30/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import ObjectMapper

class VonDauTuChiTiet: Mappable{

    var id: Int = 0
    var idCuaHang: Int = 0
    var idLoaiGiaoDich: Int = 0
    var idNguoiDuyet: Int = 0
    var ngayCapNhat: String = ""
    var ngayGiaoDich: String = ""
    var soTien: Int = 0
    var ghiChu: String = ""
    var trangThai: Int = 0
    var tenTrangThai: String = ""
    var yKien: YKien?
    var tenCuaHang: String = ""
    var nguoiThucHien: String = ""
    var tenGiaoDich: String = ""
    var ngayTao: String = ""
    
    
    required  init?(map: Map) {
    }
    
    func mapping(map: Map) {
        idCuaHang <- map["idCuaHang"]
        tenCuaHang <- map["tenCuaHang"]
        idLoaiGiaoDich <- map["idLoaiGiaoDich"]
        ngayGiaoDich <- map["ngayGiaoDich"]
        soTien <- map["soTien"]
        ghiChu <- map["ghiChu"]
        tenGiaoDich <- map["tenGiaoDich"]
        tenTrangThai <- map["tenTrangThai"]
        nguoiThucHien <- map["nguoiThucHien"]
        ngayTao <- map["ngayTao"]
        yKien <- map["yKien"]
    }
}

class YKien: Mappable{
    
    var HoTen: String = ""
    var NoiDung: String = ""
    var ThoiGian: String = ""
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        HoTen <- map["HoTen"]
        NoiDung <- map["NoiDung"]
        ThoiGian <- map["ThoiGian"]
    }
    
    
}

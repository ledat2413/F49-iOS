//
//  VonDauTu.swift
//  F49
//
//  Created by Le Dat on 9/30/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import ObjectMapper


class VonDauTu: Mappable{
    
    @objc dynamic var idCuaHang: Int = 0
    @objc dynamic var tenCuaHang: String = ""
    @objc dynamic var idLoaiGiaoDich: Int = 0
    @objc dynamic var ngayGiaoDich: String = ""
    @objc dynamic var soTien: Int = 0
    @objc dynamic var ghiChu: String = ""
    @objc dynamic var hoTen: String = ""
    @objc dynamic var idItem: Int = 0
    @objc dynamic var tenGiaoDich: String = ""
    @objc dynamic var tenTrangThai: String = ""
    @objc dynamic var nguoiThucHien: String = ""
    @objc dynamic var ngayTao: String = ""
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        idCuaHang <- map["idCuaHang"]
        tenCuaHang <- map["tenCuaHang"]
        idLoaiGiaoDich <- map["idLoaiGiaoDich"]
        ngayGiaoDich <- map["ngayGiaoDich"]
        soTien <- map["soTien"]
        ghiChu <- map["ghiChu"]
        hoTen <- map["hoTen"]
        idItem <- map["idItem"]
        tenGiaoDich <- map["tenGiaoDich"]
        tenTrangThai <- map["tenTrangThai"]
        nguoiThucHien <- map["nguoiThucHien"]
        ngayTao <- map["ngayTao"]
        
    }
}

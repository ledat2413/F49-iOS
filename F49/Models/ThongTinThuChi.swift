//
//  ThongTinThuChi.swift
//  F49
//
//  Created by Le Dat on 9/25/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//



//"id": 10,
//"tenCuaHang": "CN3 Công Ty TNHH Đầu Tư - Kinh Doanh F49",
//"ngayThucHien": "11/01/2019",
//"soTien": "15.000",
//"thu": "0",
//"chi": "15.000",
//"nguoiThucHien": "Trần Chi Xuân",
//"lyDo": "Tiền nước uống",
//"ghiChu": "",
//"trangThai": null,
//"loaiGiaoDich": "Chi",
//"yKien": null

import Foundation
import ObjectMapper
import RealmSwift

class ThongTinThuChi: Object, Mappable{
    
    @objc dynamic var id: Int = 0
    @objc dynamic var tenCuaHang: String = ""
    @objc dynamic var ngayThucHien: String = ""
    @objc dynamic var soTien: String = ""
    
    @objc dynamic var thu: String = ""
    @objc dynamic var chi: String = ""
    @objc dynamic var lyDo: String = ""
    @objc dynamic var ghiChu: String = ""
    @objc dynamic var trangThai: String = ""
    @objc dynamic var loaiGiaoDich: String = ""
    @objc dynamic var nguoiThucHien: String = ""
//    @objc dynamic var yKien: String = ""

    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        tenCuaHang <- map["tenCuaHang"]
        ngayThucHien <- map["ngayThucHien"]
        soTien <- map["soTien"]
        lyDo <- map["lyDo"]
        trangThai <- map["trangThai"]
        loaiGiaoDich <- map["loaiGiaoDich"]
        thu <- map["thu"]
        chi <- map["chi"]
        nguoiThucHien <- map["nguoiThucHien"]
        ghiChu <- map["ghiChu"]
        
    }
}

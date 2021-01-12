//
//  ChiTietHopDong.swift
//  F49
//
//  Created by Le Dat on 9/24/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import ObjectMapper


class ChiTietHopDong: Mappable{
    
    var id: Int = 0
    var numberContract: String = ""
    var idKhachHang: Int = 0
    var fullName: String = ""
    var phoneNumber: String = ""
    var duNo: String = ""
    var expiredDate: String = ""
    var plusMin: Int = 0
    var interest: String = ""
    var fee: String = ""
    var total: String = ""
    var appointmentDate: String = ""
    var content: String = ""
    var doDeLai: String = ""
    var catLai: Bool = false
    var ngayNhacNho: String = ""
    var countLichSuGiaoDich: Int = 0
    var countLichSuVay: Int = 0
    var hinhAnh: [HinhAnh] = []
    
    
    required  init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        idKhachHang <- map["idKhachHang"]
        numberContract <- map["numberContract"]
        fullName <- map["fullName"]
        phoneNumber <- map["phoneNumber"]
        duNo <- map["duNo"]
        expiredDate <- map["expiredDate"]
        plusMin <- map["plusMin"]
        interest <- map["interest"]
        fee <- map["fee"]
        total <- map["total"]
        appointmentDate <- map["appointmentDate"]
        content <- map["content"]
        doDeLai <- map["doDeLai"]
        catLai <- map["catLai"]
        ngayNhacNho <- map["ngayNhacNho"]
        countLichSuGiaoDich <- map["countLichSuGiaoDich"]
        countLichSuVay <- map["countLichSuVay"]
        hinhAnh <- map["hinhAnh"]
        
    }
}

class HinhAnh: Mappable{
    var url: String = ""
    var name: String = ""
    var extensions: String = ""
    
    required  init?(map: Map) {
    }
    
    func mapping(map: Map) {
        url <- map["url"]
        name <- map["name"]
        extensions <- map["extension"]
    }
    
    
}

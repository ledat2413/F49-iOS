//
//  BaoCao.swift
//  F49
//
//  Created by Le Dat on 10/6/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import ObjectMapper

class BaoCaoTongHop: Mappable{
    
    var tienMatDauKy: String = ""
    var duNoDauKy: String = ""
    var thanhLyDauKy: String = ""
    var tienMatCuoiKy: String = ""
    var duNoCuoiKy: String = ""
    var thanhLyCuoiKy: String = ""
    var dauTuRutVon: String = ""
    var vonVayNgoai: String = ""
    var vonChoVay: String = ""
    var vonThuVeTuHD: String = ""
    var laiThuDuoc: String = ""
    var tangGiamThanhLy: String = ""
    var canDoiThuChi: String = ""
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        tienMatDauKy <- map["tienMatDauKy"]
        duNoDauKy <- map["duNoDauKy"]
        thanhLyDauKy <- map["thanhLyDauKy"]
        tienMatCuoiKy <- map["tienMatCuoiKy"]
        duNoCuoiKy <- map["duNoCuoiKy"]
        thanhLyCuoiKy <- map["thanhLyCuoiKy"]
        dauTuRutVon <- map["dauTuRutVon"]
        vonVayNgoai <- map["vonVayNgoai"]
        vonChoVay <- map["vonChoVay"]
        vonThuVeTuHD <- map["vonThuVeTuHD"]
        laiThuDuoc <- map["laiThuDuoc"]
        tangGiamThanhLy <- map["tangGiamThanhLy"]
        canDoiThuChi <- map["canDoiThuChi"]

    }
    
    
}

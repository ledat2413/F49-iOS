//
//  methods.swift
//  F49
//
//  Created by Le Dat on 11/13/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import Alamofire

extension APIRouter {
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .Login:
            return .post
            
        case .PutFirebase:
            return .put
            
        case .PutDuyetRutVon:
            return .put
        case .PutThucHienThuLai:
            return .put
        case .UploadImage:
            return .post
        case .LoadTaoMoiHDTC:
            return .post
        case .TinhSoTienKhachNhan:
            return .post
        case .LuuHopDongTheChap:
            return .post
        case .LoadTaoMoiHDGD:
            return .post
        case .TinhTienLai:
            return .post
        case .TinhTienPhi:
            return .post
        case .LuuHopDongTraGop:
            return .post
        case .PutReadAllNotification:
            return .put
        case .PutStatusNotify:
            return .put
        case .DeleteNotification:
            return .delete
        case .LoadTaoMoiGDTG:
            return .post
        case .TinhSoTienKhachNhanGDTG:
            return .post
        case .TinhTienPhiHDTG:
            return .post
        case .TinhTienLaiHDTG:
            return .post
        case .LuuHopDongHDTG:
            return .post
        case .KhachHangLuu:
            return .post
        default:
            return .get
            
        }
    }

}

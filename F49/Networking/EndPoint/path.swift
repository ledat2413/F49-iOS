//
//  path.swift
//  F49
//
//  Created by Le Dat on 11/13/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import Alamofire

extension APIRouter {
    // MARK: - Path
    var path: String {
        switch self {
        
        //Login
        case .Login:
            return "token"
            
        //UserProfile
        case .GetUserProfile:
            return "api/UserProfile"
            
        //DashBoard
        case .GetCuaHang:
            return "api/Dashboard/GetCuaHang"
        case .GetDashBoard:
            return "api/Dashboard/GetDashboard"
            
        //TienIch
        case .GetTienIch:
            return "api/TienIch/GetTienIch"
            
        //TopMenu
        case .GetStatus:
            return "api/TopMenu/GetTrangThai"
        case .GetTopMenu:
            return "api/TopMenu"
        case .GetListCamDo:
            return "api/TopMenu/GetListCamDo"
        case .GetChiTietCamDo:
            return "api/TopMenu/GetChiTietCamDo"
        case .GetListDinhGia:
            return "api/TopMenu/GetListDinhGia"
        case .GetChiTietDinhGia:
            return "api/TopMenu/GetChiTietDinhGia"
        case .GetListDoGiaDung:
            return "api/TopMenu/GetListDoGiaDung"
        case .GetChiTietDoGiaDung:
            return "api/TopMenu/GetChiTietDoGiaDung"
            
        //HopDong
        case .GetTab:
            return "api/HopDong/GetTab"
        case .GetListHopDongTheoLoai:
            return "api/HopDong/GetListHopDongTheoLoai"
        case .GetTrangThaiHopDong:
            return "api/HopDong/GetTrangThaiHD"
        case .GetChiTietHopDong:
            return "api/HopDong/GetChiTietHopDong"
        case .UploadImage:
            return "api/HopDong/UploadImage"
            
        //ThuChi
        case .GetListThuChi:
            return "api/ThuChi/GetListThuChi"
        case .GetDetailThuChiByID:
            return "api/ThuChi/GetDetailThuChiByID"
            
        //Notification
        case .GetCountNotify:
            return "api/Notification/GetCountNotify"
        case .GetListNotification:
            return "api/Notification/GetListNotification"
        case .PutReadAllNotification:
            return "api/Notification/PutReadAll"
        case .PutStatusNotify:
            return "api/Notification/PutStatusNotify"
        case .DeleteNotification:
            return "api/Notification/DeleteNotify"
            
        //RutLai
        case .GetTabTrangThai:
            return "api/RutLai/GetTabTrangThai"
        case .GetListRutLai:
            return "api/RutLai/GetListRutLai"
            
            
        //QuanLyVon
        case .GetListVonDauTu:
            return "api/QuanLyVonDauTu/GetListVonDauTu"
        case .GetDetailVonDauTu:
            return "api/QuanLyVonDauTu/GetDetailVonDauTu"
            
        //RutVon
        case .GetListRutVon:
            return "api/RutVon/GetListRutVon"
        case .GetDetailRutVonByID:
            return "api/RutVon/GetDetailRutVonByID"
        case .PutDuyetRutVon:
            return "api/RutVon/PutDuyetRutVon"
            
        //QuanLyTaiSan
        case .GetDLNhomTaiSan:
            return "api/QuanLyTaiSan/GetDLNhomTS"
        case .GetDLTenTaiSan:
            return "api/QuanLyTaiSan/GetDLTenTaiSan"
        case .GetTabTrangThaiTaiSan:
            return "api/QuanLyTaiSan/GetTabTrangThaiTaiSan"
        case .GetDLTaiSan:
            return "api/QuanLyTaiSan/GetDSTaiSan"
        case .GetDetailTaiSan:
            return "api/QuanLyTaiSan/GetDetailTaiSan"
            
        //LichSu
        case .GetLichSuGiaoDich:
            return "api/LichSu/GetLichSuGiaoDich"
        case .GetCountLichSuGiaoDich:
            return "api/LichSu/GetCountLichSuGiaoDich"
        case .GetChiTietLichSuGiaoDich:
            return "api/LichSu/GetChiTietLichSuGiaoDich"
        case .GetLichSuVayNo:
            return "api/LichSu/GetLichSuVayNo"
        case .GetCountLichSuVayNo:
            return "api/LichSu/GetCountLichSuVayNo"
        case .GetChiTietLichSuVayNo:
            return "api/LichSu/GetChiTietLichSuVayNo"
            
        //BaoCao
        case .GetBaoCaoTongHop:
            return "api/BaoCao/GetBaoCaoTongHop"
            
        //TienHoaHong
        case .GetTienHoaHong:
            return "api/TienHoaHong/GetTienHoaHong"
        case .GetDanhSachNhanVien:
            return "api/TienHoaHong/GetDanhSachNhanVien"
            
        //ThuLai
        case .GetChiTietHopDongThuLai:
            return "api/ThuLai/GetChiTietHopDongThuLai"
        case .GetLoaiGiaoDich:
            return "api/ThuLai/GetLoaiGiaoDich"
        case .PutThucHienThuLai:
            return "api/ThuLai/PutThucHienThuLai"
            
        //HopDongTheChap
        case .DanhSachTaiSanHDTC:
            return "api/HopDongTheChap/LayDanhSachTaiSan"
        case .ThuocTinhTaiSanHDTC:
            return "api/HopDongTheChap/LayThuocTinhTaiSan"
        case .LoadTaoMoiHDTC:
            return "api/HopDongTheChap/LoadTaoMoi"
        case .TinhSoTienKhachNhan:
            return "api/HopDongTheChap/TinhSoTienKhachNhan"
        case .LuuHopDongTheChap:
            return "api/HopDongTheChap/LuuHopDong"
            
        //KhachHang
        case .TimKiemKhachHang:
            return "api/KhachHang/TimKiem"
            
        //Hop Dong Gia Dich
        case .DanhSachTaiSanHDGD:
            return "api/HopDongGDTG/LayDanhSachTaiSan"
        case .LoadTaoMoiHDGD:
            return "api/HopDongGDTG/LoadTaoMoi"
        case .TinhTienLai:
            return "api/HopDongGDTG/TinhTienLai"
        case .TinhTienPhi:
            return "api/HopDongGDTG/TinhTienPhi"
        case .LuuHopDongTraGop:
            return "api/HopDongTraGop/LuuHopDong"
            
        //Hop Dong Gia Dich Tra Gop
        case .LoadTaoMoiGDTG:
            return "api/HopDongGDTG/LoadTaoMoi"
        case .TinhSoTienKhachNhanGDTG:
            return "api/HopDongGDTG/TinhSoTienKhachNhan"
        case .TinhTienLaiHDTG:
            return "api/HopDongGDTG/TinhTienLai"
        case .TinhTienPhiHDTG:
            return "api/HopDongGDTG/TinhTienPhi"
        case .LuuHopDongHDTG:
            return "api/HopDongGDTG/LuuHopDong"
        }
    }

}

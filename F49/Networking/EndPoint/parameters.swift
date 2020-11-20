//
//  parameters.swift
//  F49
//
//  Created by Le Dat on 11/13/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import Alamofire

extension APIRouter {
    // MARK: - Parameters
    public var parameters: RequestParams {
        switch self {
        
        //Login
        case .Login(let grant_type, let username, let password):
            return .body(["grant_type": grant_type,
                          "username": username,
                          "password": password])
            
        //User Profile
        case .GetUserProfile:
            return .body([:])
            
        case .TimKiemKhachHang(let key):
            return .body(["key": key])
        case .GetCuaHang:
            return .body([:])
            
        //DashBoard
        case .GetDashBoard(let id):
            return .body(["idCuaHang": id])
        case .GetTienIch(let id):
            return .body(["idCuaHang": id])
            
        //Top Menu
        case .GetTopMenu:
            return .body([:])
        case .GetStatus:
            return .body([:])
        case .GetListCamDo(let trangThai):
            return .body(["trangThai": trangThai])
        case .GetListDinhGia(let trangThai):
            return .body(["trangThai": trangThai])
        case .GetListDoGiaDung(let trangThai):
            return .body(["trangThai": trangThai])
        case .GetChiTietCamDo(let id):
            return .body(["id": id])
        case .GetChiTietDinhGia(let id):
            return .body(["id": id])
        case .GetChiTietDoGiaDung(let id):
            return .body(["id": id])
            
        //Hop Dong
        case .GetTab:
            return .body([:])
        case .GetListHopDongTheoLoai(let params):
            return .body(params)
        case .GetTrangThaiHopDong:
            return .body([:])
        case .GetChiTietHopDong(let id):
            return .body(["idHopDong": id])
        case .GetListThuChi(let params):
            return .body(params)
        case .GetDetailThuChiByID(let id):
            return .body(["idItem": id])
        case .UploadImage(let imgStr, let soHopDong):
            return .body(["imgStr" : imgStr, "soHopDong" : soHopDong])
            
        //Notification
        case .GetCountNotify(let idCuaHang):
            return .body(["idCuaHang": idCuaHang])
        case .GetListNotification(let params):
            return .body(params)
        case .PutReadAllNotification(let idCuaHang):
            return .body(["idCuaHang": idCuaHang])
        case .PutStatusNotify(let idNotify):
            return .body(["idNotify" : idNotify])
        case .DeleteNotification(let id):
            return .body(["id": id])
            
        //RutLai
        case .GetTabTrangThai:
            return .body([:])
        case .GetListRutLai(let idShop, let idTab):
            return .body(["idCuaHang": idShop , "idTab": idTab])
            
        //TienHoaHong
        case .GetDanhSachNhanVien:
            return .body([:])
        case .GetTienHoaHong(let params):
            return .body(params)
            
            
        //QuanLyVonDauTu
        case .GetListVonDauTu(let params):
            return .body(params)
        case .GetDetailVonDauTu(let id):
            return .body(["id" : id])
            
        //RutVon
        case .GetListRutVon(let idShop, let idTab):
            return .body(["idCuaHang": idShop , "idTab": idTab])
        case .GetDetailRutVonByID(let id):
            return .body(["idItem": id])
        case .PutDuyetRutVon(let params):
            return .body(params)
            
        //QuanLyTaiSan
        case .GetDLNhomTaiSan:
            return .body([:])
        case .GetDLTenTaiSan(let id):
            return .body(["idNhom" : id])
        case .GetTabTrangThaiTaiSan:
            return .body([:])
        case .GetDLTaiSan(let idNhomVatCamDo, let idVatCamDo, let trangThai):
            return .body(["idNhomVatCamDo": idNhomVatCamDo, "idVatCamDo" : idVatCamDo, "trangThai" : trangThai])
        case .GetDetailTaiSan(let id):
            return .body(["idItem" : id])
            
        //LichSu
        case .GetLichSuGiaoDich(let id):
            return .body(["idHopDong" : id])
        case .GetCountLichSuGiaoDich(let id):
            return .body(["idHopDong" : id])
        case .GetChiTietLichSuGiaoDich(let idGiaoDich, let idHopDong):
            return .body(["idGiaoDich": idGiaoDich, "idHopDong": idHopDong])
        case .GetLichSuVayNo(let id):
            return .body(["idHopDong" : id])
        case .GetChiTietLichSuVayNo(let idHopDong):
            return .body(["idHopDong" : idHopDong])
        case .GetCountLichSuVayNo(let id):
            return .body(["idHopDong" : id])
            
        //BaoCaoTongHop
        case .GetBaoCaoTongHop(let params):
            return .body(params)
            
        //ThuLai
        case .GetChiTietHopDongThuLai(let idHopDong, let ngayHieuLuc):
            return .body(["idHopDong": idHopDong, "ngayHieuLuc": ngayHieuLuc])
        case .GetLoaiGiaoDich:
            return .body([:])
        case .PutThucHienThuLai(let idHopDong,let loaiGiaoDich,let idCuaHangFormApp,let tienThucTe,let ngayHieuLuc):
            return .body(["idHopDong" : idHopDong, "loaiGiaoDich": loaiGiaoDich , "idCuaHangFormApp": idCuaHangFormApp, "tienThuThucTe": tienThucTe, "ngayHieuLuc": ngayHieuLuc])
            
        //HopDongTheChap
        case .DanhSachTaiSanHDTC:
            return .body([:])
        case .ThuocTinhTaiSanHDTC(let loaiTaiSan):
            return .body(["loaiTaiSan": loaiTaiSan])
        case .LoadTaoMoiHDTC(let idCuaHang):
            return .body(["IDCuaHang": idCuaHang])
        case .TinhSoTienKhachNhan(let params):
            return .body(params)
        case .LuuHopDongTheChap(let params):
            return .body(params)
            
        //HopDongGiaDung
        case .DanhSachTaiSanHDGD:
            return .body([:])
        case .LoadTaoMoiHDGD(let idCuaHang):
            return .body(["idCuaHang" : idCuaHang])
        case .TinhTienLai(let params):
            return .body(params)
        case .TinhTienPhi(let params):
            return .body(params)
        case .LuuHopDongTraGop(let params):
            return .body(params)
            
        //HopDongGiaDungTraGop
        case .LoadTaoMoiGDTG(let idCuaHang):
            return .body(["idCuaHang": idCuaHang])
        case .TinhSoTienKhachNhanGDTG(let params):
            return .body(params)
        case .TinhTienLaiHDTG( let params):
            return .body(params)
        case .TinhTienPhiHDTG( let params):
            return .body(params)
        case .LuuHopDongHDTG( let params):
            return .body(params)
        }
    }
}

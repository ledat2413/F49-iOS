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
    public var parameters: Parameters? {
        switch self {
        
        //Login
        case .Login(let grant_type, let username, let password):
            return [Constants.APIParameterKey.grant_type: grant_type,
                    Constants.APIParameterKey.username: username,
                    Constants.APIParameterKey.password: password]
            
        //User Profile
        case .GetUserProfile:
            return [:]
            
        case .TimKiemKhachHang(let key):
            return [Constants.APIParameterKey.key: key]
        case .GetCuaHang:
            return [:]
            
        //DashBoard
        case .GetDashBoard(let id):
            return [Constants.APIParameterKey.idCuaHang : id]
        case .GetTienIch(let id):
            return [Constants.APIParameterKey.idCuaHang : id]

        //Top Menu
        case .GetTopMenu:
            return [:]
        case .GetStatus:
            return [:]
        case .GetListCamDo(let trangThai):
            return [Constants.APIParameterKey.trangThai: trangThai]
        case .GetListDinhGia(let trangThai):
            return [Constants.APIParameterKey.trangThai: trangThai]
        case .GetListDoGiaDung(let trangThai):
            return [Constants.APIParameterKey.trangThai: trangThai]
        case .GetChiTietCamDo(let id):
            return [Constants.APIParameterKey.id: id]
        case .GetChiTietDinhGia(let id):
            return [Constants.APIParameterKey.id: id]
        case .GetChiTietDoGiaDung(let id):
            return [Constants.APIParameterKey.id: id]

        //Hop Dong
        case .GetTab:
            return [:]
        case .GetListHopDongTheoLoai(let params):
            return params
        case .GetTrangThaiHopDong:
            return [:]
        case .GetChiTietHopDong(let id):
            return [Constants.APIParameterKey.idHopDong: id]
        case .GetListThuChi(let params):
            return params
        case .GetDetailThuChiByID(let id):
            return [Constants.APIParameterKey.idItem: id]
        case .UploadImage(let imgStr, let soHopDong):
            return [Constants.APIParameterKey.imgStr : imgStr,
                    Constants.APIParameterKey.soHopDong : soHopDong]
            
        //Notification
        case .GetCountNotify(let idCuaHang):
            return [Constants.APIParameterKey.idCuaHang: idCuaHang]
        case .GetListNotification(let params):
            return params
        case .PutReadAllNotification(let idCuaHang):
            return [Constants.APIParameterKey.idCuaHang: idCuaHang]
        case .PutStatusNotify(let idNotify):
            return [Constants.APIParameterKey.idNotify : idNotify]
        case .DeleteNotification(let id):
            return [Constants.APIParameterKey.id : id]

        //RutLai
        case .GetTabTrangThai:
            return [:]
        case .GetListRutLai(let idShop, let idTab):
            return [Constants.APIParameterKey.idCuaHang: idShop,
                    Constants.APIParameterKey.idTab: idTab]

        //TienHoaHong
        case .GetDanhSachNhanVien:
            return [:]
        case .GetTienHoaHong(let params):
            return params

            
        //QuanLyVonDauTu
        case .GetListVonDauTu(let params):
            return params
        case .GetDetailVonDauTu(let id):
            return [Constants.APIParameterKey.id : id]
            
        //RutVon
        case .GetListRutVon(let idShop, let idTab):
            return [Constants.APIParameterKey.idCuaHang: idShop,
                    Constants.APIParameterKey.idTab: idTab]
        case .GetDetailRutVonByID(let id):
            return [Constants.APIParameterKey.idItem: id]
        case .PutDuyetRutVon(let params):
            return params

        //QuanLyTaiSan
        case .GetDLNhomTaiSan:
            return [:]
        case .GetDLTenTaiSan(let id):
            return [Constants.APIParameterKey.idNhom : id]
        case .GetTabTrangThaiTaiSan:
            return [:]
        case .GetDLTaiSan(let idNhomVatCamDo, let idVatCamDo, let trangThai):
            return [Constants.APIParameterKey.idNhomVatCamDo: idNhomVatCamDo,
                    Constants.APIParameterKey.idVatCamDo: idVatCamDo,
                    Constants.APIParameterKey.trangThai : trangThai]
        case .GetDetailTaiSan(let id):
            return [Constants.APIParameterKey.idItem : id]
            
        //LichSu
        case .GetLichSuGiaoDich(let id):
            return [Constants.APIParameterKey.idHopDong: id]
        case .GetCountLichSuGiaoDich(let id):
            return [Constants.APIParameterKey.idHopDong: id]
        case .GetChiTietLichSuGiaoDich(let idGiaoDich, let idHopDong):
            return [Constants.APIParameterKey.idGiaoDich: idGiaoDich, Constants.APIParameterKey.idHopDong: idHopDong]
        case .GetLichSuVayNo(let id):
            return [Constants.APIParameterKey.idKhachHang: id]
        case .GetChiTietLichSuVayNo(let idHopDong):
            return [Constants.APIParameterKey.idHopDong: idHopDong]
        case .GetCountLichSuVayNo(let id):
            return [Constants.APIParameterKey.idHopDong: id]

        //BaoCaoTongHop
        case .GetBaoCaoTongHop(let params):
            return params

        //ThuLai
        case .GetChiTietHopDongThuLai(let idHopDong, let ngayHieuLuc):
            return [Constants.APIParameterKey.idHopDong: idHopDong,
                    Constants.APIParameterKey.ngayHieuLuc: ngayHieuLuc]
        case .GetLoaiGiaoDich:
            return [:]
        case .PutThucHienThuLai(let idHopDong,let loaiGiaoDich,let idCuaHangFormApp,let tienThucTe,let ngayHieuLuc):
            return [Constants.APIParameterKey.idHopDong: idHopDong,
                Constants.APIParameterKey.loaiGiaoDich: loaiGiaoDich,
                Constants.APIParameterKey.idCuaHangFormApp: idCuaHangFormApp,
                Constants.APIParameterKey.tienThuThucTe: tienThucTe,
                Constants.APIParameterKey.ngayHieuLuc: ngayHieuLuc]
            
        //HopDongTheChap
        case .DanhSachTaiSanHDTC:
            return [:]
        case .ThuocTinhTaiSanHDTC(let loaiTaiSan):
            return [Constants.APIParameterKey.loaiTaiSan: loaiTaiSan]
        case .LoadTaoMoiHDTC(let idCuaHang):
            return [Constants.APIParameterKey.IDCuaHang: idCuaHang]
        case .TinhSoTienKhachNhan(let params):
            return params
        case .LuuHopDongTheChap(let params):
            return params

        //HopDongGiaDung
        case .DanhSachTaiSanHDGD:
            return [:]
        case .LoadTaoMoiHDGD(let idCuaHang):
            return [Constants.APIParameterKey.idCuaHang : idCuaHang]
        case .TinhTienLai(let params):
            return params
        case .TinhTienPhi(let params):
            return params
        case .LuuHopDongTraGop(let params):
            return params

        //HopDongGiaDungTraGop
        case .LoadTaoMoiGDTG(let idCuaHang):
            return [Constants.APIParameterKey.idCuaHang : idCuaHang]
        case .TinhSoTienKhachNhanGDTG(let params):
            return params
        case .TinhTienLaiHDTG( let params):
            return params
        case .TinhTienPhiHDTG( let params):
            return params
        case .LuuHopDongHDTG( let params):
            return params
        }
    }
}

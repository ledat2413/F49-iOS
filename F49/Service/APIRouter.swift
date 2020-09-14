//
//  APIRouter.swift
//  F49
//
//  Created by Le Dat on 9/8/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    // =========== Begin define api ===========
    case Login(grant_type: String, username: String, password: String)
    case GetUserProfile
    case GetCuaHang
    case GetDashBoard(id: Int)
    // =========== End define api ===========
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .Login:
            return .post
        case .GetUserProfile:
            return .get
        case .GetCuaHang:
            return .get
        case .GetDashBoard:
            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .Login:
            return "token"
        case .GetUserProfile:
            return "api/UserProfile"
        case .GetCuaHang:
            return "api/Dashboard/GetCuaHang"
        case .GetDashBoard:
            return "api/Dashboard/GetDashboard"
        }
    }
    
    // MARK: - Headers
    private var headers: HTTPHeaders {
        var headers = ["Accept": "application/json"]
        switch self {
        case .Login:
            break
        case .GetUserProfile:
            if let token = UserToken.getAccessToken() {
                headers["Authorization"] = token
            }
            break
        case .GetCuaHang:
            if let token = UserToken.getAccessToken() {
                headers["Authorization"] = token
            }
            break
            
        case .GetDashBoard:
            if let token = UserToken.getAccessToken() {
                headers["Authorization"] = token
            }
        }
        
        return headers;
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .Login(let grant_type, let username, let password):
            return ["grant_type": grant_type,
                    "username": username,
                    "password": password]
        case .GetUserProfile:
            return [:]
        case .GetCuaHang:
            return [:]
        case .GetDashBoard(let id):
            return ["idCuaHang": id]
        }
    }
    
    // MARK: - URL request
    func asURLRequest() throws -> URLRequest {
        let url = try Production.BASE_URL.asURL()
        
        // setting path
        var urlRequest: URLRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // setting method
        urlRequest.httpMethod = method.rawValue
        
        // setting header
        for (key, value) in headers {
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }
        
        if let parameters = parameters {
            do {
                urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
            } catch {
                print("Encoding fail")
            }
        }
        return urlRequest
    }
    
}


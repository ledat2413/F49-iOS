//
//  Config.swift
//  F49
//
//  Created by Le Dat on 9/8/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation

struct Production{
    static let BASE_URL: String = "http://apif49.itpsolution.net/"
}

enum NetworkErrorType {
    case API_ERROR
    case HTTP_ERROR
}

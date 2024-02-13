//
//  LoginModel.swift
//  beilsang
//
//  Created by Seyoung on 2/10/24.
//

import Foundation

struct LoginResponse: Codable {
    let isSuccess : Bool?
    let status : String
    let message : String
    let data : LoginData?
}

struct LoginData : Codable {
    let accessToken : String?
    let refreshToken : String?
    let existMember : Bool?
}


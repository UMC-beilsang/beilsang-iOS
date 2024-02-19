//
//  LoginModel.swift
//  beilsang
//
//  Created by Seyoung on 2/10/24.
//

import Foundation

struct LoginResponse: Codable {
    let code : String
    let message : String
    let data : LoginData
    let success : Bool
}

struct LoginData : Codable {
    let accessToken : String
    let refreshToken : String
    let existMember : Bool
}

struct WithDrawResponse: Codable {
    let code : String
    let message : String
    let data : Empty
    let success : Bool
}

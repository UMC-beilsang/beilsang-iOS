//
//  TokenModel.swift
//  beilsang
//
//  Created by Seyoung on 2/17/24.
//

import Foundation

struct TokenResponse: Codable {
    let code : String
    let message : String
    let data : TokenData?
    let success : Bool
}

struct TokenData : Codable {
    let accessToken : String
    let refreshToken : String
}

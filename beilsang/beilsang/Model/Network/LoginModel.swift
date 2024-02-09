//
//  LoginModel.swift
//  beilsang
//
//  Created by Seyoung on 2/10/24.
//

import Foundation

struct LoginKakaoResponse: Codable {
    let isSuccess : Bool?
    let status : String
    let message : String
    let data : LoginKakaoData?
}

struct LoginKakaoData : Codable {
    let accessToken : String
    let existMember : Bool?
}
    


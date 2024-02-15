//
//  SignUpModel.swift
//  beilsang
//
//  Created by Seyoung on 2/11/24.
//

import Foundation

class SignUpData {
    static let shared = SignUpData() // Singleton 객체 생성
    
    var gender: String = ""
    var nickName: String = ""
    var birth: String = ""
    var address: String? = ""
    var keyword: String = ""
    var discoveredPath: String? = ""
    var resolution: String = ""
    var recommendNickname: String? = ""
}

// 서버로부터 받은 데이터를 파싱하는 구조체
struct SignUpResponse: Codable {
    let code : String
    let message: String
    let data: Empty?
    let success : Bool
}

struct RefreshResponse : Codable {
    let code : String
    let message: String
    let data : RefreshData
    let success : Bool
}

struct nameCheckResponse: Codable {
    let code : String
    let message: String
    let data: Empty?
    let success : Bool
}

struct Empty: Codable { }




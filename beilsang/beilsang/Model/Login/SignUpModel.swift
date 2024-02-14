//
//  SignUpModel.swift
//  beilsang
//
//  Created by Seyoung on 2/11/24.
//

import Foundation

class SignUpData {
    static let shared = SignUpData() // Singleton 객체 생성
    
    var gender: Gender = .MALE
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
    let isSuccess: Bool
    let status: String
    let message: String
    let data: Empty?
}

struct nameCheckResponse: Codable {
    let isSuccess: Bool
    let status: String
    let message: String
    let data: Bool
}

struct Empty: Codable { }




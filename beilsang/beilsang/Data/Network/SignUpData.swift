//
//  SignUpData.swift
//  beilsang
//
//  Created by Seyoung on 2/10/24.
//

import Foundation

class SignUpData {
    static let shared = SignUpData() // Singleton 객체 생성
    
    var gender: String = "M"
    var nickName: String = ""
    var birth: String = ""
    var address: String? = ""
    var keyword: String = ""
    var discoveredPath: String? = ""
    var resolution: String? = ""
    var recommendNickname: String? = ""
}



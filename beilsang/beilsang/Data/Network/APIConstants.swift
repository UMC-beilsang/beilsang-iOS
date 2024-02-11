//
//  APIConstants.swift
//  beilsang
//
//  Created by Seyoung on 2/10/24.
//

import Foundation

struct APIConstants {
    //MARK: - Base URL
    static let baseURL = "https://beilsang.com"
    
    //MARK: - Feature
    //로그인
    static func loginURL(for provider: LoginProvider) -> String {
           switch provider {
           case .APPLE:
               return baseURL + "/auth/APPLE/login"
           case .KAKAO:
               return baseURL + "/auth/KAKAO/login"
           }
       }
    
    //토큰 재발급
    static let refreshTokenURL = baseURL + "/auth/token/refresh"
    
    //자체 회원가입
    static let signUpURL = baseURL + "auth/singup"
    
}

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
    // 카카오 로그인
    static let loginKakaoURL = baseURL + "/auth/kakao/login"
    
    // 애플 로그인
    static let loginAppleURL = baseURL + "/auth/apple/login"
     
    //토큰 재발급
    static let refreshTokenURL = baseURL + "/auth/token/refresh"
    
    //자체 회원가입
    static let signUpURL = baseURL + "/auth/signup"
    
    //닉네임 중복 체크
    static let duplicateCheck = baseURL + "/api/join/check/nickname"
    
    //MARK: - Feature: Search
    static let searchURL = baseURL + "/api/search"
    
    //회원탈퇴
    static let withDrawURL = baseURL + "/auth/kakao/revoke"
}

//
//  NetworkResult.swift
//  beilsang
//
//  Created by Seyoung on 2/10/24.
//

enum NetworkResult<T>{
    case success(T) //통신 성공
    case requestErr(T) //요청 에러
    case pathErr //경로 에러
    case serverErr //서버 내부 에러
    case networkFail //네트워크 오류
}

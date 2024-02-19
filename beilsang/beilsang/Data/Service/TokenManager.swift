//
//  TokenManager.swift
//  beilsang
//
//  Created by Seyoung on 2/17/24.
//
import Foundation

class TokenManager {
    
    static let shared = TokenManager()
  
    func refreshToken(refreshToken: String, completion: @escaping (NetworkResult<Any>) -> Void, callback: (() -> Void)? = nil) {
        TokenService.shared.refreshToken(refreshToken: refreshToken) { result in
            switch result {
            case .success(let data):
                guard let data = data as? TokenResponse else { return }
                print("access Token refresh Success with data : \(data)")
                
                UserDefaults.standard.set(data.data?.accessToken, forKey: UserDefaultsKey.serverToken)
                UserDefaults.standard.set(data.data?.refreshToken, forKey: UserDefaultsKey.refreshToken)
                
                completion(.success(data))
                callback?()
                
            case .networkFail:
                print("네트워크 페일")
                completion(.networkFail)
            case .tokenExpired :
                print("토큰 재발급 오류")
                completion(.tokenExpired)
            case .requestErr(let error):
                print("요청 페일 \(error)")
                completion(.requestErr(error))
            case .pathErr:
                print("경로 오류")
                completion(.pathErr)
            case .serverErr:
                print("서버 오류")
                completion(.serverErr)
            }
        }
    }
}

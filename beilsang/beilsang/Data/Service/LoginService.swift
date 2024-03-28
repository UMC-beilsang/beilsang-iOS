//
//  LoginService.swift
//  beilsang
//
//  Created by Seyoung on 2/10/24.
//

import Foundation
import Alamofire

class LoginService {
    
    static let shared = LoginService()
    
    private init() {}
    
    func kakaoLogin(accesstoken: String, deviceToken: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        let url = APIConstants.loginKakaoURL
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "accept": "*/*"
        ]
        let body: Parameters = ["accesstoken": accesstoken, "deviceToken" : deviceToken]
        
        let dataRequest = AF.request(url,
                                     method: .post,
                                     parameters: body,
                                     encoding: JSONEncoding.default,
                                     headers: headers)
        
        dataRequest.responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let value = response.value else { return }
                
                print("서버에서 받은 데이터: \(String(data: value, encoding: .utf8) ?? "")")
                
                let networkResult = self.judgeStatus(by: statusCode, value)
                completion(networkResult)
                
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    func appleLogin(idToken: String, deviceToken : String, completion: @escaping (NetworkResult<Any>) -> Void) {
        let url = APIConstants.loginAppleURL
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "accept": "*/*"
        ]
        let body: Parameters = ["idToken": idToken, "devicetToken": deviceToken]
        
        let dataRequest = AF.request(url,
                                     method: .post,
                                     parameters: body,
                                     encoding: JSONEncoding.default,
                                     headers: headers)
        
        dataRequest.responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let value = response.value else { return }
                
                let networkResult = self.judgeStatus(by: statusCode, value)
                completion(networkResult)
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode {
        case ..<300 : return isVaildData(data: data)
        case 400..<500 : return .pathErr
        case 500..<600 : return .serverErr
        default : return .networkFail
        }
    }
    
    //통신이 성공하고 원하는 데이터가 올바르게 들어왔을때 처리하는 함수
    private func isVaildData(data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder() //서버에서 준 데이터를 Codable을 채택
        guard let decodedData = try? decoder.decode(LoginResponse.self, from: data)
                
        else { return .networkFail }
        
        return .success(decodedData as Any)
    }
}

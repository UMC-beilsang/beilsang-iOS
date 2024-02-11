//
//  LoginService.swift
//  beilsang
//
//  Created by Seyoung on 2/10/24.
//

import Foundation
import Alamofire
//(1) 라이브러리 추가

class LoginService {
    
    static let shared = LoginService()
//(2)싱글통 객체를 선언해서 앱 어디에서든지 접근가능하도록 한다
    private init() {}
    
    func kakaoLogin(accessToken: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        let url = APIConstants.loginURL(for: .KAKAO)
        let header: HTTPHeaders = ["Content-Type": "application/json"]
        let body: Parameters = ["accesstoken": accessToken]
        
        let dataRequest = AF.request(url,
                                     method: .post,
                                     parameters: body,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        
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
    
    func appleLogin(accessToken: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        let url = APIConstants.loginURL(for: .APPLE)
        let header: HTTPHeaders = ["Content-Type": "application/json"]
        let body: Parameters = ["accesstoken": accessToken]
        
        let dataRequest = AF.request(url,
                                     method: .post,
                                     parameters: body,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        
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
        //데이터가 변환이 되게끔 Response 모델 구조체로 데이터를 변환해서 넣고, 그 데이터를 NetworkResult Success 파라미터로 전달
        else { return .networkFail }
        
        return .success(decodedData as Any)
    }
}

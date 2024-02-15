//
//  SignUpService.swift
//  beilsang
//
//  Created by Seyoung on 2/11/24.
//

import Foundation
import Alamofire

class SignUpService {
    
    static let shared = SignUpService()
    
    private init() {}
        
    func signUp(accessToken: String, gender : String, nickName : String, birth : String, address : String?, keyword : String, discoveredPath : String?, resolution : String, recommendNickname : String?, completion: @escaping (NetworkResult<Any>) -> Void) {
        let url = APIConstants.signUpURL
        let headers: HTTPHeaders = [
            "accept": "*/*",
            "Content-Type": "application/json"
        ]
        let body: Parameters = ["accessToken" : accessToken,
                                "gender": gender,
                                "nickName": nickName,
                                "birth" : birth,
                                "address" : address ?? "",
                                "keyword" : keyword,
                                "discoveredPath" : discoveredPath ?? "",
                                "resolution" : resolution,
                                "recommendNickname" : recommendNickname ?? ""]
        
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
                print("요청 성공")
                
                let networkResult = self.judgeStatus(by: statusCode, value)
                completion(networkResult)
                
            case .failure:
                completion(.pathErr)
            }
        }
    }

    func nameCheck() {
        
    }
    
    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode {
        case ..<300 : return isVaildData(data: data)
        case 400..<500 :return .pathErr
        case 500..<600 : return .serverErr
        default : return .networkFail
        }
    }
    
    //통신이 성공하고 원하는 데이터가 올바르게 들어왔을때 처리하는 함수
    private func isVaildData(data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder() //서버에서 준 데이터를 Codable을 채택
        
        guard let decodedData = try? decoder.decode(SignUpResponse.self, from: data)
                //데이터가 변환이 되게끔 Response 모델 구조체로 데이터를 변환해서 넣고, 그 데이터를 NetworkResult Success 파라미터로 전달
        else { return .networkFail }
        
        return .success(decodedData as Any)
    }
}

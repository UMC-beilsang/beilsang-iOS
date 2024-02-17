//
//  FindService.swift
//  beilsang
//
//  Created by 강희진 on 2/12/24.
//

import Foundation
import Alamofire

class FindService {
    
    static let shared = FindService()
    private init() {}
    
    var jwtToken = ""
    
    // MARK: - get
    func getRecommendChallenge(baseEndPoint:BaseEndpoint, addPath:String?,  completionHandler: @escaping (_ data: GetRecommendChallenge) -> Void) {
        DispatchQueue.main.async {
            let headers: HTTPHeaders = [
                "accept": "application/json",
                "Authorization": "Bearer \(self.jwtToken)"
            ]
            
            guard let addPath = addPath else { return }
            let url = baseEndPoint.requestURL + addPath
            print(url)
            
            AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).validate().responseDecodable(of: GetRecommendChallenge.self, completionHandler:{ response in
                switch response.result{
                case .success:
                    guard let result = response.value else {return}
                    completionHandler(result)
                    print("get 요청 성공")
                    
                    // 호출 실패 시 처리 위함
                case .failure(let error):
                    print(error)
                    print("get 요청 실패")
                }
            })
        }
    }
}

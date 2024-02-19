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
    // MARK: - get
    func getRecommendChallenge(baseEndPoint:BaseEndpoint, addPath:String?,  completionHandler: @escaping (_ data: GetRecommendChallenge) -> Void) {
        let accessToken = UserDefaults.standard.string(forKey: UserDefaultsKey.serverToken)!
        let refreshToken = UserDefaults.standard.string(forKey: UserDefaultsKey.refreshToken)!
        
        DispatchQueue.main.async {
            let headers: HTTPHeaders = [
                "Accept": "application/json",
                "Authorization": "Bearer \(accessToken)"
            ]
            
            guard let addPath = addPath else { return }
            let url = baseEndPoint.requestURL + addPath
            print(url)
            
            AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).validate().responseDecodable(of: GetRecommendChallenge.self, completionHandler:{ response in
                debugPrint(response)
                switch response.result{
                case .success:
                    guard let statusCode = response.response?.statusCode else { return }
                    switch statusCode{
                    case ..<300 :
                        guard let result = response.value else {return}
                        completionHandler(result)
                        print("get 요청 성공")
                    case 401 :
                        print("토큰 만료")
                        TokenManager.shared.refreshToken(accessToken: accessToken, refreshToken: refreshToken, completion: { _ in }) {
                            self.getRecommendChallenge(baseEndPoint: baseEndPoint, addPath: addPath) { reResponse in
                                completionHandler(reResponse)
                            }
                        }
                    default : print("네트워크 fail")
                }
                    // 호출 실패 시 처리 위함
                case .failure(let error):
                    print(error)
                    print("get 요청 실패")
                }
            })
        }
    }
}

//
//  SearchService.swift
//  beilsang
//
//  Created by Seyoung on 2/18/24.
//

import Foundation
import Alamofire

class SearchService {
    
    static let shared = SearchService()
    private init() {}
    
    func SearchResult(name : String?, completionHandler: @escaping (_ data: SearchResponse) -> Void) {
        let accessToken = UserDefaults.standard.string(forKey: UserDefaultsKey.serverToken)!
        let refreshToken = UserDefaults.standard.string(forKey: UserDefaultsKey.refreshToken)!
        
        DispatchQueue.main.async {
            let addPath = "?name=\(name ?? "")"
            let url = APIConstants.searchURL + addPath
            let headers: HTTPHeaders = [
                "accept": "application/json",
                "Authorization": "Bearer \(accessToken)"
            ]
            
            AF.request(url, method: .get, encoding: URLEncoding.queryString, headers: headers).validate().responseDecodable(of: SearchResponse.self, completionHandler:{ response in
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
                            self.SearchResult(name: SearchGlobalData.shared.searchText) { reResponse in
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

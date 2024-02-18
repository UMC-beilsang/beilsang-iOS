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
    
    var jwtToken = ""
    
    func SearchResult(name : String?, completionHandler: @escaping (_ data: SearchResponse) -> Void) {
        DispatchQueue.main.async {
            let addPath = "?name=\(name ?? "")"
            let url = APIConstants.searchURL + addPath
            let headers: HTTPHeaders = [
                "accept": "application/json",
                "Authorization": "Bearer \(self.jwtToken ?? "")"
            ]
            
            AF.request(url, method: .get, encoding: URLEncoding.queryString, headers: headers).validate().responseDecodable(of: SearchResponse.self, completionHandler:{ response in
                switch response.result{
                case .success:
                    guard let result = response.value else {return}
                    completionHandler(result)
                    print("get 요청 성공")
                case .failure(let error):
                    print(error)
                    print("get 요청 실패")
                }
            })
        }
    }
}


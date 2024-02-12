//
//  MyPageService.swift
//  beilsang
//
//  Created by 강희진 on 2/9/24.
//

import Foundation
import Alamofire


class MyPageService {
    
    static let shared = MyPageService()
    private init() {}
    
    var jwtToken = ""
    
    
    // MARK: - get
    func getMyPage(baseEndPoint:BaseEndpoint, addPath:String?,  completionHandler: @escaping (_ data: GetMyPage) -> Void) {
        DispatchQueue.main.async {
            let headers: HTTPHeaders = [
                "accept": "application/json",
                "Authorization": "Bearer \(self.jwtToken)"
            ]
            
            guard let addPath = addPath else { return }
            let url = baseEndPoint.requestURL + addPath
            
            AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).validate().responseDecodable(of: GetMyPage.self, completionHandler:{ response in
                switch response.result{
                case .success:
                    guard let result = response.value else {return}
                    completionHandler(result)
                    // 호출 실패 시 처리 위함
                case .failure(let error):
                    print(error)
                    print("get 요청 실패")
                }
            })
        }
    }
    func getPoint(baseEndPoint:BaseEndpoint, addPath:String?,  completionHandler: @escaping (_ data: GetPoint) -> Void) {
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer \(jwtToken)"
        ]
        
        guard let addPath = addPath else { return }
        let url = baseEndPoint.requestURL + addPath
        print(url)
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).validate().responseDecodable(of: GetPoint.self, completionHandler:{ response in
            switch response.result{
            case .success:
                debugPrint(response)
                guard let result = response.value else {return}
                completionHandler(result)
                // 호출 실패 시 처리 위함
            case .failure(let error):
                print(error)
                print("get 요청 실패")
            }
        })
    }
    
    
    // MARK: - post
    // AccountInfoView
    func postAccountInfo(baseEndPoint:BaseEndpoint, addPath:String?, parameter: Dictionary<String, Any>, completionHandler: @escaping (_ data: PostAccountInfo) -> Void) {
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer \(jwtToken)",
            "Content-Type": "application/json"
        ]
        
        guard let addPath = addPath else { return }
        let url = baseEndPoint.requestURL + addPath
        print(url)
        
        AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: headers).validate().responseDecodable(of: PostAccountInfo.self, completionHandler:{ response in
            switch response.result{
            case .success:
                guard let result = response.value else {return}
                completionHandler(result)
                // 호출 실패 시 처리 위함
            case .failure(let error):
                print(error)
                print("post 요청 실패")
            }
        })
    }
    
    // 피드 찜 버튼 누르기
    func postLikeButton(baseEndPoint:BaseEndpoint, addPath:String?, completionHandler: @escaping (_ data: BaseModel) -> Void) {
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer \(jwtToken)",
            "Content-Type": "application/json"
        ]
        
        guard let addPath = addPath else { return }
        let url = baseEndPoint.requestURL + addPath
        print(url)
        
        AF.request(url, method: .post, encoding: JSONEncoding.default, headers: headers).validate().responseDecodable(of: BaseModel.self, completionHandler:{ response in
            switch response.result{
            case .success:
                guard let result = response.value else {return}
                completionHandler(result)
                print("post 요청 성공")
                // 호출 실패 시 처리 위함
            case .failure(let error):
                print(error)
                print("post 요청 실패")
            }
        })
    }
}

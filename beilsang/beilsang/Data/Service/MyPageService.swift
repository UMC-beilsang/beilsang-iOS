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
    // 마이페이지 뷰 get
    func getMyPage(baseEndPoint:BaseEndpoint, addPath:String?,  completionHandler: @escaping (_ data: GetMyPage) -> Void) {
        DispatchQueue.main.async {
            let headers: HTTPHeaders = [
                "accept": "application/json",
                "Authorization": "Bearer \(self.jwtToken)"
            ]
            
            guard let addPath = addPath else { return }
            let url = baseEndPoint.requestURL + addPath
            print(url)
            
            AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).validate().responseDecodable(of: GetMyPage.self, completionHandler:{ response in
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
    // 포인트 뷰 get
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
                guard let result = response.value else {return}
                completionHandler(result)
                // 호출 실패 시 처리 위함
            case .failure(let error):
                print(error)
                print("get 요청 실패")
            }
        })
    }
    // 마이 챌린지 피드의 피드 리스트 get
    func getFeedList(baseEndPoint:BaseEndpoint, addPath:String?,  completionHandler: @escaping (_ data: GetFeedModel) -> Void) {
        DispatchQueue.main.async {
            let headers: HTTPHeaders = [
                "accept": "application/json",
                "Authorization": "Bearer \(self.jwtToken)"
            ]
            
            guard let addPath = addPath else { return }
            let url = baseEndPoint.requestURL + addPath
            print(url)
            AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).validate().responseDecodable(of: GetFeedModel.self, completionHandler:{ response in
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
    // 찜 챌린지, 카테고리별 챌린지 리스트(발견)
    func getChallengeList(baseEndPoint:BaseEndpoint, addPath:String?,  completionHandler: @escaping (_ data: GetChallenge) -> Void) {
        DispatchQueue.main.async {
            let headers: HTTPHeaders = [
                "accept": "application/json",
                "Authorization": "Bearer \(self.jwtToken)"
            ]
            
            guard let addPath = addPath else { return }
            let url = baseEndPoint.requestURL + addPath
            print(url)
            
            AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).validate().responseDecodable(of: GetChallenge.self, completionHandler:{ response in
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
    // 카테고리 별 챌린지 리스트
    func getMyPageChallengeList(baseEndPoint:BaseEndpoint, addPath:String?,  completionHandler: @escaping (_ data: GetMyPageChallenge) -> Void) {
        DispatchQueue.main.async {
            let headers: HTTPHeaders = [
                "accept": "application/json",
                "Authorization": "Bearer \(self.jwtToken)"
            ]
            
            guard let addPath = addPath else { return }
            let url = baseEndPoint.requestURL + addPath
            print(url)
            
            AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).validate().responseDecodable(of: GetMyPageChallenge.self, completionHandler:{ response in
                debugPrint(response)
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
    // 닉네임 중복 체크
    func getDuplicateCheck(baseEndPoint:BaseEndpoint, addPath:String?,  completionHandler: @escaping (_ data: GetDuplicateCheck) -> Void) {
        DispatchQueue.main.async {
            let headers: HTTPHeaders = [
                "accept": "application/json",
                "Authorization": "Bearer \(self.jwtToken)"
            ]
            
            guard let addPath = addPath else { return }
            let url = baseEndPoint.requestURL + addPath
            print(url)
            AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).validate().responseDecodable(of: GetDuplicateCheck.self, completionHandler:{ response in
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
    // 피드 상세 정보 보기
    func getMyPageFeedDetail(baseEndPoint:BaseEndpoint, addPath:String?,  completionHandler: @escaping (_ data: GetMyPageFeedDetail) -> Void) {
        DispatchQueue.main.async {
            let headers: HTTPHeaders = [
                "accept": "application/json",
                "Authorization": "Bearer \(self.jwtToken)"
            ]
            
            guard let addPath = addPath else { return }
            let url = baseEndPoint.requestURL + addPath
            print(url)
            AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).validate().responseDecodable(of: GetMyPageFeedDetail.self, completionHandler:{ response in
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
    
    // MARK: - post
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
    
    // MARK: - patch
    // AccountInfoView
    func patchAccountInfo(baseEndPoint:BaseEndpoint, addPath:String?, parameter: Dictionary<String, Any>, completionHandler: @escaping (_ data: PatchAccountInfo) -> Void) {
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer \(jwtToken)",
            "Content-Type": "application/json"
        ]
        
        guard let addPath = addPath else { return }
        let url = baseEndPoint.requestURL + addPath
        print(url)
        
        AF.request(url, method: .patch, parameters: parameter, encoding: JSONEncoding.default, headers: headers).validate().responseDecodable(of: PatchAccountInfo.self, completionHandler:{ response in
            switch response.result{
            case .success:
                guard let result = response.value else {return}
                completionHandler(result)
                print("patch 요청 성공")
                // 호출 실패 시 처리 위함
            case .failure(let error):
                print(error)
                print("patch 요청 실패")
            }
        })
    }
    // MARK: - delete
    // 피드 찜 버튼 누르기
    func deleteLikeButton(baseEndPoint:BaseEndpoint, addPath:String?, completionHandler: @escaping (_ data: BaseModel) -> Void) {
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer \(jwtToken)",
            "Content-Type": "application/json"
        ]
        
        guard let addPath = addPath else { return }
        let url = baseEndPoint.requestURL + addPath
        print(url)
        
        AF.request(url, method: .delete, encoding: JSONEncoding.default, headers: headers).validate().responseDecodable(of: BaseModel.self, completionHandler:{ response in
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

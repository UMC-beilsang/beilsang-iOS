//
//  ChallengeRecommendManager.swift
//  beilsang
//
//  Created by 곽은채 on 2/12/24.
//

// 챌린지 관련 api 연결 함수
import Alamofire
import Foundation

class ChallengeService {
    static let shared = ChallengeService()
    
    private init() {}
    
    let accessToken = UserDefaults.standard.string(forKey: UserDefaultsKey.accessToken) ?? ""
    
    // 홈 메인화면 추천 챌린지
    func challengeRecommend(completionHandler : @escaping (_ data: ChallengeRecommends) -> Void) {
        DispatchQueue.main.async {
            let url = "https://beilsang.com/api/challenges/recommends"
            
            // HTTP Headers : 요청 헤더
            let header : HTTPHeaders = [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(self.accessToken)"
            ]
            
            AF.request(url, method: .get, encoding: URLEncoding.queryString, headers: header).validate().responseDecodable(of: ChallengeRecommends.self, completionHandler: { response in
                switch response.result {
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
    
    // 챌린지 참여 중인지 여부
    func challengeEnrolled(challengId: Int, completionHandler : @escaping (_ data: ChallengeEnrolled) -> Void) {
        DispatchQueue.main.async {
            let url = "https://beilsang.com/api/check/\(challengId)"
            
            // HTTP Headers : 요청 헤더
            let header : HTTPHeaders = [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(self.accessToken)"
            ]
            
            AF.request(url, method: .get, encoding: URLEncoding.queryString, headers: header).validate().responseDecodable(of: ChallengeEnrolled.self, completionHandler: { response in
                switch response.result {
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
    
    // 챌린지 리스트 화면
    func challengeCategories(categoryName: String, completionHandler : @escaping (_ data: ChallengeCategory) -> Void) {
        DispatchQueue.main.async {
            let url = "https://beilsang.com/api/challenges/categories/\(categoryName)"
            
            // HTTP Headers : 요청 헤더
            let header : HTTPHeaders = [
                "Content-Type": "application/json"
            ]
            
            AF.request(url, method: .get, encoding: URLEncoding.queryString, headers: header).validate().responseDecodable(of: ChallengeCategory.self, completionHandler: { response in
                switch response.result {
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
    
    // 챌린지 리스트 화면 - 전체(api 다른 거 써서 따로)
    func challengeCategoriesAll(completionHandler : @escaping (_ data: ChallengeCategory) -> Void) {
        DispatchQueue.main.async {
            let url = "https://beilsang.com/api/challenges"
            
            // HTTP Headers : 요청 헤더
            let header : HTTPHeaders = [
                "Content-Type": "application/json"
            ]
            
            AF.request(url, method: .get, encoding: URLEncoding.queryString, headers: header).validate().responseDecodable(of: ChallengeCategory.self, completionHandler: { response in
                switch response.result {
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
    
    // 챌린지 리스트 화면 - 참여중
    func challengeCategoriesEnrolled(completionHandler : @escaping (_ data: ChallengeStatus) -> Void) {
        DispatchQueue.main.async {
            let url = "https://beilsang.com/api/challenges/참여중/ALL"
            
            // HTTP Headers : 요청 헤더
            let header : HTTPHeaders = [
                "Content-Type": "application/json"
            ]
            
            AF.request(url, method: .get, encoding: URLEncoding.queryString, headers: header).validate().responseDecodable(of: ChallengeStatus.self, completionHandler: { response in
                switch response.result {
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
    
    // 챌린지 등록화면
    func challengePost(completionHandler : @escaping (_ data: ChallengePost) -> Void) {
        DispatchQueue.main.async {
            let url = "https://beilsang.com/api/challenges"
            
            // HTTP Headers : 요청 헤더
            let header : HTTPHeaders = [
                "accept": "*/*",
                "Content-Type": "multipart/form-data",
                "Authorization": "Bearer \(self.accessToken)"
            ]
            
            let parameters: [String: Any] = [
                "mainImage": ChallengeDataSingleton.shared.mainImage ?? "",
                "title": ChallengeDataSingleton.shared.title ?? "",
                // "category": ChallengeDataSingleton.shared.category ?? "",
                "category": "TUMBLER",
                //"startDate": (ChallengeDataSingleton.shared.startDate) ?? "",
                "startDate": 2024-04-13,
                // "period": ChallengeDataSingleton.shared.period ?? "",
                "period": "WEEK",
                "totalGoalDay": ChallengeDataSingleton.shared.totalGoalDay ?? "",
                "details": ChallengeDataSingleton.shared.details ?? "",
                "notes": ChallengeDataSingleton.shared.notes,
                "certImage": ChallengeDataSingleton.shared.certImage ?? "",
                "joinPoint": ChallengeDataSingleton.shared.joinPoint ?? ""
            ]
            
            AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: header).validate().responseDecodable(of: ChallengePost.self, completionHandler: { response in
                switch response.result {
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
    
    // 챌린지 세부 화면
    func challengeDetail(challengId: Int, completionHandler : @escaping (_ data: ChallengeDetail) -> Void) {
        DispatchQueue.main.async {
            let url = "https://beilsang.com/api/challenges/\(challengId)"
            
            // HTTP Headers : 요청 헤더
            let header : HTTPHeaders = [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(self.accessToken)"
            ]
            
            AF.request(url, method: .get, encoding: URLEncoding.queryString, headers: header).validate().responseDecodable(of: ChallengeDetail.self, completionHandler: { response in
                switch response.result {
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
    
    // 챌린지 인증 가이드(유의사항)
    func challengeGuide(challengId: Int?, completionHandler : @escaping (_ data: ChallengeGuide) -> Void) {
        DispatchQueue.main.async {
            let url = "https://beilsang.com/api/feeds/guide/\(challengId ?? 0)"
            
            // HTTP Headers : 요청 헤더
            let header : HTTPHeaders = [
                "Content-Type": "application/json"
            ]
            
            AF.request(url, method: .get, encoding: URLEncoding.queryString, headers: header).validate().responseDecodable(of: ChallengeGuide.self, completionHandler: { response in
                switch response.result {
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
    
    // 챌린지 인증하기(등록)
    func reviewPost(challengId: Int?, completionHandler : @escaping (_ data: ChallengeCertify) -> Void) {
        let url = "https://beilsang.com/api/feeds/\(challengId ?? 0)"
        
        // HTTP Headers : 요청 헤더
        let header : HTTPHeaders = [
            "accept": "application/json",
            "Content-Type": "multipart/form-data"
        ]
        
        var parameters: [String: Any] = [
            "review": ChallengeCertifySingleton.shared.review ?? ""
        ]
        if let imageData = ChallengeCertifySingleton.shared.image {
            parameters["feedImage"] = imageData
        }
        
        AF.upload(multipartFormData: { multipartFormData in
            
            for (key, value) in parameters {
                if let string = value as? String {
                    if let stringData = string.data(using: .utf8) {
                        multipartFormData.append(stringData, withName: key)
                    }
                } else if let data = value as? Data {
                    multipartFormData.append(data, withName: key, fileName: "image.jpg", mimeType: "image/jpeg")
                }
            }
        }, to: url, method: .post, headers: header)
        .validate()
        .responseDecodable(of: ChallengeCertify.self) { response in
            debugPrint(response)
            switch response.result {
            case .success:
                guard let result = response.value else { return }
                completionHandler(result)
                print("리뷰 post 요청 성공")
            case .failure(let error):
                print(error)
                print("리뷰 post 요청 실패")
            }
        }
    }
}

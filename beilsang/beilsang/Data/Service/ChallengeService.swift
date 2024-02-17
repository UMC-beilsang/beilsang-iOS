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
    
    // 챌린지 등록화면
    func challengePost(completionHandler : @escaping (_ data: ChallengePost) -> Void) {
        DispatchQueue.main.async {
            let url = "https://beilsang.com/api/challenges"
            
            // HTTP Headers : 요청 헤더
            let header : HTTPHeaders = [
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
        DispatchQueue.main.async {
            let url = "https://beilsang.com/api/feeds/\(challengId ?? 0)"
            
            // HTTP Headers : 요청 헤더
            let header : HTTPHeaders = [
                "Content-Type": "multipart/form-data"
            ]
            
            let parameters: [String: Any] = [
                "imageUrl" : (ChallengeCertifySingleton.shared.image)?.base64EncodedString() ?? "",
                "review" : ChallengeCertifySingleton.shared.review ?? ""
            ]
            
            AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: header).validate().responseDecodable(of: ChallengeCertify.self, completionHandler: { response in
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
}

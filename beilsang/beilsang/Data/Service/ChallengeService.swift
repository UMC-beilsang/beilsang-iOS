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
    
    // 홈 메인화면 추천 챌린지
    func challengeRecommend(completionHandler : @escaping (_ data: ChallengeRecommends) -> Void) {
        let accessToken = UserDefaults.standard.string(forKey: UserDefaultsKey.serverToken)!
        let refreshToken = UserDefaults.standard.string(forKey: UserDefaultsKey.refreshToken)!
        
        DispatchQueue.main.async {
            let url = "https://beilsang.com/api/challenges/recommends"
            
            // HTTP Headers : 요청 헤더
            let header : HTTPHeaders = [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(accessToken)"
            ]
            
            AF.request(url, method: .get, encoding: URLEncoding.queryString, headers: header).validate().responseDecodable(of: ChallengeRecommends.self, completionHandler: { response in
                switch response.result{
                case .success:
                    guard let statusCode = response.response?.statusCode else { return }
                    switch statusCode{
                    case ..<300 :
                        guard let result = response.value else {return}
                        completionHandler(result)
                        print("추천 챌린지 get 요청 성공")
                    default : print("네트워크 fail")
                    }
                    // 호출 실패 시 처리 위함
                case .failure(let error):
                    guard let statusCode = response.response?.statusCode else { return }
                    switch statusCode{
                    case 401 :
                        print("토큰 만료")
                        TokenManager.shared.refreshToken(refreshToken: refreshToken, completion: { _ in }) {
                            self.challengeRecommend { reResponse in
                                completionHandler(reResponse)
                            }
                        }
                    default : print("네트워크 fail")
                    }
                    
                    print(error)
                    print("추천 챌린지 리스트 get 요청 실패")
                }
            })
        }
    }
    
    // 챌린지 참여 중인지 여부
    func challengeEnrolled(EnrollChallengeId: Int, completionHandler : @escaping (_ data: ChallengeEnrolled) -> Void) {
        let accessToken = UserDefaults.standard.string(forKey: UserDefaultsKey.serverToken)!
        let refreshToken = UserDefaults.standard.string(forKey: UserDefaultsKey.refreshToken)!
        let enrollChallengeId = EnrollChallengeId
        
        DispatchQueue.main.async {
            let url = "https://beilsang.com/api/check/\(EnrollChallengeId)"
            
            // HTTP Headers : 요청 헤더
            let header : HTTPHeaders = [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(accessToken)"
            ]
            
            AF.request(url, method: .get, encoding: URLEncoding.queryString, headers: header).validate().responseDecodable(of: ChallengeEnrolled.self, completionHandler: { response in
                switch response.result{
                case .success:
                    guard let statusCode = response.response?.statusCode else { return }
                    switch statusCode{
                    case ..<300 :
                        guard let result = response.value else {return}
                        completionHandler(result)
                        print("참여중 여부 get 요청 성공")
                    default : print("네트워크 fail")
                    }
                    // 호출 실패 시 처리 위함
                case .failure(let error):
                    guard let statusCode = response.response?.statusCode else { return }
                    switch statusCode{
                    case 401 :
                        print("토큰 만료")
                        TokenManager.shared.refreshToken(refreshToken: refreshToken, completion: { _ in }) {
                            self.challengeEnrolled(EnrollChallengeId: enrollChallengeId) { reResponse in
                                completionHandler(reResponse)
                            }
                        }
                    default : print("네트워크 fail")
                    }
                    print(error)
                    print("참여중 여부 get 요청 실패")
                }
            })
        }
    }
    
    // 챌린지 리스트 화면
    func challengeCategories(categoryName: String, completionHandler : @escaping (_ data: ChallengeCategory) -> Void) {
        let accessToken = UserDefaults.standard.string(forKey: UserDefaultsKey.serverToken)!
        let refreshToken = UserDefaults.standard.string(forKey: UserDefaultsKey.refreshToken)!
        let categoryName = categoryName
        
        DispatchQueue.main.async {
            let url = "https://beilsang.com/api/challenges/categories/\(categoryName)"
            
            // HTTP Headers : 요청 헤더
            let header : HTTPHeaders = [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(accessToken)"
            ]
            
            AF.request(url, method: .get, encoding: URLEncoding.queryString, headers: header).validate().responseDecodable(of: ChallengeCategory.self, completionHandler: { response in
                switch response.result{
                case .success:
                    guard let statusCode = response.response?.statusCode else { return }
                    switch statusCode{
                    case ..<300 :
                        guard let result = response.value else {return}
                        completionHandler(result)
                        print("챌린지 리스트 카테고리 get 요청 성공")
                    default : print("네트워크 fail")
                    }
                    // 호출 실패 시 처리 위함
                case .failure(let error):
                    guard let statusCode = response.response?.statusCode else { return }
                    switch statusCode{
                    case 401 :
                        print("토큰 만료")
                        TokenManager.shared.refreshToken(refreshToken: refreshToken, completion: { _ in }) {
                            self.challengeCategories(categoryName: categoryName) { reResponse in
                                completionHandler(reResponse)
                            }
                        }
                    default : print("네트워크 fail")
                    }
                    print(error)
                    print("챌린지 리스트 카테고리 get 요청 실패")
                }
            })
        }
    }
    
    // 챌린지 리스트 화면 - 전체(api 다른 거 써서 따로)
    func challengeCategoriesAll(completionHandler : @escaping (_ data: ChallengeCategory) -> Void) {
        let accessToken = UserDefaults.standard.string(forKey: UserDefaultsKey.serverToken)!
        let refreshToken = UserDefaults.standard.string(forKey: UserDefaultsKey.refreshToken)!
        DispatchQueue.main.async {
            let url = "https://beilsang.com/api/challenges"
            
            // HTTP Headers : 요청 헤더
            let header : HTTPHeaders = [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(accessToken)"
            ]
            
            AF.request(url, method: .get, encoding: URLEncoding.queryString, headers: header).validate().responseDecodable(of: ChallengeCategory.self, completionHandler: { response in
                switch response.result{
                case .success:
                    guard let statusCode = response.response?.statusCode else { return }
                    switch statusCode{
                    case ..<300 :
                        guard let result = response.value else {return}
                        completionHandler(result)
                        print("챌린지 리스트 전체 get 요청 성공")
                    default : print("네트워크 fail")
                    }
                    // 호출 실패 시 처리 위함
                case .failure(let error):
                    guard let statusCode = response.response?.statusCode else { return }
                    switch statusCode{
                    case 401 :
                        print("토큰 만료")
                        TokenManager.shared.refreshToken(refreshToken: refreshToken, completion: { _ in }) {
                            self.challengeCategoriesAll { reResponse in
                                completionHandler(reResponse)
                            }
                        }
                    default : print("네트워크 fail")
                    }
                    print(error)
                    print("챌린지 리스트 전체 get 요청 실패")
                }
            })
        }
    }
    
    // 챌린지 리스트 화면 - 참여중
    func challengeCategoriesEnrolled(completionHandler : @escaping (_ data: ChallengeStatus) -> Void) {
        let accessToken = UserDefaults.standard.string(forKey: UserDefaultsKey.serverToken)!
        let refreshToken = UserDefaults.standard.string(forKey: UserDefaultsKey.refreshToken)!
        
        DispatchQueue.main.async {
            let url = "https://beilsang.com/api/challenges/참여중/ALL"
            
            // HTTP Headers : 요청 헤더
            let header : HTTPHeaders = [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(accessToken)"
            ]
            
            AF.request(url, method: .get, encoding: URLEncoding.queryString, headers: header).validate().responseDecodable(of: ChallengeStatus.self, completionHandler: { response in
                switch response.result{
                case .success:
                    guard let statusCode = response.response?.statusCode else { return }
                    switch statusCode{
                    case ..<300 :
                        guard let result = response.value else {return}
                        completionHandler(result)
                        print("참여중 챌린지 리스트 get 요청 성공")
                    default : print("네트워크 fail")
                    }
                    // 호출 실패 시 처리 위함
                case .failure(let error):
                    guard let statusCode = response.response?.statusCode else { return }
                    switch statusCode{
                    case 401 :
                        print("토큰 만료")
                        TokenManager.shared.refreshToken(refreshToken: refreshToken, completion: { _ in }) {
                            self.challengeCategoriesEnrolled { reResponse in
                                completionHandler(reResponse)
                            }
                        }
                    default : print("네트워크 fail")
                    }
                    
                    print(error)
                    print("참여중 챌린지 리스트 get 요청 실패")
                }
            })
        }
    }
    
    // 챌린지 등록화면
    func challengePost(completionHandler : @escaping (_ data: ChallengePost) -> Void) {
        let accessToken = UserDefaults.standard.string(forKey: UserDefaultsKey.serverToken)!
        let refreshToken = UserDefaults.standard.string(forKey: UserDefaultsKey.refreshToken)!
        
        let url = "https://beilsang.com/api/challenges"
        
        // HTTP Headers : 요청 헤더
        let header : HTTPHeaders = [
            "accept": "*/*",
            "Content-Type": "multipart/form-data",
            "Authorization": "Bearer \(accessToken)"
        ]
        
        var parameters: [String: Any] = [
            "title": ChallengeDataSingleton.shared.title ?? "",
            "category": ChallengeDataSingleton.shared.category ?? "",
            "startDate": (ChallengeDataSingleton.shared.startDate) ?? "",
            "period": ChallengeDataSingleton.shared.period ?? "",
            "totalGoalDay": ChallengeDataSingleton.shared.totalGoalDay ?? "",
            "details": ChallengeDataSingleton.shared.details ?? "",
            "notes": ChallengeDataSingleton.shared.notes,
            "joinPoint": ChallengeDataSingleton.shared.joinPoint ?? ""
        ]
        if let mainImageData = ChallengeDataSingleton.shared.mainImage {
            parameters["mainImage"] = mainImageData
        }
        if let certImageData = ChallengeDataSingleton.shared.certImage {
            parameters["certImage"] = certImageData
        }
        
        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters {
                if let string = value as? String {
                    if let stringData = string.data(using: .utf8) {
                        multipartFormData.append(stringData, withName: key)
                    }
                } else if let stringArray = value as? [String] {
                    for (index, string) in stringArray.enumerated() {
                        if let stringData = string.data(using: .utf8) {
                            multipartFormData.append(stringData, withName: "\(key)[\(index)]")
                        }
                    }
                } else if let number = value as? Int {
                    let numberData = "\(number)".data(using: .utf8)!
                    multipartFormData.append(numberData, withName: key)
                } else if let data = value as? Data {
                    multipartFormData.append(data, withName: key, fileName: "image.jpg", mimeType: "image/jpeg")
                }
            }
        }, to: url, method: .post, headers: header)
        .validate()
        .responseDecodable(of: ChallengePost.self) { response in
            debugPrint(response)
            switch response.result{
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                switch statusCode{
                case ..<300 :
                    guard let result = response.value else {return}
                    completionHandler(result)
                    print("챌린지 post 요청 성공")
                default : print("네트워크 fail")
                }
                // 호출 실패 시 처리 위함
            case .failure(let error):
                guard let statusCode = response.response?.statusCode else { return }
                switch statusCode{
                case 401 :
                    print("토큰 만료")
                    TokenManager.shared.refreshToken(refreshToken: refreshToken, completion: { _ in }) {
                        self.challengePost { reResponse in
                            completionHandler(reResponse)
                        }
                    }
                default : print("네트워크 fail")
                }
                print(error)
                print("챌린지 post 요청 실패")
            }
        }
    }
    
    // 챌린지 세부 화면
    func challengeDetail(detailChallengeId: Int, completionHandler : @escaping (_ data: ChallengeDetail) -> Void) {
        let accessToken = UserDefaults.standard.string(forKey: UserDefaultsKey.serverToken)!
        let refreshToken = UserDefaults.standard.string(forKey: UserDefaultsKey.refreshToken)!
        let detailChallengeId = detailChallengeId
        
        DispatchQueue.main.async {
            let url = "https://beilsang.com/api/challenges/\(detailChallengeId)"
            
            // HTTP Headers : 요청 헤더
            let header : HTTPHeaders = [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(accessToken)"
            ]
            
            AF.request(url, method: .get, encoding: URLEncoding.queryString, headers: header).validate().responseDecodable(of: ChallengeDetail.self, completionHandler: { response in
                switch response.result{
                case .success:
                    guard let statusCode = response.response?.statusCode else { return }
                    switch statusCode{
                    case ..<300 :
                        guard let result = response.value else {return}
                        completionHandler(result)
                        print("챌린지 세부화면 get 요청 성공")
                    default : print("네트워크 fail")
                    }
                    // 호출 실패 시 처리 위함
                case .failure(let error):
                    guard let statusCode = response.response?.statusCode else { return }
                    switch statusCode{
                    case 401 :
                        print("토큰 만료")
                        TokenManager.shared.refreshToken(refreshToken: refreshToken, completion: { _ in }) {
                            self.challengeDetail(detailChallengeId: detailChallengeId) { reResponse in
                                completionHandler(reResponse)
                            }
                        }
                    default : print("네트워크 fail")
                    }
                    print(error)
                    print("챌린지 세부화면 get 요청 실패")
                }
            })
        }
    }
    
    // 챌린지 인증 가이드(유의사항)
    func challengeGuide(guideChallengeId: Int, completionHandler : @escaping (_ data: ChallengeGuide) -> Void) {
        let accessToken = UserDefaults.standard.string(forKey: UserDefaultsKey.serverToken)!
        let refreshToken = UserDefaults.standard.string(forKey: UserDefaultsKey.refreshToken)!
        let guideChallengeId = guideChallengeId
        
        DispatchQueue.main.async {
            let url = "https://beilsang.com/api/feeds/guide/\(guideChallengeId)"
            
            // HTTP Headers : 요청 헤더
            let header : HTTPHeaders = [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(accessToken)"
            ]
            
            AF.request(url, method: .get, encoding: URLEncoding.queryString, headers: header).validate().responseDecodable(of: ChallengeGuide.self, completionHandler: { response in
                switch response.result{
                case .success:
                    guard let statusCode = response.response?.statusCode else { return }
                    switch statusCode{
                    case ..<300 :
                        guard let result = response.value else {return}
                        completionHandler(result)
                        print("챌린지 인증가이드 get 요청 성공")
                    default : print("네트워크 fail")
                    }
                    // 호출 실패 시 처리 위함
                case .failure(let error):
                    guard let statusCode = response.response?.statusCode else { return }
                    switch statusCode{
                    case 401 :
                        print("토큰 만료")
                        TokenManager.shared.refreshToken(refreshToken: refreshToken, completion: { _ in }) {
                            self.challengeGuide(guideChallengeId: guideChallengeId) { reResponse in
                                completionHandler(reResponse)
                            }
                        }
                    default : print("네트워크 fail")
                    }
                    print(error)
                    print("챌린지 인증가이드 get 요청 실패")
                }
            })
        }
    }
    
    // 챌린지 인증하기(등록)
    func reviewPost(reviewChallengeId: Int, completionHandler : @escaping (_ data: ChallengeCertify) -> Void) {
        let accessToken = UserDefaults.standard.string(forKey: UserDefaultsKey.serverToken)!
        let refreshToken = UserDefaults.standard.string(forKey: UserDefaultsKey.refreshToken)!
        let reviewChallengeId = reviewChallengeId
        
        let url = "https://beilsang.com/api/feeds/\(reviewChallengeId)"
        
        // HTTP Headers : 요청 헤더
        let header : HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(accessToken)"
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
            switch response.result{
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                switch statusCode{
                case ..<300 :
                    guard let result = response.value else {return}
                    completionHandler(result)
                    print("챌린지 인증하기 post 요청 성공")
                default : print("네트워크 fail")
                }
                // 호출 실패 시 처리 위함
            case .failure(let error):
                guard let statusCode = response.response?.statusCode else { return }
                switch statusCode{
                case 401 :
                    print("토큰 만료")
                    TokenManager.shared.refreshToken(refreshToken: refreshToken, completion: { _ in }) {
                        self.reviewPost(reviewChallengeId: reviewChallengeId) { reResponse in
                            completionHandler(reResponse)
                        }
                    }
                default : print("네트워크 fail")
                }
                print(error)
                print("챌린지 인증하기 post 요청 실패")
            }
        }
    }
    
    // 챌린지 참여하기 등록
    func challengeParticipatePost(joinChallengeId: Int, completionHandler : @escaping (_ data: ChallengeParticipate) -> Void) {
        let accessToken = UserDefaults.standard.string(forKey: UserDefaultsKey.serverToken)!
        let refreshToken = UserDefaults.standard.string(forKey: UserDefaultsKey.refreshToken)!
        let joinChallengeId = joinChallengeId
        
        let url = "https://beilsang.com/api/challenges/\(joinChallengeId)"
        
        // HTTP Headers : 요청 헤더
        let header : HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(accessToken)"
        ]
        
        let parameters: [String: Any] = [
            "challengId": joinChallengeId
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: header).validate().responseDecodable(of: ChallengeParticipate.self, completionHandler: { response in
            switch response.result{
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                switch statusCode{
                case ..<300 :
                    guard let result = response.value else {return}
                    completionHandler(result)
                    print("챌린지 참여하기 post 요청 성공")
                default : print("네트워크 fail")
                }
                // 호출 실패 시 처리 위함
            case .failure(let error):
                guard let statusCode = response.response?.statusCode else { return }
                switch statusCode{
                case 401 :
                    print("토큰 만료")
                    TokenManager.shared.refreshToken(refreshToken: refreshToken, completion: { _ in }) {
                        self.challengeParticipatePost(joinChallengeId: joinChallengeId) { reResponse in
                            completionHandler(reResponse)
                        }
                    }
                default : print("네트워크 fail")
                }
                print(error)
                print("챌린지 참여하기 post 요청 실패")
            }

        })
    }
    
    // 챌린지 북마크(like) 등록: post
    func challengeBookmarkPost(likeChallengeId: Int, completionHandler : @escaping (_ data: BaseModel) -> Void) {
        let accessToken = UserDefaults.standard.string(forKey: UserDefaultsKey.serverToken)!
        let refreshToken = UserDefaults.standard.string(forKey: UserDefaultsKey.refreshToken)!
        let likeChallengeId = likeChallengeId
        
        let url = "https://beilsang.com/api/challenges/\(likeChallengeId)/likes"
        
        // HTTP Headers : 요청 헤더
        let header : HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(accessToken)"
        ]
        
        let parameters: Parameters = ["challengId": likeChallengeId]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: header).validate().responseDecodable(of: BaseModel.self, completionHandler: { response in
            switch response.result{
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                switch statusCode{
                case ..<300 :
                    guard let result = response.value else {return}
                    completionHandler(result)
                    print("챌린지 북마크 post 요청 성공")
                default : print("네트워크 fail")
                }
                // 호출 실패 시 처리 위함
            case .failure(let error):
                guard let statusCode = response.response?.statusCode else { return }
                switch statusCode{
                case 401 :
                    print("토큰 만료")
                    TokenManager.shared.refreshToken(refreshToken: refreshToken, completion: { _ in }) {
                        self.challengeBookmarkPost(likeChallengeId: likeChallengeId) { reResponse in
                            completionHandler(reResponse)
                        }
                    }
                default : print("네트워크 fail")
                }
                print(error)
                print("챌린지 북마크 post 요청 실패")
            }
        })
    }
    
    // 챌린지 북마크(like) 취소: delete
    func challengeBookmarkDelete(dislikeChallengeId: Int, completionHandler : @escaping (_ data: BaseModel) -> Void) {
        let accessToken = UserDefaults.standard.string(forKey: UserDefaultsKey.serverToken)!
        let refreshToken = UserDefaults.standard.string(forKey: UserDefaultsKey.refreshToken)!
        let dislikeChallengeId = dislikeChallengeId
        
        let url = "https://beilsang.com/api/challenges/\(dislikeChallengeId)/likes"
        
        let header : HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(accessToken)"
        ]
        
        AF.request(url, method: .delete, encoding: URLEncoding.queryString, headers: header).validate().responseDecodable(of: BaseModel.self, completionHandler: { response in
            switch response.result{
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                switch statusCode{
                case ..<300 :
                    guard let result = response.value else {return}
                    completionHandler(result)
                    print("챌린지 북마크 delete 요청 성공")
                default : print("네트워크 fail")
                }
                // 호출 실패 시 처리 위함
            case .failure(let error):
                guard let statusCode = response.response?.statusCode else { return }
                switch statusCode{
                case 401 :
                    print("토큰 만료")
                    TokenManager.shared.refreshToken(refreshToken: refreshToken, completion: { _ in }) {
                        self.challengeBookmarkDelete(dislikeChallengeId: dislikeChallengeId) { reResponse in
                            completionHandler(reResponse)
                        }
                    }
                default : print("네트워크 fail")
                }
                print(error)
                print("챌린지 북마크 delete 요청 실패")
            }
        })
    }
}

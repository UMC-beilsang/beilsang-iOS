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
    
    func challengeRecommend(completionHandler : @escaping (_ data: ChallengeRecommends) -> Void) {
        DispatchQueue.main.async {
            let url = "https://beilsang.com/api/challenges/recommends"
            
            let accessToken = UserDefaults.standard.string(forKey: UserDefaultsKey.accessToken) ?? ""
            
            // HTTP Headers : 요청 헤더
            let header : HTTPHeaders = [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(accessToken)"
            ]
            
            AF.request(url, method: .get, encoding: JSONEncoding.default, headers: header).validate().responseDecodable(of: ChallengeRecommends.self, completionHandler: { response in
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
}

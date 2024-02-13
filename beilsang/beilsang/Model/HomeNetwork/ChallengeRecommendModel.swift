//
//  ChallengeRecommendModel.swift
//  beilsang
//
//  Created by 곽은채 on 2/14/24.
//

// 챌린지 관련 api 연결 모델
import Foundation

// MARK: - [MainAfterVC] 추천 챌린지
struct ChallengeRecommends: Codable {
    let isSuccess : Bool?
    let status : String
    let message : String
    let data : ChallengeRecommendsDatas?
}

struct ChallengeRecommendsDatas : Codable {
    let recommendChallengeDTOList : [ChallengeRecommendsData]
}

struct ChallengeRecommendsData : Codable {
    let challengeId : Int
    let imageUrl : String?
    let title : String
    let category : String
}

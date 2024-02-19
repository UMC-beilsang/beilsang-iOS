//
//  ChallengeRecommendModel.swift
//  beilsang
//
//  Created by 곽은채 on 2/14/24.
//

import Foundation

// MainAfterVC 추천 챌린지
struct ChallengeRecommends: Codable {
    let success : Bool?
    let code : String
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

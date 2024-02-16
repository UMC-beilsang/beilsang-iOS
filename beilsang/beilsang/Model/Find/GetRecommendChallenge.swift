//
//  GetRecommendFeed.swift
//  beilsang
//
//  Created by 강희진 on 2/12/24.
//

import Foundation

struct GetRecommendChallenge: Codable {
    let success: Bool
    let code: String
    let message: String
    let data: RecommendChallengeListData
}
struct RecommendChallengeListData: Codable {
    let recommendChallengeDTOList : [RecommendChallengeModel]?
}
struct RecommendChallengeModel: Codable {
    let challengeId : Int
    let imageUrl : String
    let title : String
    let category : String
}

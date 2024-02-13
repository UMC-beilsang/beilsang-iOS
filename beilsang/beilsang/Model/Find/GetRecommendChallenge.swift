//
//  GetRecommendFeed.swift
//  beilsang
//
//  Created by 강희진 on 2/12/24.
//

import Foundation

struct GetRecommendChallenge: Codable {
    let isSuccess: Bool
    let status: String
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

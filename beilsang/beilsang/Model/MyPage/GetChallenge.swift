//
//  GetChallenge.swift
//  beilsang
//
//  Created by 강희진 on 2/13/24.
//

import Foundation

// 찜 챌린지, 카테고리별 챌린지 리스트(발견)
struct GetChallenge : Codable{
    let isSuccess: Bool
    let status: String
    let message: String
    let data: ChallengeListModel
}
struct ChallengeListModel: Codable {
    let challenges: [ChallengeModel]?
}
struct ChallengeModel: Codable {
    let challengeId: Int
    let title: String
    let imageUrl: String
    let hostName: String
    let attendeeCount: Int
}

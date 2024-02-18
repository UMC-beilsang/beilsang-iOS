//
//  GetChallenge.swift
//  beilsang
//
//  Created by 강희진 on 2/13/24.
//

import Foundation

// 찜 챌린지, 카테고리별 챌린지 리스트(발견)
struct GetChallenge : Codable{
    let success: Bool
    let code: String
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
// 마이페이지 챌린지
struct GetMyPageChallenge : Codable {
    let success: Bool
    let code: String
    let message: String
    let data: MyPageChallengeListModel
}
struct MyPageChallengeListModel: Codable {
    let challenges: ChallengeListModel
    let count: Int
}

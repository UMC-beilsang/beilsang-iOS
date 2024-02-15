//
//  ChallengeCategoryModel.swift
//  beilsang
//
//  Created by 곽은채 on 2/14/24.
//

import Foundation

// ChallengeListVC 카테고리별 챌린지 조회
struct ChallengeCategory: Codable {
    let success : Bool?
    let code : String
    let message : String
    let data : ChallengeCategoryList?
}

struct ChallengeCategoryList : Codable {
    let challenges : [ChallengeCategoryData]
}

struct ChallengeCategoryData : Codable {
    let challengeId : Int
    let title : String
    let imageUrl : String?
    let hostName : String
    let attendeeCount : Int
}

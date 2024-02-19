//
//  ChallengeJoinTwoModel.swift
//  beilsang
//
//  Created by 곽은채 on 2/20/24.
//

import Foundation

// MainAfterVC 참여중 챌린지 두 개 조회
struct ChallengeJoinTwo: Codable {
    let success : Bool?
    let code : String
    let message : String
    let data : ChallengeJoinTwoList?
}

struct ChallengeJoinTwoList : Codable {
    let challenges : [ChallengeJoinTwoData]
}

struct ChallengeJoinTwoData : Codable {
    let challengeId : Int
    let title : String
    let imageUrl : String?
    let achieveRate : Int
}

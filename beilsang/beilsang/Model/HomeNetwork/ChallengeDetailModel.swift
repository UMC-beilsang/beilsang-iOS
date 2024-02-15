//
//  ChallengeDetailModel.swift
//  beilsang
//
//  Created by 곽은채 on 2/15/24.
//

import Foundation

// ChallengeDetailVC 챌린지 세부 화면
// JoinChallengeVC 참여중 챌린지 화면
// 위 두 vc에서 동일한 api 사용하므로 하나만 선언
struct ChallengeDetail: Codable {
    let success : Bool?
    let code : String
    let message : String
    let data : ChallengeDetailData
}

struct ChallengeDetailData : Codable {
    let attendeeCount : Int
    let hostName : String
    let createdDate : String
    let imageUrl : String?
    let certImageUrl : String?
    let title : String
    let startDate : String
    let category : String
    let details : String
    let joinPoint : Int
    let challengeNotes : [String]
    let likes : Int
    let like : Bool
    let period : String
    let totalGoalDay : Int
    let dday : Int
}

//
//  ChallengeJoinFeedModel.swift
//  beilsang
//
//  Created by 곽은채 on 2/20/24.
//

import Foundation

// 참여 중 챌린지 화면에서의 피드
import Foundation

struct ChallengeJoinFeed: Codable {
    let success : Bool?
    let code : String
    let message : String
    let data : ChallengeJoinFeedList?
}

struct ChallengeJoinFeedList : Codable {
    let feeds : [ChallengeJoinFeedData]
}

struct ChallengeJoinFeedData : Codable {
    let feedId : Int
    let feedUrl : String
    let day : Int
}

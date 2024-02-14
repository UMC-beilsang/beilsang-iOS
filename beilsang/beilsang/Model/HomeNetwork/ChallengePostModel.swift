//
//  ChallengePostModel.swift
//  beilsang
//
//  Created by 곽은채 on 2/14/24.
//

import Foundation

// RegisterFirst~ThirdVC 챌린지 생성
struct ChallengePost: Codable {
    let isSuccess : Bool?
    let status : String
    let message : String
    let data : ChallengePostData
}

struct ChallengePostData : Codable {
    let challengeId : Int
    let title : String
    let imageUrl : String?
    let hostName : String
    let attendeeCount : Int
}

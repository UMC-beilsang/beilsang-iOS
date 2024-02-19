//
//  ChallengeParticipateModel.swift
//  beilsang
//
//  Created by 곽은채 on 2/19/24.
//


// 챌린지 참여하기 post
import Foundation

struct ChallengeParticipate : Codable {
    let success : Bool?
    let code : String
    let message : String
    let data : ChallengeParticipateData
}

struct ChallengeParticipateData : Codable {
    let challengePreviewDTO : ChallengeParticipatePreview
    let memberDTO : ChallengeParticipateMember
}

struct ChallengeParticipatePreview : Codable {
    let challengeId : Int
    let title : String
    let imageUrl : String?
    let hostName : String
    let attendeeCount : Int
}

struct ChallengeParticipateMember : Codable {
    let memberId : Int
    let nickName : String
    let totalPoint : Int
}

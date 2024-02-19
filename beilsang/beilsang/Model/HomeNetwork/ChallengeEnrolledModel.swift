//
//  ChallengeEnrolledModel.swift
//  beilsang
//
//  Created by 곽은채 on 2/18/24.
//

// 사용자가 클릭한 챌린지에 참여 중인지 여부를 알려주는 api 연결 model
import Foundation

struct ChallengeEnrolled: Codable {
    let success : Bool?
    let code : String
    let message : String
    let data : ChallengeEnrolledData
}

struct ChallengeEnrolledData : Codable {
    let isEnrolled : Bool
    let enrolledChallengeIds : [Int]
}

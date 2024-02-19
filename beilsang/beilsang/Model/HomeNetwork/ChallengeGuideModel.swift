//
//  ChallengeGuideModel.swift
//  beilsang
//
//  Created by 곽은채 on 2/15/24.
//

import Foundation

// ChallengeDetailVC 인증 가이드 유의사항
// RegisterCertifyModalVC 인증 가이드 유의사항
struct ChallengeGuide: Codable {
    let success : Bool?
    let code : String
    let message : String
    let data : ChallengeGuideData
}

struct ChallengeGuideData : Codable {
    let certImage : String
    let challengeNoteList : [String]
}

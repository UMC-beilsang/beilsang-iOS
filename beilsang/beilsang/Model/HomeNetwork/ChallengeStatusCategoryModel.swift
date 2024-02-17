//
//  ChallengeStatusCategoryModel.swift
//  beilsang
//
//  Created by 곽은채 on 2/18/24.
//

// 카테고리와 상태로 필터링한 사욛ㅇ자가 참여중인 챌린지 조회
// ChallengeCategory와는 count에서 차이점 있어서 새로운 모델
// ChallengeListVC - 참여중 챌린지 화면
import Foundation

struct ChallengeStatus: Codable {
    let success : Bool?
    let code : String
    let message : String
    let data : ChallengeStatusList?
}

struct ChallengeStatusList : Codable {
    let challenges : ChallengeStatusDataList
    let count : Int
}

struct ChallengeStatusDataList : Codable {
    let challenges : [ChallengeCategoryData]
}

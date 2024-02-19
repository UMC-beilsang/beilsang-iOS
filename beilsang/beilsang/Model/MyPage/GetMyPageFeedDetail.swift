//
//  GetMyPageFeedDetail.swift
//  beilsang
//
//  Created by 강희진 on 2/12/24.
//

import Foundation

struct GetMyPageFeedDetail : Codable {
    let success: Bool
    let code: String
    let message: String
    let data: MyPageFeedDetailData
}
struct MyPageFeedDetailData: Codable {
    let id : Int
    let review : String
    let uploadDate : String
    let feedUrl : String
    let challengeTitle : String
    let category: String
    let likes: Int
    let like: Bool
    let day: Int
    let nickName: String
    let profileImage: String?
}

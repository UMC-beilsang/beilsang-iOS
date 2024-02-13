//
//  MyPageModel.swift
//  beilsang
//
//  Created by 강희진 on 2/8/24.
//

import Foundation

struct GetMyPage: Codable {
    let isSuccess: Bool
    let status: String
    let message: String
    let data: MyPageData
}
struct MyPageData: Codable {
    let feedNum: Int
    let achieve: Int
    let fail: Int
    let resolution: String?
    let challenges: Int
    let likes: Int
    let points: Int
    let feedDTOs: FeedList
    let nickName: String
    let profileImage: String
}
struct FeedList: Codable {
    let feeds: [feedData]?
}
struct feedData: Codable {
    let feedId: Int
    let feedUrl: String
    let day: String
}

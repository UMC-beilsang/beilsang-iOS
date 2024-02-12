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
    let data: GetMyPageData
}
struct GetMyPageData: Codable {
    let feedNum: Int
    let achieve: Int
    let fail: Int
    let resolution: String?
    let challenges: Int
    let likes: Int
    let points: Int
    let feedDTOs: GetFeed
}
struct GetFeed: Codable {
    let feeds: [feedData]
}
struct feedData: Codable {
    let feedId: Int
    let feedUrl: String
}

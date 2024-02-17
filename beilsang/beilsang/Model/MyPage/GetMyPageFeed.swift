//
//  GetMyPageFeed.swift
//  beilsang
//
//  Created by 강희진 on 2/12/24.
//

import Foundation

struct GetMyPageFeed : Codable{
    let isSuccess: Bool
    let status: String
    let message: String
    let data: MyPageFeedList
}

struct MyPageFeedList : Codable{
    let feeds: [MyPageFeed]
}
struct MyPageFeed : Codable{
    let feedId: Int
    let feedUrl: String
}

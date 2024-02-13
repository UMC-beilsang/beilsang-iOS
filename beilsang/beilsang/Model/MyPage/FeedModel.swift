//
//  GetMyPageFeed.swift
//  beilsang
//
//  Created by 강희진 on 2/12/24.
//

import Foundation

struct GetFeedModel : Codable{
    let isSuccess: Bool
    let status: String
    let message: String
    let data: FeedListModel
}

struct FeedListModel : Codable{
    let feeds: [FeedModel]?
}
struct FeedModel : Codable{
    let feedId: Int
    let feedUrl: String
}

//
//  SearchModel.swift
//  beilsang
//
//  Created by Seyoung on 2/18/24.
//

import Foundation

struct SearchResponse: Codable {
    let code: String
    let message: String
    let data: SearchData
    let success : Bool
}

struct SearchData: Codable {
    let challenges: [Challenge]
    let feeds: [Feed]
}

struct Challenge: Codable {
    let challengeId: Int
    let title: String
    let imageUrl: String
    let hostName: String
    let attendeeCount: Int
}

struct Feed: Codable {
    let feedId: Int
    let feedUrl: String
    let day: Int
}

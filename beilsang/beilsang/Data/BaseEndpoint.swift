//
//  BaseEndpoint.swift
//  beilsang
//
//  Created by 강희진 on 2/8/24.
//

import Foundation

enum BaseEndpoint {
    case challenges
    case mypage
    case profile
    case feeds
    
    var requestURL: String {
        switch self {
        case .challenges: return URL.makeEndPointString("/challenges")
        case .mypage: return URL.makeEndPointString("/api/mypage")
        case .profile: return URL.makeEndPointString("/api/profile")
        case .feeds: return URL.makeEndPointString("/api/feeds")

        }
    }
}

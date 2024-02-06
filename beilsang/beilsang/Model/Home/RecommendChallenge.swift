//
//  RecommendChallenge.swift
//  beilsang
//
//  Created by Seyoung on 2/7/24.
//

import Foundation
import UIKit

struct RecommendChallenge {
    let title: String
    let category: String
    var image: String
}

extension RecommendChallenge {
    static var data = [
        RecommendChallenge(title: "버스 이용자 모여라", category: "대중교통 챌린지", image: "representImage"),
        RecommendChallenge(title: "버스 이용자 모여라", category: "대중교통 챌린지", image: "representImage")
    ]
}

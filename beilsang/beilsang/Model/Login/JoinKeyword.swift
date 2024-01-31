//
//  JoinKeyword.swift
//  beilsang
//
//  Created by Seyoung on 1/20/24.
//

import Foundation
import UIKit

struct Keyword {
    let title: String
    var image: String
}

extension Keyword {
    static var data = [
    Keyword(title: "텀블러/다회용컵", image: "tumblr"),
    Keyword(title: "리필스테이션", image: "refill"),
    Keyword(title: "다회용기", image: "reusable"),
    Keyword(title: "친환경제품", image: "eco"),
    Keyword(title: "플로깅", image: "plogging"),
    Keyword(title: "비건", image: "vegan"),
    Keyword(title: "대중교통", image: "public"),
    Keyword(title: "자전거", image: "bike"),
    Keyword(title: "재활용/재사용", image: "recycle"),
    ]
}

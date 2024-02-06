//
//  CategoryKeyword.swift
//  beilsang
//
//  Created by 곽은채 on 1/26/24.
//

// [홈] 메인화면 카테고리 키워드
// JoinKeyword에서 "전체" 추가
import Foundation
import UIKit

struct CategoryKeyword {
    let title: String
    var image: String
}

extension CategoryKeyword {
    static var data = [
        Keyword(title: "전체", image: "all"),
        Keyword(title: "다회용컵", image: "tumblr"),
        Keyword(title: "리필스테이션", image: "refill"),
        Keyword(title: "다회용기", image: "reusable"),
        Keyword(title: "친환경제품", image: "eco"),
        Keyword(title: "플로깅", image: "plogging"),
        Keyword(title: "비건", image: "vegan"),
        Keyword(title: "대중교통", image: "public"),
        Keyword(title: "자전거", image: "bike"),
        Keyword(title: "재활용", image: "recycle"),
    ]
    static var find = [
        // 발견 - 명예의 전당 카테고리
        Keyword(title: "다회용컵", image: "🥛"),
        Keyword(title: "리필스테이션", image: "📍"),
        Keyword(title: "다회용기", image: "🥣"),
        Keyword(title: "친환경제품", image: "🌱"),
        Keyword(title: "플로깅", image: "👟"),
        Keyword(title: "비건", image: "🥬"),
        Keyword(title: "대중교통", image: "🚌"),
        Keyword(title: "자전거", image: "🚲"),
        Keyword(title: "재활용", image: "♻️"),
    ]
}

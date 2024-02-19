//
//  CategoryConverter.swift
//  beilsang
//
//  Created by 곽은채 on 2/16/24.
//

// 카테고리 변환을 위한 class
// 프론트에서 사용자가 한글로 입력한 내용을 영어로 변환해 백에 전달할 때 사용
// 백에서 전달된 영어 형태의 카테고리 내용을 한글로 화면에 나타낼 때 사용
// 백에서 전달된 영어 형태의 카테고리 내용을 통해 카테고리의 아이콘을 얻음
import Foundation

class CategoryConverter {
    static let shared = CategoryConverter()

    private let categoryMap = [
        "전체": "ALL",
        "다회용컵": "TUMBLER",
        "리필스테이션": "REFILL_STATION",
        "다회용기": "MULTIPLE_CONTAINERS",
        "친환경제품": "ECO_PRODUCT",
        "플로깅": "PLOGGING",
        "비건": "VEGAN",
        "대중교통": "PUBLIC_TRANSPORT",
        "자전거": "BIKE",
        "재활용": "RECYCLE"
    ]
    
    private let categoryEngMap = [
        "ALL": "전체",
        "TUMBLER": "다회용컵",
        "REFILL_STATION": "리필스테이션",
        "MULTIPLE_CONTAINERS": "다회용기",
        "ECO_PRODUCT": "친환경제품",
        "PLOGGING": "플로깅",
        "VEGAN": "비건",
        "PUBLIC_TRANSPORT": "대중교통",
        "BIKE": "자전거",
        "RECYCLE": "재활용"
    ]
    
    private let categoryIconMap = [
        "TUMBLER": "🥛",
        "REFILL_STATION": "📍",
        "MULTIPLE_CONTAINERS": "🥣",
        "ECO_PRODUCT": "🌱",
        "PLOGGING": "👟",
        "VEGAN": "🥬",
        "PUBLIC_TRANSPORT": "🚌",
        "BIKE": "🚲",
        "RECYCLE": "♻️"
    ]

    private init() {}

    func convertToEnglish(_ category: String) -> String? {
        return categoryMap[category]
    }

    func convertToKorean(_ category: String) -> String? {
        return categoryEngMap[category]
    }
    
    func convertToIcon(_ category: String) -> String? {
        return categoryIconMap[category]
    }
}

//
//  PeriodConverter.swift
//  beilsang
//
//  Created by 곽은채 on 2/16/24.
//

// 실천 기간 형태 변환을 위한 class
// 각 코드에 써도 되지만 코드가 너무 길어져서 만드는 김에 생성
import Foundation

class PeriodConverter {
    static let shared = PeriodConverter()

    private let periodMap = ["일주일": "WEEK", "한 달": "MONTH"]
    private let periodEngMap = ["WEEK": "일주일", "MONTH": "한 달"]

    private init() {}

    func convertToEnglish(_ period: String) -> String? {
        return periodMap[period]
    }

    func convertToKorean(_ period: String) -> String? {
        return periodEngMap[period]
    }
}

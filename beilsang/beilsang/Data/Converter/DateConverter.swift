//
//  DateConverter.swift
//  beilsang
//
//  Created by 곽은채 on 2/16/24.
//

// 날짜 형태를 변환하는 class
// 서버 yyyy-MM-dd와 프론트 yyyy년 MM월 dd일 형태를 서로 변환하기 위함
import Foundation

class DateConverter {
    static let shared = DateConverter()
    
    private let serverFormatter: DateFormatter
    private let frontFormatter: DateFormatter
    
    private let detailFormatter: DateFormatter
    private let dayMap = [
        "MONDAY": "(월)",
        "TUESDAY": "(화)",
        "WEDNESDAY": "(수)",
        "THURSDAY": "(목)",
        "FRIDAY": "(금)",
        "SATURDAY": "(토)",
        "SUNDAY": "(일)"
    ]
    
    private let joinFormatter: DateFormatter
    
    private init() {
        serverFormatter = DateFormatter()
        serverFormatter.dateFormat = "yyyy-MM-dd" // 서버 날짜 형식
        
        frontFormatter = DateFormatter()
        frontFormatter.dateFormat = "yyyy년 MM월 dd일" // 화면 표시 날짜 형식
        
        detailFormatter = DateFormatter()
        detailFormatter.dateFormat = "MM. dd" // ChallengeDetailVC 날짜 형식
        
        joinFormatter = DateFormatter()
        joinFormatter.dateFormat = "MM/dd"
    }
    
    func convertToFrontFormat(from serverDate: String) -> String? {
        if let date = serverFormatter.date(from: serverDate) {
            return frontFormatter.string(from: date)
        }
        
        return nil
    }
    
    func convertToServerFormat(from displayDate: String) -> String? {
        if let date = frontFormatter.date(from: displayDate) {
            return serverFormatter.string(from: date)
        }
        
        return nil
    }
    
    func convertToDay(_ day: String) -> String? {
        return dayMap[day]
    }
    
    func convertDetail(from serverDate: String) -> String? {
        if let date = serverFormatter.date(from: serverDate) {
            return detailFormatter.string(from: date)
        }
        
        return nil
    }
    
    func converJoin(from serverDate: String) -> String? {
        if let date = serverFormatter.date(from: serverDate) {
            return joinFormatter.string(from: date)
        }
        
        return nil
    }
}

//
//  ChallengeDataSingleton.swift
//  beilsang
//
//  Created by 곽은채 on 2/14/24.
//

import Foundation

class ChallengeDataSingleton {
    static let shared = ChallengeDataSingleton()
    
    var mainImage: Data?
    var title: String?
    var category: String?
    var startDate: String?
    var period: String?
    var totalGoalDay: Int?
    var details: String?
    var notes: [String] = []
    var certImage: Data?
    var joinPoint: Int?
    
    private init() {}
    
    func resetData() {
        mainImage = nil
        title = nil
        category = nil
        startDate = nil
        period = nil
        totalGoalDay = nil
        details = nil
        notes = []
        certImage = nil
        joinPoint = nil
    }
}

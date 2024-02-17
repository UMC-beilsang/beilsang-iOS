//
//  ChallengeCertifySingleton.swift
//  beilsang
//
//  Created by 곽은채 on 2/16/24.
//

import Foundation

class ChallengeCertifySingleton {
    static let shared = ChallengeCertifySingleton()
    
    var image: Data?
    var review: String?
    
    private init() {}
    
    func resetData() {
        image = nil
        review = nil
    }
}

//
//  URLSetting.swift
//  beilsang
//
//  Created by 강희진 on 2/8/24.
//

import Foundation

extension URL {
    static let baseURL = "https://beilsang.com"
    
    static func makeEndPointString(_ endpoint:String) -> String {
        return baseURL + endpoint
    }
}

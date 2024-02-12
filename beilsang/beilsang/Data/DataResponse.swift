//
//  DataResponse.swift
//  beilsang
//
//  Created by 강희진 on 2/8/24.
//

import Foundation

/**
    API 응답 구현체 값
 */
struct AFDataResponse<T: Codable>: Codable {
    
    // 성공 여부
    let isSuccess: Bool?
    
    // 응답 코드
    let status: String?
    
    // 응답 메시지
    let message: String?
    
    // 응답 데이터
    let data: T?
    
    enum CodingKeys: CodingKey {
        case isSuccess, status, message, data
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        isSuccess = (try? values.decode(Bool.self, forKey: .isSuccess)) ?? nil
        status = (try? values.decode(String.self, forKey: .status)) ?? nil
        message = (try? values.decode(String.self, forKey: .message)) ?? nil
        data = (try? values.decode(T.self, forKey: .data)) ?? nil
    }
}

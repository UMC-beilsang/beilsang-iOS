//
//  ChallengeCertifyModel.swift
//  beilsang
//
//  Created by 곽은채 on 2/16/24.
//

import Foundation

struct ChallengeCertify: Codable {
    let success : Bool?
    let code : String
    let message : String
    let data : Int
}

struct ChallengeCertifyData : Codable {
    let feedImage : String
    let review : String
}

extension Encodable {
    // struct를 파라미터 형식(딕셔러니)로 변경
    var toDictionary : [String: Any]? {
        guard let object = try? JSONEncoder().encode(self) else { return nil }
        guard let dictionary = try? JSONSerialization.jsonObject(with: object, options: []) as? [String:Any] else { return nil }
        return dictionary
    }
}

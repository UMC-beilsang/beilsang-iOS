//
//  PostAccountInfo.swift
//  beilsang
//
//  Created by 강희진 on 2/10/24.
//

import Foundation
import Alamofire

struct PatchAccountInfo : Codable{
    let isSuccess: Bool
    let status: String
    let message: String
    let data: AccountInfoData
}

struct AccountInfoData: Codable {
    let nickName : String
    let birth : String
    let gender: String
    let address: String
}

extension Encodable {
    // struct를 파라미터 형식(딕셔러니)로 변경
    var toDictionary : [String: Any]? {
        guard let object = try? JSONEncoder().encode(self) else { return nil }
        guard let dictionary = try? JSONSerialization.jsonObject(with: object, options: []) as? [String:Any] else { return nil }
        return dictionary
    }
}

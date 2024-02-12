//
//  PostAccountInfo.swift
//  beilsang
//
//  Created by 강희진 on 2/10/24.
//

import Foundation
import Alamofire

struct PostAccountInfo : Codable{
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
    
    var toDictionary : [String: Any]? {
        guard let object = try? JSONEncoder().encode(self) else { return nil }
        guard let dictionary = try? JSONSerialization.jsonObject(with: object, options: []) as? [String:Any] else { return nil }
        return dictionary
    }
}
//extension String {
//    func toDate() -> Date? { //"yyyy-MM-dd"
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        if let date = dateFormatter.date(from: self) {
//            return dateFormatter.string(from: date)
//        } else {
//            return nil
//        }
//    }
//}

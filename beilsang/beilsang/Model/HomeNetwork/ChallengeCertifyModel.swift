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

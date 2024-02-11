//
//  SignUpModel.swift
//  beilsang
//
//  Created by Seyoung on 2/11/24.
//

import Foundation

struct Empty: Codable { }

struct SignUpResponse: Codable {
    let isSuccess : Bool?
    let status : String
    let message : String?
    let data : Empty
}


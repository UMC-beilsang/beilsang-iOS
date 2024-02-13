//
//  GetPoint.swift
//  beilsang
//
//  Created by 강희진 on 2/10/24.
//

import Foundation

struct GetPoint : Codable{
    let isSuccess: Bool
    let status: String
    let message: String
    let data: PointDataList
}
struct PointDataList: Codable {
    let total : Int
    let points: [PointData]?
}
struct PointData : Codable {
    let id : Int
    let name : String
    let status : String
    let value : Int
    let date : String //"2024-02-10"
    let period : Int
}

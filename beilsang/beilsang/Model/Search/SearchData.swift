//
//  SearchData.swift
//  beilsang
//
//  Created by Seyoung on 2/19/24.
//

import Foundation

class SearchGlobalData {
    static let shared = SearchGlobalData()

    var searchText: String?

    private init() {}
}

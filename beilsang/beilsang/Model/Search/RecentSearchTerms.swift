//
//  RecentSearchTerms.swift
//  beilsang
//
//  Created by Seyoung on 2/18/24.
//

import Foundation
import UIKit

struct RecentSearchTerms {
    let label: String
}

extension RecentSearchTerms {
    static var data = [
        RecentSearchTerms(label: "플로깅"),
        RecentSearchTerms(label: "플로ㄱ"),
        RecentSearchTerms(label: "박세영입니다 ㄱ"),
    ]
}

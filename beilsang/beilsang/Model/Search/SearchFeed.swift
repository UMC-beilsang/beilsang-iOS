//
//  SearchFeed.swift
//  beilsang
//
//  Created by Seyoung on 2/18/24.
//

import Foundation
import UIKit

struct SearchFeed {
    let image: String
    //네트워크 연결할때 아이디도 추가 무슨 인증샷 나타내는지
}

extension SearchFeed {
    static var data = [
        GalleryData(image: "representImage"),
        GalleryData(image: "representImage"),
        GalleryData(image: "representImage"),
        GalleryData(image: "representImage")
    ]
}

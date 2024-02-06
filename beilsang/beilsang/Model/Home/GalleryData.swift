//
//  GalleryData.swift
//  beilsang
//
//  Created by Seyoung on 2/6/24.
//

import Foundation
import UIKit

struct GalleryData {
    let image: String
    //네트워크 연결할때 아이디도 추가 무슨 인증샷 나타내는지 
}

extension GalleryData {
    static var data = [
        GalleryData(image: "representImage"),
        GalleryData(image: "representImage"),
        GalleryData(image: "representImage"),
        GalleryData(image: "representImage")
    ]
}

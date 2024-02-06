//
//  String+.swift
//  beilsang
//
//  Created by Seyoung on 2/6/24.
//

import Foundation

extension String {
    var textWithoutSpecialCharacters: String {
        // 특수문자, 숫자, 이모지를 제외한 문자만 추출하는 정규식 패턴
        let pattern = "[^a-zA-Z가-힣ㄱ-ㅎㅏ-ㅣ\\p{So}\\p{N}]"
        
        // 정규식을 이용하여 특수문자, 숫자, 이모지를 제외하고 텍스트만 추출
        return self.replacingOccurrences(of: pattern, with: "", options: .regularExpression, range: nil)
    }
}

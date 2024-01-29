//
//  InfoCircle+.swift
//  beilsang
//
//  Created by Seyoung on 1/29/24.
//

import UIKit

class CircleView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        // 뷰의 초기화 코드 추가
        setupView()
    }

    private func setupView() {
        backgroundColor = .beCta
        layer.cornerRadius = 2
        // 다른 초기화 코드를 추가할 수 있습니다.
        
        
    }
}

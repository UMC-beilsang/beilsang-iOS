//
//  ScrollIndicatorView.swift
//  beilsang
//
//  Created by 강희진 on 2/4/24.
//

import UIKit
import SnapKit

class ScrollIndicatorView: UIView {

    lazy var scrollIndicatorBase: UIView = {
        let view = UIView()
        view.backgroundColor = .beBgSub
        view.layer.cornerRadius = 2
        return view
    }()
    lazy var scrollIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = .beScPurple400
        view.layer.cornerRadius = 2
        return view
    }()
        
    private var leftInsetConstraint: Constraint?

    override init(frame: CGRect) {
        super.init(frame: frame)
      
        self.addSubview(self.scrollIndicatorBase)
        self.scrollIndicatorBase.addSubview(self.scrollIndicator)
        scrollIndicatorBase.snp.makeConstraints { make in
            make.size.edges.equalToSuperview()
        }
        scrollIndicator.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
            make.width.equalTo(10)
            self.leftInsetConstraint = make.left.equalToSuperview().priority(999).constraint
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: Properties
    var widthRatio: Double? {
      didSet {
        guard let widthRatio = self.widthRatio else { return }
          scrollIndicator.snp.remakeConstraints { make in
              make.top.bottom.equalToSuperview()
              make.width.equalToSuperview().multipliedBy(widthRatio)
              make.left.greaterThanOrEqualToSuperview()
              make.right.lessThanOrEqualToSuperview()
              self.leftInsetConstraint = make.left.equalToSuperview().priority(999).constraint
          }
      }
    }
    var leftOffsetRatio: Double? {
      didSet {
        guard let leftOffsetRatio = self.leftOffsetRatio else { return }
        self.leftInsetConstraint?.update(inset: leftOffsetRatio * self.bounds.width)
      }
    }
}

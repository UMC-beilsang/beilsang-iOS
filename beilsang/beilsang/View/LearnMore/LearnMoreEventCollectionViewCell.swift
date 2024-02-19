//
//  LearnMoreEventCollectionViewCell.swift
//  beilsang
//
//  Created by 강희진 on 2/17/24.
//

import UIKit

class LearnMoreEventCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "learnMoreEventCollectionViewCell"
    
    lazy var eventTopView : UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.beBorderDis.cgColor
        view.layer.borderWidth = 1
        view.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        return view
    }()
    lazy var eventBottomView : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.beBorderDis.cgColor
        view.backgroundColor = .beBgSub
        view.layer.borderWidth = 1
        view.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMaxYCorner, .layerMaxXMaxYCorner)
        return view
    }()
    lazy var eventBottomLabel : UILabel = {
        let label = UILabel()
        label.text = "이벤트명"
        label.font = UIFont(name: "NotoSansKR-Regular", size: 12)
        label.textColor = .beTextInfo
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setLayout()
    }
}
// MARK: - layout setting
extension LearnMoreEventCollectionViewCell {
    func setLayout() {
        [eventTopView, eventBottomView].forEach { view in
            self.addSubview(view)
        }
        eventBottomView.addSubview(eventBottomLabel)
        eventTopView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(160)
        }
        eventBottomView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalTo(eventTopView.snp.bottom).offset(-1) // 겹치는 테두리를 위해 offset 설정
        }
        eventBottomLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-12)
        }
    }
}

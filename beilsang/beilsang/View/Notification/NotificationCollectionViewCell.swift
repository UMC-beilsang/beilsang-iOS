//
//  NotificationCollectionViewCell.swift
//  beilsang
//
//  Created by 강희진 on 2/7/24.
//

import UIKit

class NotificationCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "notificationCollectionViewCell"
    
    lazy var checkImage : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon-check")
        return view
    }()
    
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        label.text = "참여 챌린지 시작 알림"
        return label
    }()
    
    lazy var contentLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NotoSansKR-SemiBold", size: 14)
        label.text = "앤님이 참여하는 플로깅 챌린지가 시작되었습니다!"
        return label
    }()
    
    lazy var timeLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NotoSansKR-SemiBold", size: 12)
        label.text = "7시간 전"
        label.textColor = .beTextEx
        return label
    }()
    
    //사용자가 선택한 셀에 따라 POST
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
extension NotificationCollectionViewCell {
    func setLayout() {
        [checkImage, titleLabel, contentLabel, timeLabel].forEach { view in
            self.addSubview(view)
        }
        checkImage.snp.makeConstraints { make in
            make.width.height.equalTo(28)
            make.top.leading.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(checkImage.snp.trailing).offset(12)
            make.centerY.equalTo(checkImage)
        }
        contentLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalTo(titleLabel)
        }
        timeLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalTo(titleLabel)
        }
    }
}

//
//  NoticeCollectionViewCell.swift
//  beilsang
//
//  Created by 곽은채 on 2/3/24.
//

import SnapKit
import UIKit

// [홈] 챌린지 유의사항 등록하기 레이블
class NoticeCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "NoticeLabelViewCell"
    
    lazy var noticeView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .beBgCard
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.beBorderDis.cgColor
        view.clipsToBounds = false
        
        return view
    }()
    
    lazy var noticeLabel: UILabel = {
        let view = UILabel()
        
        view.textColor = .beTextDef
        view.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        
        return view
    }()
    
    lazy var deleteButton: UIButton = {
        let view = UIButton()
        
        view.setImage(UIImage(named: "icon-close-circle"), for: .normal)
        view.imageView?.contentMode = .scaleAspectFill
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NoticeCollectionViewCell {
    func setLayout() {
        addSubview(noticeView)
        
        noticeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        noticeView.addSubview(noticeLabel)
        noticeView.addSubview(deleteButton)
        
        noticeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(noticeView.snp.centerY)
            make.leading.equalTo(noticeView.snp.leading).offset(19)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.centerY.equalTo(noticeView.snp.centerY)
            make.trailing.equalTo(noticeView.snp.trailing).offset(-12)
            make.width.height.equalTo(24)
        }
    }
}

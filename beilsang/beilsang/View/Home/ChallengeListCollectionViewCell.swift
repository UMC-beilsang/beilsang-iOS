//
//  ChallengeListCollectionViewCell.swift
//  beilsang
//
//  Created by 곽은채 on 1/26/24.
//

import SnapKit
import UIKit

// [홈] 챌린지 리스트
class ChallengeListCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ChallengeListViewCell"
    
    var challengeListChallengeId : Int? = nil
    
    // 챌린지 전체 버튼
    lazy var challengeView: UIView = {
        let view = UIView()
        
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.beBorderDis.cgColor
        
        return view
    }()
    
    // 챌린지 이미지
    lazy var challengeImage: UIImageView = {
        let view = UIImageView()
        
        view.image = UIImage(named: "testChallengeImage")
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        return view
    }()
    
    // 챌린지 제목
    lazy var challengeNameLabel: UILabel = {
        let view = UILabel()
        
        view.textColor = .beTextWhite
        view.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        
        return view
    }()
    
    // 챌린지 버튼 하단 뷰
    lazy var bottomView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .beBgSub
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        return view
    }()
    
    // 챌린지 버튼 작성자명 레이블
    lazy var makerNickname: UILabel = {
        let view = UILabel()
        
        view.textColor = .beTextInfo
        view.font = UIFont(name: "Noto Sans KR", size: 12)
        
        return view
    }()
    
    // 챌린지 버튼 - 레이블
    lazy var buttonLabel: UILabel = {
        let view = UILabel()
        view.textColor = .beNavy500
        view.font = UIFont(name: "Noto Sans KR", size: 12)
        
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

extension ChallengeListCollectionViewCell {
    func setLayout() {
        addSubview(challengeView)
        
        challengeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        challengeView.addSubview(challengeImage)
        challengeView.addSubview(bottomView)
        
        challengeImage.snp.makeConstraints { make in
            make.top.equalTo(challengeView.snp.top)
            make.leading.equalTo(challengeView.snp.leading)
            make.trailing.equalTo(challengeView.snp.trailing)
            make.height.equalTo(100)
        }
        
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(challengeImage.snp.bottom)
            make.bottom.equalTo(challengeView.snp.bottom)
            make.width.equalTo(challengeView.snp.width)
        }
        
        challengeImage.addSubview(challengeNameLabel)
        
        challengeNameLabel.snp.makeConstraints { make in
            make.top.equalTo(challengeView.snp.top).offset(68)
            make.leading.equalTo(challengeView.snp.leading).offset(16)
            make.height.equalTo(20)
        }
        
        bottomView.addSubview(makerNickname)
        bottomView.addSubview(buttonLabel)
        
        makerNickname.snp.makeConstraints { make in
            make.leading.equalTo(bottomView.snp.leading).offset(20)
            make.centerY.equalTo(bottomView.snp.centerY)
        }
        
        buttonLabel.snp.makeConstraints { make in
            make.trailing.equalTo(bottomView.snp.trailing).offset(-20)
            make.centerY.equalTo(makerNickname.snp.centerY)
        }
    }
}

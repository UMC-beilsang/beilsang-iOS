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
    
    // 챌린지 전체 버튼
    lazy var challengeButton: UIButton = {
        let view = UIButton()
        
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
    var challengeName = "다회용기 픽업하기"
    lazy var challengeNameLabel: UILabel = {
        let view = UILabel()
        
        view.text = challengeName
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
        
        view.text = "작성자명"
        view.textColor = .beTextInfo
        view.font = UIFont(name: "Noto Sans KR", size: 12)
        
        return view
    }()
    
    // 챌린지 버튼 참여 인원 레이블
    var numOfPeople = Int.random(in: 0...100)
    lazy var numOfPeopleLabel: UILabel = {
        let view = UILabel()
        
        view.text = "참여 인원 \(numOfPeople)명"
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
        addSubview(challengeButton)
        
        challengeButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        challengeButton.addSubview(challengeImage)
        challengeButton.addSubview(bottomView)
        
        challengeImage.snp.makeConstraints { make in
            make.top.equalTo(challengeButton.snp.top)
            make.leading.equalTo(challengeButton.snp.leading)
            make.trailing.equalTo(challengeButton.snp.trailing)
            make.height.equalTo(100)
        }
        
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(challengeImage.snp.bottom)
            make.bottom.equalTo(challengeButton.snp.bottom)
            make.width.equalTo(challengeButton.snp.width)
        }
        
        challengeImage.addSubview(challengeNameLabel)
        
        challengeNameLabel.snp.makeConstraints { make in
            make.top.equalTo(challengeButton.snp.top).offset(68)
            make.leading.equalTo(challengeButton.snp.leading).offset(16)
            make.height.equalTo(20)
        }
        
        bottomView.addSubview(makerNickname)
        bottomView.addSubview(numOfPeopleLabel)
        
        makerNickname.snp.makeConstraints { make in
            make.leading.equalTo(bottomView.snp.leading).offset(20)
            make.centerY.equalTo(bottomView.snp.centerY)
        }
        
        numOfPeopleLabel.snp.makeConstraints { make in
            make.trailing.equalTo(bottomView.snp.trailing).offset(-20)
            make.centerY.equalTo(makerNickname.snp.centerY)
        }
    }
}

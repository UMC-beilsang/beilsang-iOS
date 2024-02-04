//
//  HofChallengeCollectionViewCell.swift
//  beilsang
//
//  Created by 강희진 on 2/4/24.
//

import UIKit

class HofChallengeCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "hofChallengeCollectionViewCell"
    // 챌린지 버튼 - 버튼
    let custombutton: UIButton = {
        let view = UIButton()
        
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.beBgDiv.cgColor
        
        return view
    }()
    
    // 챌린지 버튼 - 이미지
    let challengeImage: UIImageView = {
        let view = UIImageView()
        
        view.image = UIImage(named: "testChallengeImage")
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        return view
    }()
    
    // 챌린지 버튼 - 제목
    let challengeNameLabel: UILabel = {
        let view = UILabel()
        
        view.text = "다회용기 픽업하기"
        view.textColor = .beTextWhite
        view.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        
        return view
    }()
    
    // 챌린지 버튼 - 하단 뷰
    let bottomView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .beBgSub
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        return view
    }()
    
    // 챌린지 버튼 - 레이블
    let buttonLabel: UILabel = {
        let view = UILabel()
        
        view.text = "달성률 \(Int.random(in: 0...100))%"
        view.textColor = .beNavy500
        view.font = UIFont(name: "Noto Sans KR", size: 12)
        
        return view
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
extension HofChallengeCollectionViewCell {
    func setLayout() {
        self.addSubview(custombutton)
        custombutton.addSubview(challengeImage)
        custombutton.addSubview(bottomView)
        
        challengeImage.addSubview(challengeNameLabel)
        bottomView.addSubview(buttonLabel)
        
        custombutton.snp.makeConstraints { make in
            make.size.edges.equalToSuperview()
        }
        
        challengeImage.snp.makeConstraints { make in
            make.top.equalTo(custombutton.snp.top)
            make.leading.equalTo(custombutton.snp.leading)
            make.trailing.equalTo(custombutton.snp.trailing)
            make.height.equalTo(120)
        }
        
        challengeNameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(bottomView.snp.top).offset(-8)
            make.leading.equalTo(custombutton.snp.leading).offset(16)
            make.height.equalTo(20)
        }
        
        bottomView.snp.makeConstraints { make in
            make.bottom.equalTo(custombutton.snp.bottom)
            make.height.equalTo(40)
            make.width.equalTo(custombutton.snp.width)
        }
        
        buttonLabel.snp.makeConstraints { make in
            make.trailing.equalTo(bottomView.snp.trailing).offset(-10)
            make.centerY.equalTo(bottomView.snp.centerY)
        }
    }
}

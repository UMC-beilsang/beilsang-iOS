//
//  MainAfterCollectionViewCell.swift
//  beilsang
//
//  Created by 곽은채 on 2/13/24.
//

import UIKit

class MainAfterCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MainAfterCell"
    
    var challengeId : Int? = nil
    
    // 챌린지 버튼 - 버튼
    let custombutton: UIView = {
        let view = UIView()
        
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.beBgDiv.cgColor
        
        return view
    }()
    
    // 챌린지 버튼 - 이미지
    var challengeImage: UIImageView = {
        let view = UIImageView()
        
        view.image = UIImage(named: "testChallengeImage")
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        return view
    }()
    
    // 챌린지 버튼 - 제목
    var challengeNameLabel: UILabel = {
        let view = UILabel()
        
        view.textColor = .beTextWhite
        view.font = UIFont(name: "NotoSansKR-SemiBold", size: 14)
        
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
    var buttonLabel: UILabel = {
        let view = UILabel()
        
        view.textColor = .beNavy500
        view.font = UIFont(name: "NotoSansKR-Medium", size: 12)
        
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

extension MainAfterCollectionViewCell {
    func setLayout() {
        addSubview(custombutton)
        
        custombutton.addSubview(challengeImage)
        custombutton.addSubview(bottomView)
        
        challengeImage.addSubview(challengeNameLabel)
        bottomView.addSubview(buttonLabel)
        
        custombutton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        challengeImage.snp.makeConstraints { make in
            make.top.equalTo(custombutton.snp.top)
            make.leading.equalTo(custombutton.snp.leading)
            make.trailing.equalTo(custombutton.snp.trailing)
            make.height.equalTo(100)
        }
        
        challengeNameLabel.snp.makeConstraints { make in
            make.top.equalTo(custombutton.snp.top).offset(72)
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

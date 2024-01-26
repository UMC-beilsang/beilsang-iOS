//
//  MainAfterViewController.swift
//  beilsang
//
//  Created by 곽은채 on 1/26/24.
//

import SnapKit
import UIKit

// [홈] 메인화면
// 카테고리 하단의 서비스 이용 후 화면(참여 중인 챌린지, 앤님을 위해 준비한 챌린지)
class MainAfterViewController: UIViewController {
    
    // MARK: - properties
    // "참여 중인 챌린지" 레이블
    lazy var participatingChallenge: UILabel = {
        let view = UILabel()
        
        view.text = "참여 중인 챌린지💪"
        view.textAlignment = .left
        view.textColor = .beTextDef
        view.font = UIFont(name: "NotoSansKR-Medium", size: 18)
        
        return view
    }()
    
    // "전체 보기" 버튼
    lazy var viewAllButton: UIButton = {
        let view = UIButton()
        
        view.backgroundColor = .beBgSub
        view.setTitle("전체 보기", for: .normal)
        view.setTitleColor(.beNavy500, for: .normal)
        view.titleLabel?.font = UIFont(name: "Noto Sans KR", size: 12)
        view.contentHorizontalAlignment = .center
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    // 챌린지 버튼
    let achivement = Int.random(in: 0...100)
    // 챌린지 버튼 - 왼쪽
    lazy var challengeButtonLeft = customChallengeButton(labelText: "달성률 \(achivement)%")
    // 챌린지 버튼 - 오른쪽
    lazy var challengeButtonRight = customChallengeButton(labelText: "달성률 \(achivement)%")
    
    // oo님을 위해 준비한 챌린지 - oo
    var username = "앤"
    // oo님을 위해 준비한 챌린지 - 레이블
    lazy var readyChallenge: UILabel = {
        let view = UILabel()
        
        view.text = "\(username)님을 위해 준비한 챌린지✨"
        view.textAlignment = .left
        view.textColor = .beTextDef
        view.font = UIFont(name: "NotoSansKR-Medium", size: 18)
        
        return view
    }()
    
    // oo님을 위해 준비한 챌린지 - 챌린지 버튼
    let numOfPeople = Int.random(in: 0...200)
    // oo님을 위해 준비한 챌린지 - 챌린지 버튼 왼쪽
    lazy var readyButtonLeft = customChallengeButton(labelText: "참여인원 \(numOfPeople)명")
    // oo님을 위해 준비한 챌린지 - 챌린지 버튼 오른쪽
    lazy var readyButtonRight = customChallengeButton(labelText: "참여인원 \(numOfPeople)명")
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
    }
}

// MARK: - Layout setting
extension MainAfterViewController {
    
    func setLayout() {
        view.addSubview(participatingChallenge)
        view.addSubview(viewAllButton)
        view.addSubview(challengeButtonLeft)
        view.addSubview(challengeButtonRight)
        view.addSubview(readyChallenge)
        view.addSubview(readyButtonLeft)
        view.addSubview(readyButtonRight)
        
        participatingChallenge.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(24)
            make.leading.equalTo(view.snp.leading).offset(16)
        }
        
        viewAllButton.snp.makeConstraints { make in
            make.centerY.equalTo(participatingChallenge.snp.centerY)
            make.trailing.equalTo(view.snp.trailing).offset(-16)
            make.width.equalTo(70)
            make.height.equalTo(21)
        }
        
        let width = (UIScreen.main.bounds.width - 44) * 1 / 2
        
        challengeButtonLeft.snp.makeConstraints { make in
            make.top.equalTo(participatingChallenge.snp.bottom).offset(14)
            make.leading.equalTo(view.snp.leading).offset(16)
            make.width.equalTo(width)
            make.height.equalTo(140)
        }
        
        challengeButtonRight.snp.makeConstraints { make in
            make.centerY.equalTo(challengeButtonLeft.snp.centerY)
            make.leading.equalTo(challengeButtonLeft.snp.trailing).offset(12)
            make.width.equalTo(width)
            make.height.equalTo(140)
        }
        
        readyChallenge.snp.makeConstraints { make in
            make.top.equalTo(challengeButtonLeft.snp.bottom).offset(28)
            make.leading.equalTo(view.snp.leading).offset(16)
        }
        
        readyButtonLeft.snp.makeConstraints { make in
            make.top.equalTo(readyChallenge.snp.bottom).offset(14)
            make.leading.equalTo(view.snp.leading).offset(16)
            make.width.equalTo(width)
            make.height.equalTo(140)
        }
        
        readyButtonRight.snp.makeConstraints { make in
            make.centerY.equalTo(readyButtonLeft.snp.centerY)
            make.leading.equalTo(readyButtonLeft.snp.trailing).offset(12)
            make.width.equalTo(width)
            make.height.equalTo(140)
        }
    }
}

// MARK: - 챌린지 버튼을 커스텀 함수
extension MainAfterViewController {
    func customChallengeButton(labelText: String) -> UIButton {
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
        let challengeName = "다회용기 픽업하기"
        let challengeNameLabel: UILabel = {
            let view = UILabel()
            
            view.text = challengeName
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
            
            view.text = labelText
            view.textColor = .beNavy500
            view.font = UIFont(name: "Noto Sans KR", size: 12)
            
            return view
        }()
        
        custombutton.addSubview(challengeImage)
        custombutton.addSubview(bottomView)
        
        challengeImage.addSubview(challengeNameLabel)
        bottomView.addSubview(buttonLabel)
        
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
        
        return custombutton
    }
}

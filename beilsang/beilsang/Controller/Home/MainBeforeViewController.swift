//
//  MainBeforeViewController.swift
//  beilsang
//
//  Created by 곽은채 on 1/26/24.
//

import SnapKit
import UIKit

// [홈] 메인화면
// 카테고리 하단의 서비스 이용 전 화면(챌린지 참여하러 가기)
class MainBeforeViewController: UIViewController {
    
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
    
    // "참여중인 챌린지가 없어요" 레이블
    lazy var notParticipating: UILabel = {
        let view = UILabel()
        
        view.text = "아직 참여중인 챌린지가 없어요👀"
        view.textAlignment = .center
        view.textColor = .beTextInfo
        view.font = UIFont(name: "Noto Sans KR", size: 12)
        
        return view
    }()
    
    // 챌린지 참여 버튼
    lazy var participateChallengeButton: UIButton = {
        let view = UIButton()
        
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.beBgDiv.cgColor
        view.setTitle("챌린지 참여하러 가기", for: .normal)
        view.setTitleColor(.beTextDef, for: .normal)
        view.titleLabel?.font = UIFont(name: "Noto Sans KR", size: 14)
        view.contentHorizontalAlignment = .center
        view.layer.cornerRadius = 20
        
        return view
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
    }
}

// MARK: - Layout setting
extension MainBeforeViewController {
    
    func setLayout() {
        view.addSubview(participatingChallenge)
        view.addSubview(viewAllButton)
        view.addSubview(notParticipating)
        view.addSubview(participateChallengeButton)
        
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
        
        notParticipating.snp.makeConstraints { make in
            make.top.equalTo(participatingChallenge.snp.bottom).offset(48)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        participateChallengeButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(notParticipating.snp.bottom).offset(12)
            make.width.equalTo(240)
            make.height.equalTo(40)
        }
    }
}

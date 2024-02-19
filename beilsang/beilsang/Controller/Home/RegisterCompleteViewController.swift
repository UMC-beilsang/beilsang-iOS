//
//  RegisterCompleteViewController.swift
//  beilsang
//
//  Created by 곽은채 on 1/29/24.
//

import SnapKit
import UIKit

// [홈] 챌린지 등록 후 화면
class RegisterCompleteViewController: UIViewController {
    
    // MARK: - properties
    // 로고 이미지
    lazy var challengeImage: UIImageView = {
        let view = UIImageView()
        
        view.image = UIImage(named: "registerComplete")
        view.contentMode = .scaleAspectFill
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 4.0
        view.clipsToBounds = false
        
        return view
    }()
    
    // 챌린지 등록 완료 레이블
    lazy var registerCompleteLabel: UILabel = {
        let view = UILabel()
        
        view.text = "챌린지가 등록됐어요🙌\n같이 확인하러 가요!"
        view.numberOfLines = 2
        view.textAlignment = .center
        view.textColor = .beTextDef
        view.font = UIFont(name: "NotoSansKR-Medium", size: 20)
        
        return view
    }()
    
    // 홈으로 버튼
    lazy var toHomeButton: UIButton = {
        let view = UIButton()
        
        view.backgroundColor = .beBgDiv
        view.setTitle("홈으로", for: .normal)
        view.setTitleColor(.beTextEx, for: .normal)
        view.titleLabel?.font = UIFont(name: "Noto Sans KR", size: 16)
        view.contentHorizontalAlignment = .center
        view.contentVerticalAlignment = .center
        view.layer.cornerRadius = 10
        view.addTarget(self, action: #selector(toHomeButtonClicked), for: .touchUpInside)
        
        return view
    }()
    
    // 게시물 확인하기 버튼
    lazy var toDetailButton: UIButton = {
        let view = UIButton()
        
        view.backgroundColor = .beScPurple600
        view.setTitle("게시물 확인하기", for: .normal)
        view.setTitleColor(.beTextWhite, for: .normal)
        view.titleLabel?.font = UIFont(name: "Noto Sans KR", size: 16)
        view.contentHorizontalAlignment = .center
        view.contentVerticalAlignment = .center
        view.layer.cornerRadius = 10
        view.addTarget(self, action: #selector(toDetailButtonClicked), for: .touchUpInside)
        
        return view
    }()
    
    var challengeId : Int? = nil

    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setLayout()
    }
    
    // MARK: - actions
    // 게시물 확인하기 버튼이 눌렸을 때 - 챌린지 세부화면(DetailVC)으로 이동
    @objc func toDetailButtonClicked() {
        print("게시물 확인하기")
        let nextVC = JoinChallengeViewController()
        nextVC.challengeId = challengeId
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    // 홈으로 버튼이 눌렸을 때 - 홈(HomeMainVC)으로 이동
    @objc func toHomeButtonClicked() {
        print("홈으로")
        let homeVC = HomeMainViewController()
        navigationController?.pushViewController(homeVC, animated: true)
    }
}

// MARK: - layout setting
extension RegisterCompleteViewController {
    func setLayout() {
        view.addSubview(challengeImage)
        view.addSubview(registerCompleteLabel)
        view.addSubview(toHomeButton)
        view.addSubview(toDetailButton)
        
        challengeImage.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(220)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(260)
        }
        
        registerCompleteLabel.snp.makeConstraints { make in
            make.top.equalTo(challengeImage.snp.bottom).offset(24)
            make.centerX.equalTo(challengeImage.snp.centerX)
        }
        
        let homeWidth = (UIScreen.main.bounds.width - 44) / 3
        toHomeButton.snp.makeConstraints { make in
            make.top.equalTo(registerCompleteLabel.snp.bottom).offset(126)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(56)
            make.width.equalTo(homeWidth)
        }
        
        let detailWidth = (UIScreen.main.bounds.width - 44) / 3 * 2
        toDetailButton.snp.makeConstraints { make in
            make.top.equalTo(toHomeButton.snp.top)
            make.leading.equalTo(toHomeButton.snp.trailing).offset(12)
            make.height.equalTo(56)
            make.width.equalTo(detailWidth)
        }
    }
}

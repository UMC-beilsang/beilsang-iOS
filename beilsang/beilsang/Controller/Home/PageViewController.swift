//
//  PageViewController.swift
//  beilsang
//
//  Created by 곽은채 on 1/26/24.
//

import SnapKit
import UIKit

// [홈] 메인화면
// 제일 위 로고 밑의 내용, pageViewController 이용 위해 새로운 VC로 작성
class PageViewController: UIViewController {
    
    // MARK: - properties
    let pageTitle: String
    let pageColor: UIColor
    
    // 전체 화면 꽉 차는 버튼, 클릭시 해당 서비스로 이동
    lazy var button: UIButton = {
        let view = UIButton()
        
        view.backgroundColor = pageColor
        
        view.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        return view
    }()
    
    // 해당 서비스 안내 레이블
    lazy var label: UILabel = {
        let view = UILabel()
        
        view.text = pageTitle
        view.numberOfLines = 2
        view.font = UIFont(name: "NotoSansKR-Medium", size: 20)
        view.textColor = .beTextDef
        
        return view
    }()
    
    // MARK: - init setting
    init(pageTitle: String, pageColor: UIColor) {
        self.pageTitle = pageTitle
        self.pageColor = pageColor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        print("\(pageTitle) 선택")
        
        switch pageTitle {
        case "나만의 챌린지\n바로 만들어 보기!":
            let labelText = "전체"
            let challengeListVC = ChallengeListViewController()
            challengeListVC.categoryLabelText = labelText
            navigationController?.pushViewController(challengeListVC, animated: true)
        case "챌린저들과\n친환경 챌린지 참여하기!":
            print("page 2")
        case "내 주변 친환경 스팟\n어디 있을까?":
            print("page 3")
        default:
            break
        }
    }
}

// MARK: - Layout setting
extension PageViewController {
    func setLayout() {
        view.addSubview(button)
        view.addSubview(label)
        
        button.snp.makeConstraints { make in
            make.width.equalTo(view.snp.width)
            make.height.equalTo(view.snp.height)
        }
        label.snp.makeConstraints { make in
            make.leading.equalTo(button.snp.leading).offset(24)
            make.top.equalTo(button.snp.top).offset(32)
        }
    }
}

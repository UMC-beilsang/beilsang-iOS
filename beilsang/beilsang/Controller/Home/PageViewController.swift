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
    let pageImage: UIImage
    
    // 전체 화면 꽉 차는 버튼, 클릭시 해당 서비스로 이동
    lazy var button: UIButton = {
        let view = UIButton()
        
        view.setImage(pageImage, for: .normal)
        view.imageView?.contentMode = .scaleAspectFill
        
        view.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        return view
    }()
    
    // MARK: - init setting
    init(pageTitle: String, pageImage: UIImage) {
        self.pageTitle = pageTitle
        self.pageImage = pageImage
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
            let registerChallengeVC = RegisterFirstViewController()
            registerChallengeVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(registerChallengeVC, animated: true)
        case "챌린저들과\n친환경 챌린지 참여하기!":
            let labelText = "전체"
            let challengeListVC = ChallengeListViewController()
            challengeListVC.categoryLabelText = labelText
            challengeListVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(challengeListVC, animated: true)
        case "비일상 챌린지\n참여방법 알아보기!":
            let challengeTipVC = ChallengeTipViewController()
            navigationController?.pushViewController(challengeTipVC, animated: true)
        default:
            break
        }
    }
}

// MARK: - Layout setting
extension PageViewController {
    func setLayout() {
        view.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.width.equalTo(view.snp.width)
            make.height.equalTo(view.snp.height)
        }
    }
}

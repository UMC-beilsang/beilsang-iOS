//
//  ChallengeHowToViewController.swift
//  beilsang
//
//  Created by 곽은채 on 2/13/24.
//

import SnapKit
import UIKit

// [홈] 챌린지 방법 - 메인화면 세번째 배너 클릭하면 나오는 화면
class ChallengeTipViewController: UIViewController {
    // MARK: - properties
    // 네비게이션 바 - 네비게이션 버튼
    lazy var navigationButton: UIBarButtonItem = {
        let view = UIBarButtonItem(image: UIImage(named: "icon-navigation"), style: .plain, target: self, action: #selector(navigationButtonClicked))
        view.tintColor = .beIconDef
        
        return view
    }()
    
    // 네비게이션 바 - 레이블
    lazy var challengeTipLabel: UILabel = {
        let view = UILabel()
        
        view.text = "챌린지 팁"
        view.font = UIFont(name: "NotoSansKR-Medium", size: 20)
        view.textColor = .beTextDef
        view.textAlignment = .center
        
        return view
    }()
    
    // border
    lazy var topViewBorder: UIView = {
        let view = UIView()
        
        view.backgroundColor = .beBorderDis
        
        return view
    }()
    
    // 챌린지 팁 제목
    lazy var challengeTipTitle: UILabel = {
        let view = UILabel()
        
        view.text = "비일상 챌린지는\n이렇게 진행돼요"
        view.numberOfLines = 2
        view.font = UIFont(name: "NotoSansKR-SemiBold", size: 20)
        view.textColor = .beTextDef
        view.textAlignment = .left
        
        return view
    }()
    
    // 만들기 버튼 활성화를 위한 변수
    var isAgree = [false, false, false, false]
    
    // 챌린지 유의사항 체크 버튼
    var agreeButtons = [UIButton]()
    
    lazy var agree1Button: UIButton = {
        let view = UIButton()
        
        view.setImage(UIImage(named: "agree-before"), for: .normal)
        view.tag = 0
        view.addTarget(self, action: #selector(agreeButtonClicked(_:)), for: .touchUpInside)
        
        return view
    }()
    
    lazy var agree2Button: UIButton = {
        let view = UIButton()
        
        view.setImage(UIImage(named: "agree-before"), for: .normal)
        view.tag = 1
        view.addTarget(self, action: #selector(agreeButtonClicked(_:)), for: .touchUpInside)
        
        return view
    }()
    
    lazy var agree3Button: UIButton = {
        let view = UIButton()
        
        view.setImage(UIImage(named: "agree-before"), for: .normal)
        view.tag = 2
        view.addTarget(self, action: #selector(agreeButtonClicked(_:)), for: .touchUpInside)
        
        return view
    }()
    
    lazy var agree4Button: UIButton = {
        let view = UIButton()
        
        view.setImage(UIImage(named: "agree-before"), for: .normal)
        view.tag = 3
        view.addTarget(self, action: #selector(agreeButtonClicked(_:)), for: .touchUpInside)
        
        return view
    }()
    
    // 챌린지 유의사항 체크 레이블
    lazy var agree1Label: UILabel = {
        let view = UILabel()
        
        view.text = "챌린지를 원하는 카테고리를 선택해요."
        view.textColor = .beTextDef
        view.textAlignment = .left
        view.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        view.tag = 0
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(agreeButtonClicked))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGesture)
        
        return view
    }()
    
    lazy var agree2Label: UILabel = {
        let view = UILabel()
        
        view.text = "해당 카테고리에 개설되어 있는 챌린지들을 확\n인해봐요."
        view.textColor = .beTextDef
        view.textAlignment = .left
        view.numberOfLines = 2
        view.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        view.tag = 1
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(agreeButtonClicked))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGesture)
        
        return view
    }()
    
    lazy var agree3Label: UILabel = {
        let view = UILabel()
        
        view.text = "관심있는 챌린지가 있을 경우 일정 포인트를 지\n불하고 챌린지에 참여해요!"
        view.textColor = .beTextDef
        view.textAlignment = .left
        view.numberOfLines = 2
        view.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        view.tag = 2
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(agreeButtonClicked))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGesture)
        
        return view
    }()
    
    lazy var agree4Label: UILabel = {
        let view = UILabel()
        
        view.text = "직접 챌린지를 개설하고 싶다면 챌린지 만들기\n를 통해 새로운 챌린지를 시작해요 :)"
        view.textColor = .beTextDef
        view.textAlignment = .left
        view.numberOfLines = 2
        view.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        view.tag = 3
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(agreeButtonClicked))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGesture)
        
        return view
    }()
    
    // 챌린지 만들러 가기 버튼
    lazy var toChallengeButton: UIButton = {
        let view = UIButton()
        
        view.backgroundColor = .beScPurple400
        view.setTitle("챌린지 만들러 가기", for: .normal)
        view.setTitleColor(.beTextWhite, for: .normal)
        view.titleLabel?.font = UIFont(name: "Noto Sans KR", size: 16)
        view.contentHorizontalAlignment = .center
        view.contentVerticalAlignment = .center
        view.layer.cornerRadius = 10
        view.addTarget(self, action: #selector(toChallengeButtonClicked), for: .touchUpInside)
        
        return view
    }()
    
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupAttribute()
    }
    
    // MARK: - actions
    // 네비게이션 아이템 누르면 alert 띄움
    @objc func navigationButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func agreeButtonClicked(_ sender: Any?) {
        var index = 0
        if let button = sender as? UIButton {
            index = button.tag
            isAgree[index] = !isAgree[index]
        } else if let gesture = sender as? UITapGestureRecognizer {
            index = gesture.view!.tag
            isAgree[index] = !isAgree[index]
        }
        
        let agreeButton = agreeButtons[index]
        if isAgree[index] {
            agreeButton.setImage(UIImage(named: "agree-after"), for: .normal)
        } else {
            agreeButton.setImage(UIImage(named: "agree-before"), for: .normal)
        }
        
        updateMakeButtonState()
    }
    
    func updateMakeButtonState() {
        if isAgree.allSatisfy({ $0 }) {
            toChallengeButton.backgroundColor = .beScPurple600
            toChallengeButton.isEnabled = true
        } else {
            toChallengeButton.isEnabled = false
            toChallengeButton.backgroundColor = .beScPurple400
        }
    }
    
    // 챌린지 만들러 가기 버튼이 눌렸을 때 - 챌린지 등록하기(RegisterFirst)으로 이동
    @objc func toChallengeButtonClicked() {
        print("챌린지 만들러 가기")
        let registerVC = RegisterFirstViewController()
        navigationController?.pushViewController(registerVC, animated: true)
    }
}

// MARK: - layout setting
extension ChallengeTipViewController {
    func setupAttribute() {
        setAddViews()
        setLayout()
        setNavigationBar()
        setUI()
    }
    
    func setNavigationBar() {
        navigationItem.titleView = challengeTipLabel
        navigationItem.leftBarButtonItem = navigationButton
    }
    
    func setUI() {
        [agree1Button, agree2Button, agree3Button, agree4Button].forEach { button in
            agreeButtons.append(button)
        }
    }
    
    func setAddViews() {
        [topViewBorder, challengeTipTitle, agree1Button, agree1Label, agree2Button, agree2Label, agree3Button, agree3Label, agree4Button, agree4Label, toChallengeButton].forEach { view in
            self.view.addSubview(view)
        }
    }
    
    func setLayout() {
        topViewBorder.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.width.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        challengeTipTitle.snp.makeConstraints { make in
            make.top.equalTo(topViewBorder.snp.bottom).offset(32)
            make.leading.equalTo(view.snp.leading).offset(16)
        }
        
        agree1Button.snp.makeConstraints { make in
            make.top.equalTo(challengeTipTitle.snp.bottom).offset(24)
            make.leading.equalTo(view.snp.leading).offset(24)
            make.width.height.equalTo(28)
        }
        
        agree1Label.snp.makeConstraints { make in
            make.centerY.equalTo(agree1Button.snp.centerY)
            make.leading.equalTo(agree1Button.snp.trailing).offset(12)
        }
        
        agree2Button.snp.makeConstraints { make in
            make.top.equalTo(agree1Label.snp.bottom).offset(24)
            make.leading.equalTo(view.snp.leading).offset(24)
            make.width.height.equalTo(28)
        }
        
        agree2Label.snp.makeConstraints { make in
            make.top.equalTo(agree2Button.snp.top)
            make.leading.equalTo(agree2Button.snp.trailing).offset(12)
        }
        
        agree3Button.snp.makeConstraints { make in
            make.top.equalTo(agree2Label.snp.bottom).offset(24)
            make.leading.equalTo(view.snp.leading).offset(24)
            make.width.height.equalTo(28)
        }
        
        agree3Label.snp.makeConstraints { make in
            make.top.equalTo(agree3Button.snp.top)
            make.leading.equalTo(agree3Button.snp.trailing).offset(12)
        }
        
        agree4Button.snp.makeConstraints { make in
            make.top.equalTo(agree3Label.snp.bottom).offset(24)
            make.leading.equalTo(view.snp.leading).offset(24)
            make.width.height.equalTo(28)
        }
        
        agree4Label.snp.makeConstraints { make in
            make.top.equalTo(agree4Button.snp.top)
            make.leading.equalTo(agree3Button.snp.trailing).offset(12)
        }
        
        toChallengeButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).offset(-100)
            make.leading.equalTo(view.snp.leading).offset(16)
            make.trailing.equalTo(view.snp.trailing).offset(-16)
            make.height.equalTo(56)
        }
    }
}

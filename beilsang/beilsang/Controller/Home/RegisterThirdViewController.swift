//
//  RegisterThirdViewController.swift
//  beilsang
//
//  Created by 곽은채 on 2/1/24.
//

import SCLAlertView
import SnapKit
import UIKit

// [홈] 챌린지 등록하기
// 한 페이지에서 세 페이지로 나눠짐에 따라 생성된 VC
class RegisterThirdViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - properties
    // 전체 화면 scrollview
    let fullScrollView = UIScrollView()
    let fullContentView = UIView()
    
    // 네비게이션 바 - 네비게이션 버튼
    lazy var navigationButton: UIBarButtonItem = {
        let view = UIBarButtonItem(image: UIImage(named: "icon-navigation"), style: .plain, target: self, action: #selector(navigationButtonClicked))
        view.tintColor = .beIconDef
        
        return view
    }()
    
    // 네비게이션 바 - 레이블
    lazy var makeChallengeLabel: UILabel = {
        let view = UILabel()
        
        view.text = "챌린지 만들기"
        view.font = UIFont(name: "NotoSansKR-Medium", size: 20)
        view.textColor = .beTextDef
        view.textAlignment = .center
        
        return view
    }()
    
    // 챌린지 만들기 취소 팝업창
    var cancleAlertViewResponder: SCLAlertViewResponder? = nil
    
    lazy var cancleAlert: SCLAlertView = {
        let apperance = SCLAlertView.SCLAppearance(
            kWindowWidth: 342, kWindowHeight : 184,
            kTitleFont: UIFont(name: "NotoSansKR-SemiBold", size: 18)!,
            showCloseButton: false,
            showCircularIcon: false,
            dynamicAnimatorActive: false
        )
        let alert = SCLAlertView(appearance: apperance)
        
        return alert
    }()
    
    lazy var cancleSubview: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var cancleSubTitle: UILabel = {
        let view = UILabel()
        
        view.text = "챌린지 화면으로 돌아갈까요?\n현재 창을 나가면 작성된 내용은 저장되지 않아요 👀"
        view.textColor = .beTextInfo
        view.textAlignment = .center
        view.numberOfLines = 2
        view.font = UIFont(name: "NotoSansKR-Regular", size: 12)
        
        return view
    }()
    
    lazy var cancleButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .beBgSub
        button.setTitleColor(.beTextEx, for: .normal)
        button.setTitle("나가기", for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(cancleAlartClose), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        return button
    }()
    
    lazy var continueButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .beScPurple600
        button.setTitleColor(.beTextWhite, for: .normal)
        button.setTitle("계속 작성하기", for: .normal)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        button.addTarget(self, action: #selector(continueButtonClicked), for: .touchUpInside)
        return button
    }()
    
    // border
    lazy var topViewBorder: UIView = {
        let view = UIView()
        
        view.backgroundColor = .beBorderDis
        
        return view
    }()
    
    // 유의사항 제목
    lazy var noticeTitle: UILabel = {
        let view = UILabel()
        
        view.text = "잠깐! 마지막으로\n아래 유의사항을 체크해 주세요!"
        view.numberOfLines = 2
        view.font = UIFont(name: "NotoSansKR-SemiBold", size: 20)
        view.textColor = .beTextDef
        view.textAlignment = .left
        
        return view
    }()
    
    // 만들기 버튼 활성화를 위한 변수
    var isAgree = [false, false, false, false, false]
    
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
    
    lazy var agree5Button: UIButton = {
        let view = UIButton()
        
        view.setImage(UIImage(named: "agree-before"), for: .normal)
        view.tag = 4
        view.addTarget(self, action: #selector(agreeButtonClicked(_:)), for: .touchUpInside)
        
        return view
    }()

    // 챌린지 유의사항 체크 레이블
    lazy var agree1Label: UILabel = {
        let view = UILabel()
        
        view.text = "카테고리에 알맞는 챌린지를 작성해 주셨나요?"
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
        
        view.text = "챌린지 참여 및 인증과 관련하여 유의사항을 자세\n히 명시하셨나요?"
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
        
        view.text = "챌린지는 등록 후 삭제와 수정이 불가능합니다."
        view.textColor = .beTextDef
        view.textAlignment = .left
        view.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        view.tag = 2
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(agreeButtonClicked))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGesture)
        
        return view
    }()
    
    lazy var agree4Label: UILabel = {
        let view = UILabel()
        
        view.text = "등록한 챌린지 참여자들의 인증 확인에 대한 책임\n은 챌린지 등록자에게 있습니다."
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
    
    lazy var agree5Label: UILabel = {
        let view = UILabel()
        
        view.text = "챌린지를 등록하면 자동으로 해당 챌린지에 참여\n하게 됩니다."
        view.textColor = .beTextDef
        view.textAlignment = .left
        view.numberOfLines = 2
        view.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        view.tag = 4
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(agreeButtonClicked))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGesture)
        
        return view
    }()
    
    // 하단 네비게이션 전체 뷰
    lazy var bottomView: UIView = {
        let view = UIView()
        
        view.layer.shadowColor = UIColor.beTextDef.cgColor
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: 4, height: 4)
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 1
        view.backgroundColor = .beBgSub
        
        return view
    }()
    
    // 이전 버튼
    lazy var beforeButton: UIButton = {
        let view = UIButton()
        
        view.setTitle("이전", for: .normal)
        view.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        view.setTitleColor(.beTextEx, for: .normal)
        view.backgroundColor = .clear
        view.addTarget(self, action: #selector(beforeButtonClicked), for: .touchUpInside)
        
        return view
    }()
    
    // 만들기 버튼
    lazy var makeButton: UIButton = {
        let view = UIButton(type: .system)
        
        view.setTitle("만들기", for: .normal)
        view.titleLabel?.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        view.setTitleColor(.beTextWhite, for: .normal)
        view.backgroundColor = .beScPurple400
        view.layer.cornerRadius = 10
        view.addTarget(self, action: #selector(makeButtonClicked), for: .touchUpInside)
        view.isEnabled = false
        
        return view
    }()
    
    // 챌린지 등록하기 팝업창
    var registerAlertViewResponder: SCLAlertViewResponder? = nil
    
    lazy var registerAlert: SCLAlertView = {
        let apperance = SCLAlertView.SCLAppearance(
            kWindowWidth: 342, kWindowHeight : 184,
            kTitleFont: UIFont(name: "NotoSansKR-SemiBold", size: 18)!,
            showCloseButton: false,
            showCircularIcon: false,
            dynamicAnimatorActive: false
        )
        let alert = SCLAlertView(appearance: apperance)
        
        return alert
    }()
    
    lazy var registerSubview: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var registerSubTitle: UILabel = {
        let view = UILabel()
        
        view.text = "챌린지 작성이 끝나셨나요?\n한 번 등록한 챌린지는 수정 및 삭제가 불가능해요 👀"
        view.textColor = .beTextInfo
        view.textAlignment = .center
        view.numberOfLines = 2
        view.font = UIFont(name: "NotoSansKR-Regular", size: 12)
        
        return view
    }()
    
    lazy var registerCancelButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .beBgSub
        button.setTitleColor(.beTextEx, for: .normal)
        button.setTitle("취소", for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(registerAlartClose), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        return button
    }()
    
    lazy var registerActiveButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .beScPurple600
        button.setTitleColor(.beTextWhite, for: .normal)
        button.setTitle("챌린지 등록하기", for: .normal)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        button.addTarget(self, action: #selector(addChallengeButtonClicked), for: .touchUpInside)
        return button
    }()
    
    var challengePostData : ChallengePostData? = nil
    
    var registerChallengeId : Int? = nil
    
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupAttribute()
    }
    
    // MARK: - actions
    // 네비게이션 아이템 누르면 alert 띄움
    @objc func navigationButtonClicked() {
        print("챌린지 작성 취소")
        cancleAlertViewResponder = cancleAlert.showInfo("챌린지 만들기 취소")
    }
    
    // 알림창 나가기 버튼에 action 연결해서 alert 닫음
    @objc func cancleAlartClose(){
        let labelText = "전체"
        let challengeListVC = ChallengeListViewController()
        challengeListVC.categoryLabelText = labelText
        navigationController?.pushViewController(challengeListVC, animated: true)
        
        ChallengeDataSingleton.shared.resetData()
        cancleAlertViewResponder?.close()
    }
    
    // 챌린지 등록하기 알림창 - 챌린지 등록하기 버튼 클릭
    @objc func continueButtonClicked(){
        print("계속 작성하기")

        cancleAlertViewResponder?.close()
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
            makeButton.backgroundColor = .beScPurple600
            makeButton.isEnabled = true
        } else {
            makeButton.isEnabled = false
            makeButton.backgroundColor = .beScPurple400
        }
    }
    
    @objc func beforeButtonClicked() {
        print("이전")
        
        let beforeVC = RegisterSecondViewController()
        navigationController?.pushViewController(beforeVC, animated: true)
    }
    
    // alert 띄움
    @objc func makeButtonClicked() {
        print("만들기")
        registerAlertViewResponder = registerAlert.showInfo("챌린지 등록하기")
    }
    
    // 알림창 나가기 버튼에 action 연결해서 alert 닫음
    @objc func registerAlartClose(){
        registerAlertViewResponder?.close()
    }
    
    // 챌린지 등록하기 알림창 - 챌린지 등록하기 버튼 클릭
    @objc func addChallengeButtonClicked(){
        print("챌린지 등록하기")
        
        postChallenges()
        
        ChallengeDataSingleton.shared.resetData()
        registerAlertViewResponder?.close()
    }
}

// MARK: - network
extension RegisterThirdViewController {
    func postChallenges() {
        ChallengeService.shared.challengePost() { response in
            self.challengePostData = response.data
            print(response)
            self.registerChallengeId = response.data.challengeId
            
            let registerCompleteVC = RegisterCompleteViewController()
            registerCompleteVC.completeChallengeId = self.registerChallengeId
            self.navigationController?.pushViewController(registerCompleteVC, animated: true)
        }
    }
}

// MARK: - Layout setting
extension RegisterThirdViewController {
    func setupAttribute() {
        setFullScrollView()
        setAddViews()
        setLayout()
        setNavigationBar()
        setUI()
        setRegisterAlert()
        setCancleAlert()
    }
    
    func setFullScrollView() {
        fullScrollView.showsVerticalScrollIndicator = true
        fullScrollView.delegate = self
    }
    
    func setNavigationBar() {
        navigationItem.titleView = makeChallengeLabel
        navigationItem.leftBarButtonItem = navigationButton
    }
    
    func setUI() {
        [agree1Button, agree2Button, agree3Button, agree4Button, agree5Button].forEach { button in
            agreeButtons.append(button)
        }
    }
    
    func setAddViews() {
        view.addSubview(fullScrollView)
        view.addSubview(bottomView)
        
        fullScrollView.addSubview(fullContentView)
        
        [topViewBorder, noticeTitle, agree1Button, agree1Label, agree2Button, agree2Label, agree3Button, agree3Label, agree4Button, agree4Label, agree5Button, agree5Label].forEach { view in
            fullContentView.addSubview(view)
        }

        [beforeButton, makeButton].forEach { view in
            bottomView.addSubview(view)
        }
    }
    
    func setLayout() {
        fullScrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.width.equalToSuperview()
            make.bottom.equalTo(bottomView.snp.top)
        }
        
        fullContentView.snp.makeConstraints { make in
            make.edges.equalTo(fullScrollView.contentLayoutGuide)
            make.width.equalTo(fullScrollView.frameLayoutGuide)
            make.height.equalTo(670)
        }
        
        topViewBorder.snp.makeConstraints { make in
            make.top.equalTo(fullScrollView.snp.top)
            make.width.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        noticeTitle.snp.makeConstraints { make in
            make.top.equalTo(topViewBorder.snp.bottom).offset(32)
            make.leading.equalTo(fullScrollView.snp.leading).offset(16)
        }
        
        agree1Button.snp.makeConstraints { make in
            make.top.equalTo(noticeTitle.snp.bottom).offset(67)
            make.leading.equalTo(fullScrollView.snp.leading).offset(24)
            make.width.height.equalTo(28)
        }
        
        agree1Label.snp.makeConstraints { make in
            make.centerY.equalTo(agree1Button.snp.centerY)
            make.leading.equalTo(agree1Button.snp.trailing).offset(12)
        }
        
        agree2Button.snp.makeConstraints { make in
            make.top.equalTo(agree1Button.snp.bottom).offset(24)
            make.leading.equalTo(fullScrollView.snp.leading).offset(24)
            make.width.height.equalTo(28)
        }
        
        agree2Label.snp.makeConstraints { make in
            make.top.equalTo(agree2Button.snp.top)
            make.leading.equalTo(agree2Button.snp.trailing).offset(12)
        }
        
        agree3Button.snp.makeConstraints { make in
            make.top.equalTo(agree2Label.snp.bottom).offset(24)
            make.leading.equalTo(fullScrollView.snp.leading).offset(24)
            make.width.height.equalTo(28)
        }
        
        agree3Label.snp.makeConstraints { make in
            make.centerY.equalTo(agree3Button.snp.centerY)
            make.leading.equalTo(agree3Button.snp.trailing).offset(12)
        }
        
        agree4Button.snp.makeConstraints { make in
            make.top.equalTo(agree3Button.snp.bottom).offset(24)
            make.leading.equalTo(fullScrollView.snp.leading).offset(24)
            make.width.height.equalTo(28)
        }
        
        agree4Label.snp.makeConstraints { make in
            make.top.equalTo(agree4Button.snp.top)
            make.leading.equalTo(agree3Button.snp.trailing).offset(12)
        }
        
        agree5Button.snp.makeConstraints { make in
            make.top.equalTo(agree4Label.snp.bottom).offset(24)
            make.leading.equalTo(fullScrollView.snp.leading).offset(24)
            make.width.height.equalTo(28)
        }
        
        agree5Label.snp.makeConstraints { make in
            make.top.equalTo(agree5Button.snp.top)
            make.leading.equalTo(agree5Button.snp.trailing).offset(12)
        }
        
        bottomView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(80)
        }
        
        beforeButton.snp.makeConstraints { make in
            make.centerY.equalTo(bottomView.snp.centerY)
            make.leading.equalTo(bottomView.snp.leading).offset(38)
        }
        
        makeButton.snp.makeConstraints { make in
            make.centerY.equalTo(bottomView.snp.centerY)
            make.trailing.equalTo(bottomView.snp.trailing).offset(-32)
            make.height.equalTo(52)
            make.width.equalTo(160)
        }
    }
    
    func setCancleAlert() {
        cancleAlert.customSubview = cancleSubview
        [cancleSubTitle, cancleButton, continueButton].forEach{view in cancleSubview.addSubview(view)}
        
        cancleSubview.snp.makeConstraints { make in
            make.width.equalTo(316)
            make.bottom.equalTo(cancleButton).offset(12)
        }
        
        cancleSubTitle.snp.makeConstraints { make in
            make.top.equalTo(cancleSubview.snp.top)
            make.centerX.equalTo(cancleSubview.snp.centerX)
        }
        
        cancleButton.snp.makeConstraints { make in
            make.width.equalTo(156)
            make.height.equalTo(48)
            make.trailing.equalTo(cancleSubview.snp.centerX).offset(-3)
            make.top.equalTo(cancleSubTitle.snp.bottom).offset(28)
        }
        
        continueButton.snp.makeConstraints { make in
            make.width.equalTo(156)
            make.height.equalTo(48)
            make.leading.equalTo(cancleSubview.snp.centerX).offset(3)
            make.centerY.equalTo(cancleButton)
        }
    }
    
    func setRegisterAlert() {
        registerAlert.customSubview = registerSubview
        [registerSubTitle, registerCancelButton, registerActiveButton].forEach{view in registerSubview.addSubview(view)}
        
        registerSubview.snp.makeConstraints { make in
            make.width.equalTo(316)
            make.bottom.equalTo(registerCancelButton).offset(12)
        }
        
        registerSubTitle.snp.makeConstraints { make in
            make.top.equalTo(registerSubview.snp.top)
            make.centerX.equalTo(registerSubview.snp.centerX)
        }
        
        registerCancelButton.snp.makeConstraints { make in
            make.width.equalTo(156)
            make.height.equalTo(48)
            make.trailing.equalTo(registerSubview.snp.centerX).offset(-3)
            make.top.equalTo(registerSubTitle.snp.bottom).offset(28)
        }
        
        registerActiveButton.snp.makeConstraints { make in
            make.width.equalTo(156)
            make.height.equalTo(48)
            make.leading.equalTo(registerSubview.snp.centerX).offset(3)
            make.centerY.equalTo(registerCancelButton)
        }
    }
}

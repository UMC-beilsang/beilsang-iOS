//
//  AccountInfoViewController.swift
//  beilsang
//
//  Created by 강희진 on 1/24/24.
//

import Foundation
import UIKit
import SCLAlertView
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

class AccountInfoViewController: UIViewController, UIScrollViewDelegate {
    // MARK: - Properties
    
    let fullScrollView = UIScrollView()
    let fullContentView = UIView()
    var alertViewResponder: SCLAlertViewResponder? = nil
    let datePicker = UIDatePicker()
    let pickerView = UIPickerView()
    let genderOptions = ["남자", "여자", "기타"]
    var selectedGender: String?
    var nickName: String?
    let kakaoZipCodeVC = KakaoPostCodeViewController()
    var isFirstInput = true
    var textFieldValid = true
    var nameDuplicate = true
    var isNext = [false, false, false, false]
    
    let agreeImage = UIImage(named: "agree")
    let disagreeImage = UIImage(named: "disagree")
    
    private var isProgressBarVisible = true
    private var lastContentOffset: CGFloat = 0
    var isAgree = [false, false]
    
    lazy var profileShadowView: UIImageView = {
        let view = UIImageView()
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        view.layer.shadowOpacity = 1
        view.image = UIImage(named: "Mask group")
        view.layer.cornerRadius = 48
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 4
//        view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds,
//                               cornerRadius: view.layer.cornerRadius).cgPath
        return view
    }()
    lazy var editProfileImageView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 9
        view.backgroundColor = .beBgSub
        return view
    }()
    lazy var editProfileImageLabel: UILabel = {
        let label = UILabel()
        label.text = "수정"
        label.textColor = .beButtonNavi
        label.font = UIFont(name: "NotoSansKR-Medium", size: 12)
        return label
    }()
    lazy var editProfileImageButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        return button
    }()// MARK: - Properties
    
    
    // 닉네임
    
    lazy var nameLabel: UILabel = {
        let view = UILabel()
        view.text = "닉네임"
        view.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        view.numberOfLines = 0
        view.textColor = .beTextDef
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    let nameCircle = CircleView()
    
    lazy var nameField: UITextField = {
        let view = UITextField()
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.beBorderDis.cgColor
        view.autocorrectionType = .no
        view.spellCheckingType = .no
        view.autocapitalizationType = .none
        view.setPlaceholderColor(.beTextEx)
        view.clearButtonMode = .whileEditing
        view.clearsOnBeginEditing = false
        view.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 19.0, height: 0.0))
        view.leftViewMode = .always
        let placeholderText = "2~8자 이내로 입력해 주세요"
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14)
        ]
        view.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        view.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        
        //키보드 관련 설정
        view.returnKeyType = .done
        view.keyboardType = UIKeyboardType.namePhonePad
        view.resignFirstResponder()
        
        
        return view
    }()
    
    lazy var nameInfoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.isHidden = true
        
        return view
    }()
    
    lazy var nameInfoImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var nameInfoLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "NotoSansKR-Regular", size: 11)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var nameDuplicateButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .beBgDiv
        button.setTitle("중복 확인", for: .normal)
        button.setTitleColor(.beTextEx, for: .disabled)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        button.layer.cornerRadius = 8
        
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(duplicateCheck), for: .touchDown)
        
        return button
    }()
    
    // 생년월일
    
    lazy var birthLabel: UILabel = {
        let view = UILabel()
        view.text = "생년월일"
        view.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        view.numberOfLines = 0
        view.textColor = .beTextDef
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    let birthCircle = CircleView()
    
    lazy var birthField: UITextField = {
        let view = UITextField()
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.beBorderDis.cgColor
        view.autocorrectionType = .no
        view.spellCheckingType = .no
        view.autocapitalizationType = .none
        view.setPlaceholderColor(.beTextEx)
        view.clearButtonMode = .never
        view.clearsOnBeginEditing = false
        view.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 19.0, height: 0.0))
        view.leftViewMode = .always
        let placeholderText = "생년월일 입력하기"
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14)
        ]
        view.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        view.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        view.tintColor = .clear
        
        return view
    }()
    
    // 성별
    
    lazy var genderLabel: UILabel = {
        let view = UILabel()
        view.text = "성별"
        view.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        view.numberOfLines = 0
        view.textColor = .beTextDef
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    let genderCircle = CircleView()
    
    lazy var genderField: UITextField = {
        let view = UITextField()
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.beBorderDis.cgColor
        view.autocorrectionType = .no
        view.spellCheckingType = .no
        view.autocapitalizationType = .none
        view.setPlaceholderColor(.beTextEx)
        view.clearButtonMode = .never
        view.clearsOnBeginEditing = false
        view.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 19.0, height: 0.0))
        view.leftViewMode = .always
        let placeholderText = "성별 입력하기"
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14)
        ]
        view.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        view.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        view.tintColor = .clear //커서 지우기
        
        return view
    }()
    
    // 주소
    let addressCircle = CircleView()
    
    lazy var addressLabel: UILabel = {
        let view = UILabel()
        view.text = "주소"
        view.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        view.numberOfLines = 0
        view.textColor = .beTextDef
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var zipCodeField: UITextField = {
        let view = UITextField()
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.beBorderDis.cgColor
        view.autocorrectionType = .no
        view.spellCheckingType = .no
        view.autocapitalizationType = .none
        view.setPlaceholderColor(.beTextEx)
        view.clearButtonMode = .never
        view.clearsOnBeginEditing = false
        view.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 19.0, height: 0.0))
        view.leftViewMode = .always
        let placeholderText = "우편번호 입력하기"
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14)
        ]
        view.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        view.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        view.tintColor = .clear //커서 지우기
        
        let zipCodeTapGesture = UITapGestureRecognizer(target: self, action: #selector(zipCodeFieldTapped))
        view.addGestureRecognizer(zipCodeTapGesture)
        
        return view
    }()
    
    lazy var zipCodeSearchButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .beScPurple600
        button.setTitleColor(.beTextWhite, for: .normal)
        button.setTitle("우편번호 검색", for: .normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Regular", size: 12)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(zipCodeSearch), for: .touchDown)
        
        return button
    }()
    
    lazy var addressField: UITextField = {
        let view = UITextField()
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.beBorderDis.cgColor
        view.autocorrectionType = .no
        view.spellCheckingType = .no
        view.autocapitalizationType = .none
        view.setPlaceholderColor(.beTextEx)
        view.clearButtonMode = .never
        view.clearsOnBeginEditing = false
        view.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 19.0, height: 0.0))
        view.leftViewMode = .always
        let placeholderText = "도로명 주소 입력하기"
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14)
        ]
        view.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        view.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        view.tintColor = .clear //커서 지우기
        
        let addressTapGesture = UITapGestureRecognizer(target: self, action: #selector(addressFieldTapped))
        view.addGestureRecognizer(addressTapGesture)
        
        return view
    }()
    
    lazy var addressDetailField: UITextField = {
        let view = UITextField()
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.beBorderDis.cgColor
        view.autocorrectionType = .no
        view.spellCheckingType = .no
        view.autocapitalizationType = .none
        view.setPlaceholderColor(.beTextEx)
        view.clearButtonMode = .whileEditing
        view.clearsOnBeginEditing = false
        view.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 19.0, height: 0.0))
        view.leftViewMode = .always
        let placeholderText = "상세 주소 입력하기"
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14)
        ]
        view.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        view.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        
        view.returnKeyType = .done
        view.keyboardType = UIKeyboardType.namePhonePad
        view.resignFirstResponder()
        
        
        return view
    }()
    
    lazy var divider: UIView = {
        let view = UIView()
        view.backgroundColor = .beBgSub
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그아웃", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        button.addTarget(self, action: #selector(tapLogoutButton), for: .touchDown)
        return button
    }()
    lazy var logoutAlert: SCLAlertView = {
        
        let apperance = SCLAlertView.SCLAppearance(
            kWindowWidth: 342, kWindowHeight : 272,
            kTitleFont: UIFont(name: "NotoSansKR-SemiBold", size: 18)!,
            kTextFont: UIFont(name: "NotoSansKR-Regular", size: 14)!,
            kButtonFont: UIFont(name: "NotoSansKR-Medium", size: 14)!,
            showCloseButton: false,
            showCircularIcon: false,
            dynamicAnimatorActive: false
        )
        let alert = SCLAlertView(appearance: apperance)
        
        return alert
    }()
    lazy var logoutSubview : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    lazy var logoutPopUpContent: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NotoSansKR-Medium", size: 12)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = "로그아웃을 진행할까요?\n 앱 내 계정 정보는 사라지지 않아요 👀"
        label.textColor = .beTextInfo
        return label
    }()
    
    
    // 로그아웃일 때, email 박스
    lazy var emailBox: UIView = {
        let view = UIView()
        view.backgroundColor = .beBgSub
        view.layer.cornerRadius = 4
        return view
    }()
    
    lazy var emailLabel1: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "현재 로그인된 계정"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 12)
        label.textColor = .beTextInfo
        return label
    }()
    lazy var emailLabel2: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "NotoSansKR-Regular", size: 11)
        label.text = "email"
        label.textColor = .beTextInfo
        return label
    }()
    lazy var cancelLogoutButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .beBgSub
        button.setTitleColor(.beBorderDef, for: .normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        button.setTitle("취소", for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(cancel), for: .touchUpInside)

        return button
    }()
    lazy var activeLogoutButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .beScPurple600
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        button.setTitle("로그아웃하기", for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(logout), for: .touchUpInside)
        return button
    }()
    lazy var withdrawButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원탈퇴", for: .normal)
        button.setTitleColor(.beTextEx, for: .normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        button.addTarget(self, action: #selector(tapWithdrawButton), for: .touchDown)
        return button
    }()
    lazy var withDrawAlert: SCLAlertView = {
        let apperance = SCLAlertView.SCLAppearance(
            kWindowWidth: 342, kWindowHeight : 272,
            kTitleFont: UIFont(name: "NotoSansKR-SemiBold", size: 18)!,
            kTextFont: UIFont(name: "NotoSansKR-Regular", size: 14)!,
            kButtonFont: UIFont(name: "NotoSansKR-Medium", size: 14)!,
            showCloseButton: false,
            showCircularIcon: false,
            dynamicAnimatorActive: false
        )
        let alert = SCLAlertView(appearance: apperance)
        
        return alert
    }()
    lazy var withDrawSubview: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    lazy var withDrawPopUpContent: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NotoSansKR-Medium", size: 12)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = "정말 탈퇴하시나요?\n 지금 탈퇴하면 챌린지 업적은 복구되지 않아요"
        label.textColor = .beTextInfo
        return label
    }()
    let textViewPlaceHolder = "탈퇴 사유를 입력해 주세요"
    //탈퇴사유 입력 textField
    lazy var withDrawTextView: UITextView = {
        let view = UITextView()
        view.layer.borderColor = UIColor.beBgCard.cgColor
        view.layer.borderWidth = 1
        view.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        view.layer.cornerRadius = 8
        view.textColor = .beTextEx
        // 자동 수정 활성화 여부
        view.autocorrectionType = .no
        // 맞춤법 검사 활성화 여부
        view.spellCheckingType = .no
        // 대문자부터 시작 활성화 여부
        view.autocapitalizationType = .none
        view.delegate = self
        view.text = textViewPlaceHolder
        return view
    }()
    lazy var cancelWithDrawButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .beBgSub
        button.setTitleColor(.beBorderDef, for: .normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        button.setTitle("취소", for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        return button
    }()
    lazy var activeWithDrawButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .beScPurple600
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        button.setTitle("탈퇴하기", for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(withdraw), for: .touchUpInside)
        return button
    }()
    lazy var greyBox: UIView = {
        let view = UIView()
        view.backgroundColor = .beBgSub
        return view
    }()
    lazy var privacyPolicy: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        button.setTitle("개인정보처리방침", for: .normal)
        button.setTitleColor(.beTextEx, for: .normal)
        return button
    }()
    lazy var termsOfUse: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        button.setTitle("이용약관", for: .normal)
        button.setTitleColor(.beTextEx, for: .normal)
        return button
    }()
    lazy var bottomBar: UIView = {
        let view = UIView()
        view.backgroundColor = .beTextEx
        return view
    }()
    
    // 저장 팝업
    lazy var saveAlert: SCLAlertView = {
        let apperance = SCLAlertView.SCLAppearance(
            kWindowWidth: 342, kWindowHeight : 272,
            kTitleFont: UIFont(name: "NotoSansKR-SemiBold", size: 18)!,
            kTextFont: UIFont(name: "NotoSansKR-Regular", size: 14)!,
            kButtonFont: UIFont(name: "NotoSansKR-Medium", size: 14)!,
            showCloseButton: false,
            showCircularIcon: false,
            dynamicAnimatorActive: false
        )
        let alert = SCLAlertView(appearance: apperance)
        
        return alert
    }()
    lazy var saveSubview: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    lazy var savePopUpContent: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NotoSansKR-Medium", size: 12)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = "변동사항을 저장하지 않고 나가시겠어요?\n현재 창을 나가면 작성된 내용은 저장되지 않아요 👀"
        label.textColor = .beTextInfo
        return label
    }()
    lazy var cancelSaveButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .beBgSub
        button.setTitleColor(.beBorderDef, for: .normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        button.setTitle("닫기", for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        return button
    }()
    lazy var activeSaveButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .beScPurple600
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("나가기", for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(close), for: .touchUpInside)
        return button
    }()
    // 네비게이션 오른쪽 BarItem - 변경사항 저장
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("저장하기", for: .normal)
        button.layer.cornerRadius = 8
        // 비활성화 상태일 때
        button.isEnabled = false
        button.setTitleColor(.white, for: .disabled)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .beScPurple400
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(save), for: .touchDown)
        return button
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupAttribute()
        viewConstraint()
        setNavigationBar()
        createPickerView()
        setupDatePicker()
        setTextField()
        setupToolBar()
        saveButton.isEnabled = false
    }
}

extension AccountInfoViewController {
    func request() {
        var gender = ""
        if genderField.text == "남자"{
            gender = "MAN"
        } else if genderField.text == "여자"{
            gender = "WOMAN"
        } else if genderField.text == "기타"{
            gender = "OTHER"
        }
        let parameters = AccountInfoData(nickName: nameField.text ?? "", birth: birthField.text ?? "" , gender: gender , address: (addressField.text ?? "") + (addressDetailField.text ?? ""))
        print(parameters)
        MyPageService.shared.patchAccountInfo(baseEndPoint: .profile, addPath: "", parameter: parameters.toDictionary ?? [:] ) { response in
            print(response.message )
        }
    }

    func setupAttribute() {
        setFullScrollView()
        setLayout()
        setScrollViewLayout()
        
    }
    
    func setFullScrollView() {
        fullScrollView.showsVerticalScrollIndicator = true
        fullScrollView.delegate = self
        
        //스크롤 안보이게 설정
        fullScrollView.showsVerticalScrollIndicator = false
    }
    
    func setLayout() {
        view.addSubview(fullScrollView)
        fullScrollView.addSubview(fullContentView)
        addView()
    }
    func setScrollViewLayout(){
        fullScrollView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        fullContentView.snp.makeConstraints { make in
            make.edges.equalTo(fullScrollView.contentLayoutGuide)
            make.width.equalTo(fullScrollView.frameLayoutGuide)
            make.height.equalTo(1000)
        }
    }
    // addSubview() 메서드 모음
    func addView() {
        // foreach문을 사용해서 클로저 형태로 작성
        [profileShadowView, editProfileImageView, editProfileImageLabel, editProfileImageButton, nameLabel, nameField, nameInfoView, nameInfoImage, nameInfoLabel, nameDuplicateButton, birthLabel, birthField, genderLabel, genderField, addressLabel, zipCodeField, zipCodeSearchButton, addressField, addressDetailField, divider, logoutButton, withdrawButton, greyBox, privacyPolicy, termsOfUse, bottomBar, nameCircle, birthCircle, genderCircle, addressCircle].forEach{view in fullContentView.addSubview(view)}
        
        nameInfoView.addSubview(nameInfoImage)
        nameInfoView.addSubview(nameInfoLabel)
        
        logoutAlert.customSubview = logoutSubview
        [logoutPopUpContent, cancelLogoutButton, activeLogoutButton, emailBox, emailLabel1, emailLabel2].forEach{view in logoutSubview.addSubview(view)}
        withDrawAlert.customSubview = withDrawSubview
        [withDrawPopUpContent, cancelWithDrawButton, activeWithDrawButton, withDrawTextView].forEach{view in withDrawSubview.addSubview(view)}
        saveAlert.customSubview = saveSubview
        [savePopUpContent, cancelSaveButton, activeSaveButton].forEach{view in saveSubview.addSubview(view)}
    }
    // MARK: - 전체 오토레이아웃 관리
    func viewConstraint(){
        profileShadowView.snp.makeConstraints { make in
            make.width.equalTo(96)
            make.height.equalTo(96)
            make.leading.equalToSuperview().offset(super.view.frame.width/2 - 48)
            make.top.equalToSuperview().offset(32)
        }
        editProfileImageView.snp.makeConstraints { make in
            make.width.equalTo(46)
            make.height.equalTo(21)
            make.top.equalTo(profileShadowView.snp.bottom).offset(16)
            make.centerX.equalTo(profileShadowView)
        }
        editProfileImageLabel.snp.makeConstraints { make in
            make.top.equalTo(profileShadowView.snp.bottom).offset(18)
            make.centerX.equalTo(profileShadowView)
        }
        editProfileImageButton.snp.makeConstraints { make in
            make.width.equalTo(46)
            make.height.equalTo(21)
            make.top.equalTo(profileShadowView.snp.bottom).offset(16)
            make.centerX.equalTo(profileShadowView)
        }
        nameLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(197)
            make.leading.equalToSuperview().offset(16)
        }
        nameCircle.snp.makeConstraints{ make in
            make.top.equalTo(nameLabel)
            make.leading.equalTo(nameLabel.snp.trailing).offset(2)
            make.width.height.equalTo(4)
        }
        nameField.snp.makeConstraints{ make in
            make.top.equalTo(nameLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(48)
            make.width.equalTo(254)
        }
        nameInfoView.snp.makeConstraints{ make in
            make.top.equalTo(nameField.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(16)
            make.width.equalTo(240)
        }
        
        nameInfoImage.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.width.equalTo(14)
        }
        
        nameInfoLabel.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(nameInfoImage.snp.trailing).offset(4)
        }
        nameDuplicateButton.snp.makeConstraints{ make in
            make.top.equalTo(nameField)
            make.leading.equalTo(nameField.snp.trailing).offset(8)
            make.height.equalTo(nameField)
            make.trailing.equalToSuperview().offset(-16)
        }
        birthLabel.snp.makeConstraints{ make in
            make.top.equalTo(nameInfoView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
        }
        
        birthCircle.snp.makeConstraints{ make in
            make.top.equalTo(birthLabel)
            make.leading.equalTo(birthLabel.snp.trailing).offset(2)
            make.width.height.equalTo(4)
        }
        birthField.snp.makeConstraints{ make in
            make.top.equalTo(birthLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        genderLabel.snp.makeConstraints{ make in
            make.top.equalTo(birthField.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
        }
        genderCircle.snp.makeConstraints{ make in
            make.top.equalTo(genderLabel)
            make.leading.equalTo(genderLabel.snp.trailing).offset(2)
            make.width.height.equalTo(4)
        }
        
        genderField.snp.makeConstraints{ make in
            make.top.equalTo(genderLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        addressLabel.snp.makeConstraints{ make in
            make.top.equalTo(genderField.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
        }
        addressCircle.snp.makeConstraints { make in
            make.top.equalTo(addressLabel)
            make.leading.equalTo(addressLabel.snp.trailing).offset(2)
            make.width.height.equalTo(4)
        }
        zipCodeField.snp.makeConstraints{ make in
            make.top.equalTo(addressLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(48)
            make.width.equalTo(254)
        }
        
        zipCodeSearchButton.snp.makeConstraints{ make in
            make.top.equalTo(zipCodeField)
            make.leading.equalTo(zipCodeField.snp.trailing).offset(8)
            make.height.equalTo(zipCodeField)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        addressField.snp.makeConstraints{ make in
            make.top.equalTo(zipCodeField.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        
        addressDetailField.snp.makeConstraints{ make in
            make.top.equalTo(addressField.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        divider.snp.makeConstraints{ make in
            make.top.equalTo(addressDetailField.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(8)
        }
        
        logoutButton.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel)
            make.top.equalTo(divider.snp.bottom).offset(24)
        }
        withdrawButton.snp.makeConstraints { make in
            make.leading.equalTo(logoutButton)
            make.top.equalTo(logoutButton.snp.bottom).offset(20)
        }
        greyBox.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(100)
            make.leading.equalToSuperview()
            make.top.equalTo(withdrawButton.snp.bottom).offset(48)
        }
        privacyPolicy.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset((self.view.frame.width/2 - 107))
            make.top.equalTo(greyBox.snp.top).offset(32)
        }
        bottomBar.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.height.equalTo(18)
            make.leading.equalTo(privacyPolicy.snp.trailing).offset(20)
            make.centerY.equalTo(privacyPolicy)
        }
        termsOfUse.snp.makeConstraints { make in
            make.leading.equalTo(bottomBar.snp.trailing).offset(20)
            make.centerY.equalTo(privacyPolicy)
        }
        
        saveButton.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.width.equalTo(72)
        }
        alertLayout()
    }
// MARK: - 함수
    private func setTextField() {
        
        nameField.delegate = self
        birthField.delegate = self
        genderField.delegate = self
        addressDetailField.delegate = self
        
        //화면 터치시 키보드 내려감
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    
// MARK: - PickerView
    
    private func createPickerView() {
        /// 피커 세팅
        pickerView.delegate = self
        pickerView.dataSource = self
        genderField.tintColor = .clear
        
        /// 텍스트필드 입력 수단 연결
        genderField.inputView = pickerView
    }
    private func setupDatePicker() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.addTarget(self, action: #selector(dateChange), for: .valueChanged)
        datePicker.maximumDate = Date()
        birthField.inputView = datePicker
    }
    
    private func dateFormat(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter.string(from: date)
    }
}


            
// MARK: - 네비게이션 바 커스텀
extension AccountInfoViewController{
    private func setNavigationBar() {
        self.navigationItem.titleView = attributeTitleView()
        setBarButton()
        
    }
    private func attributeTitleView() -> UIView {
        // title 설정
        let label = UILabel()
        let lightText: NSMutableAttributedString =
        NSMutableAttributedString(string: "계정 정보",attributes: [
            .foregroundColor: UIColor.black,
            .font: UIFont(name: "NotoSansKR-SemiBold", size: 20)!])
        let naviTitle: NSMutableAttributedString
        = lightText
        label.attributedText = naviTitle
        
        return label
    }
    // 백버튼 커스텀
    func setBarButton() {
        let leftBarButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon-navigation")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(tabBarButtonTapped))
        // 기존 barbutton이미지 이용할 때 -> (barButtonSystemItem: ., target: self, action: #selector(tabBarButtonTapped))
        leftBarButton.tintColor = .black
        
        
        let rightBarButton: UIBarButtonItem = UIBarButtonItem(customView: saveButton)
        
        self.navigationItem.leftBarButtonItem = leftBarButton
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    // 백버튼 액션
    @objc func tabBarButtonTapped() {
        print("뒤로 가기")
        if saveButton.isEnabled {
            alertViewResponder = saveAlert.showInfo("저장되지 않은 내용이 있어요!", subTitle: "변동사항을 저장하지 않고 나가시겠어요?\n현재 창을 나가면 작성된 내용은 저장되지 않아요 👀")
        }else{
            navigationController?.popViewController(animated: true)
        }
    }
    //MARK: - Tool Bar
    
    private func setupToolBar() {
        
        let toolBar = UIToolbar()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonHandeler))
        
        toolBar.items = [flexibleSpace, doneButton]
        // 적절한 사이즈로 toolBar의 크기를 만들어 줍니다.
        toolBar.sizeToFit()
        
        birthField.inputAccessoryView = toolBar
        genderField.inputAccessoryView = toolBar
    }
    // MARK: - changed
    
    private func nameInfoViewChanged(state: String) {
        switch state {
        case "avaliable":
            nameInfoView.isHidden = false
            nameInfoImage.image = UIImage(named: "iconCheck")
            nameInfoLabel.text = "사용 가능한 닉네임입니다."
            nameInfoLabel.textColor = .bePsBlue500
        case "inavaliable":
            nameInfoView.isHidden = false
            nameInfoImage.image = UIImage(named: "iconAttention")
            nameInfoLabel.text = "닉네임은 2-8자 이내로 입력해 주세요."
            nameInfoLabel.textColor = .beWnRed500
        case "exist":
            nameInfoView.isHidden = false
            nameInfoImage.image = UIImage(named: "iconAttention")
            nameInfoLabel.text = "이미 존재하는 닉네임입니다."
            nameInfoLabel.textColor = .beWnRed500
        default:
            break
        }
    }
    private func textFieldChanged(textField: UITextField, state: String)  {
        switch state {
        case "avaliable":
            textField.layer.borderColor = UIColor.bePsBlue500.cgColor
            textField.layer.backgroundColor = UIColor.bePsBlue100.cgColor
            textField.textColor = UIColor.bePsBlue500
            textField.setPlaceholderColor(.bePsBlue500)
        case "basic":
            // 다른 상태에 대한 설정 또는 기본값 설정
            textField.layer.borderColor = UIColor.beBorderDis.cgColor
            textField.layer.backgroundColor = UIColor.beBgCard.cgColor
            textField.textColor = UIColor.black
            textField.setPlaceholderColor(.lightGray)
        case "inavaliable":
            textField.backgroundColor = .beWnRed100
            textField.layer.borderColor = UIColor.beWnRed500.cgColor
            textField.textColor = .beWnRed500
            textField.setPlaceholderColor(.beWnRed500)
            
        default:
            break
        }
    }
    
    private func nameDuplicateButtonChanged(state: String) {
        switch state {
        case "avaliable":
            nameDuplicateButton.isEnabled = true
            nameDuplicateButton.setTitleColor(.beTextWhite, for: .normal)
            nameDuplicateButton.backgroundColor = .beScPurple600
        case "inavaliable":
            nameDuplicateButton.isEnabled = false
            nameDuplicateButton.setTitleColor(.beTextEx, for: .normal)
            nameDuplicateButton.backgroundColor = .beBgDiv
        default:
            break
        }
    }
    // MARK: - nameDuplicateCheck
    
    func nameDuplicateCheck() {
        
        let serverInput = requestDuplicateCheck()
        
        if serverInput  {
            nameInfoViewChanged(state: "avaliable")
            textFieldChanged(textField: nameField, state: "basic")
            nameDuplicate = true
            
            isNext[0] = true
            
            updateSaveButtonState()
        }
        else {
            nameInfoViewChanged(state: "exist")
            textFieldChanged(textField: nameField, state: "inavaliable")
            nameDuplicate = false
            
            updateSaveButtonState()
        }
    }
    
    private func requestDuplicateCheck() -> Bool{
        var dupCheck = true
        MyPageService.shared.getDuplicateCheck(baseEndPoint: .join, addPath: "?name=\(nameField.text ?? "")" ) { response in
            dupCheck = response.data
        }
        return dupCheck
    }
    // MARK: - save Button
    
    func updateSaveButtonState() {
        if isNext.contains(true) {
            saveButton.backgroundColor = .beScPurple600
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
            saveButton.backgroundColor = .beScPurple400
        }
    }
    
    // MARK: - Actions
    
    
    @objc private func handleTap() {
        view.endEditing(true)
    }
    
    @objc private func duplicateCheck() {
        nameDuplicateCheck()
    }
    @objc private func zipCodeSearch() {
        kakaoZipCodeVC.accountInfoVC = self
        present(kakaoZipCodeVC, animated: true)
    }
    
    @objc private func zipCodeFieldTapped() {
        zipCodeSearch()
    }
    
    @objc private func addressFieldTapped() {
        zipCodeSearch()
    }
    
    @objc func dateChange(_ sender: UIDatePicker) {
        birthField.text = dateFormat(date: sender.date)
        birthField.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        birthField.textColor = .bePsBlue500
    }
    
    @objc func doneButtonHandeler(_ sender: UIBarButtonItem) {
        birthField.resignFirstResponder()
        genderField.resignFirstResponder()
    }
    @objc func tapLogoutButton(){
        print("로그아웃")
        alertViewResponder = logoutAlert.showInfo("계정 로그아웃")
    }
    @objc func tapWithdrawButton(){
        print("회원 탈퇴")
        alertViewResponder = withDrawAlert.showInfo("회원 탈퇴")
    }
    @objc func logout(){
        kakaoLogout()
        
        UserDefaults.standard.setValue(nil, forKey: UserDefaultsKey.serverToken)
        UserDefaults.standard.setValue(nil, forKey: UserDefaultsKey.refreshToken)
        
        alertViewResponder?.close()
        
        let loginVC = LoginViewController()
        let navigationController = UINavigationController(rootViewController: loginVC)
        
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            UIView.transition(with: sceneDelegate.window!,
                              duration: 1.5,
                              options: .transitionCrossDissolve,
                              animations: {
                sceneDelegate.window?.rootViewController = navigationController
            },
                              completion: nil)
        }
    }
    @objc func withdraw(){
        MyPageService.shared.DeleteWithDraw { response in
            print(response.message)
        }
        kakaoLogout()
        alertViewResponder?.close()
        
        let loginVC = LoginViewController()
        let navigationController = UINavigationController(rootViewController: loginVC)
        
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            UIView.transition(with: sceneDelegate.window!,
                              duration: 1.5,
                              options: .transitionCrossDissolve,
                              animations: {
                sceneDelegate.window?.rootViewController = navigationController
            },
                              completion: nil)
        }
    }
    @objc func close(){
        alertViewResponder?.close()
        navigationController?.popViewController(animated: true)
    }
    @objc func cancel(){
        alertViewResponder?.close()
    }
    @objc func save() {
        isNext = [false, false, false, false]
        updateSaveButtonState()
        nameDuplicateButton.isEnabled = false
        nameDuplicateButton.backgroundColor = .beBgDiv
        request()
    }
}

extension AccountInfoViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        
        if offsetY <= 0 {
            navigationController?.setNavigationBarHidden(false, animated: true)
            navigationController?.hidesBarsOnSwipe = false
        }
        
        else {
            navigationController?.setNavigationBarHidden(true, animated: true)
            navigationController?.hidesBarsOnSwipe = true
        }
    }
    
}

// MARK: - Alert
extension AccountInfoViewController {
    func alertLayout() {
        // 로그아웃 알림창
        logoutSubview.snp.makeConstraints { make in
            make.width.equalTo(316)
            make.height.equalTo(200)
        }
        emailBox.snp.makeConstraints { make in
            make.width.equalTo(280)
            make.height.equalTo(64)
            make.centerX.equalTo(logoutSubview.snp.centerX)
            make.top.equalToSuperview()
        }
        emailLabel1.snp.makeConstraints { make in
            make.top.equalTo(emailBox.snp.top).offset(14)
            make.centerX.equalToSuperview()
        }
        emailLabel2.snp.makeConstraints { make in
            make.top.equalTo(emailLabel1.snp.bottom)
            make.centerX.equalToSuperview()
        }
        logoutPopUpContent.snp.makeConstraints { make in
            make.top.equalTo(emailBox.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        cancelLogoutButton.snp.makeConstraints { make in
            make.width.equalTo(156)
            make.height.equalTo(48)
            make.trailing.equalTo(logoutSubview.snp.centerX).offset(-3)
            make.top.equalTo(logoutPopUpContent.snp.bottom).offset(28)
        }
        activeLogoutButton.snp.makeConstraints { make in
            make.width.equalTo(156)
            make.height.equalTo(48)
            make.leading.equalTo(logoutSubview.snp.centerX).offset(3)
            make.centerY.equalTo(cancelLogoutButton)
        }
        // 회원 탈퇴 알림창
        withDrawSubview.snp.makeConstraints { make in
            make.width.equalTo(316)
            make.bottom.equalTo(cancelWithDrawButton).offset(12)
        }
        withDrawPopUpContent.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        withDrawTextView.snp.makeConstraints { make in
            make.width.equalTo(285)
            make.height.equalTo(140)
            make.centerX.equalToSuperview()
            make.top.equalTo(withDrawPopUpContent.snp.bottom).offset(20)
        }
        cancelWithDrawButton.snp.makeConstraints { make in
            make.width.equalTo(156)
            make.height.equalTo(48)
            make.trailing.equalTo(withDrawSubview.snp.centerX).offset(-3)
            make.top.equalTo(withDrawTextView.snp.bottom).offset(28)
        }
        activeWithDrawButton.snp.makeConstraints { make in
            make.width.equalTo(156)
            make.height.equalTo(48)
            make.leading.equalTo(withDrawSubview.snp.centerX).offset(3)
            make.centerY.equalTo(cancelWithDrawButton)
        }
        // 저장되지 않은 내용이 있어요! 알림창
        saveSubview.snp.makeConstraints { make in
            make.width.equalTo(316)
            make.bottom.equalTo(cancelSaveButton).offset(12)
        }
        savePopUpContent.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        cancelSaveButton.snp.makeConstraints { make in
            make.width.equalTo(156)
            make.height.equalTo(48)
            make.trailing.equalTo(saveSubview.snp.centerX).offset(-3)
            make.top.equalTo(savePopUpContent.snp.bottom).offset(28)
        }
        activeSaveButton.snp.makeConstraints { make in
            make.width.equalTo(156)
            make.height.equalTo(48)
            make.leading.equalTo(saveSubview.snp.centerX).offset(3)
            make.centerY.equalTo(cancelSaveButton)
        }
    }
}

extension AccountInfoViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameField {
            nameField.resignFirstResponder()
        }
        else if textField == addressDetailField {
            addressDetailField.resignFirstResponder()
        }

        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == nameField  {
            
            if isFirstInput { //첫입력일때
                textFieldChanged(textField: nameField, state: "avaliable")
                isFirstInput = false
            }
            else {
                if textFieldValid { //true일 때 : 2-8자 이내 or 공백
                    nameInfoView.isHidden = true //혹시 모르니 인포뷰 숨기고
                    textFieldChanged(textField: nameField, state: "avaliable") //textField 파란색 표시
                }
                else { //2-8자 이내 아님. 그러면 shoulEndEditing일때 바꾼걸유지해야함.
                }
            }
            //이런식으로 하면 안될듯, 그냥 첫 시작부터 다시 생각해보면,
            //처음에 입력 -> 2-8자 이내 인지 검사
            //재입력인 경우를 구분해서 거기서 나눠야할듯 ?
        
        }
        else if textField == birthField {
            textFieldChanged(textField: birthField, state: "avaliable")
        }
        else if textField == genderField {
            textFieldChanged(textField: genderField, state: "avaliable")
        }
        else if textField == addressDetailField {
            textFieldChanged(textField: addressDetailField, state: "avaliable")
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField == nameField {
            
            let userInput = nameField.text ?? ""
            
            if userInput.hasCharactersLogin() {//2-8자 이내일 때
                textFieldChanged(textField: nameField, state: "basic") //text필드는 다시 베이직으로 바뀌고,
                nameDuplicateButtonChanged(state: "avaliable") // 중복 확인 버튼 활성화
                
                textFieldValid = true
                
            }
            else if userInput.isEmpty { //공백일때
                textFieldChanged(textField: nameField, state: "basic") //text필드는 다시 베이직으로 바뀜
                
                textFieldValid = true
            }
            
            else { //2-8자 이내 아닐 때
                textFieldChanged(textField: nameField, state: "inavaliable")
                nameInfoViewChanged(state: "inavaliable")
                nameDuplicateButtonChanged(state: "inavaliable")
                
                textFieldValid = false
            }
        }
        
        else if textField == birthField {
            textFieldChanged(textField: birthField, state: "basic")
            
            if let birthDate = birthField.text, !birthDate.isEmpty {
                isNext[1] = true
            }
            
            updateSaveButtonState()
            
        }
        else if textField == genderField {
            textFieldChanged(textField: genderField, state: "basic")
            if let gender = genderField.text, !gender.isEmpty {
                isNext[2] = true
            }
            
            updateSaveButtonState()
            

        }
        else if textField == addressDetailField {
            textFieldChanged(textField: addressDetailField, state: "basic")
            

        }
    }
    func textFieldDidChangeSelection(_ textField: UITextField) { //change됐을때도
         
        if textField == nameField {
            let userInput = nameField.text ?? ""
            
            if userInput.hasCharactersLogin() {//2-8자 이내가 아닐때
                textFieldChanged(textField: nameField, state: "avaliable")
                nameInfoView.isHidden = true
            }
            else
            {}
        }
        else {}
    }
}
extension AccountInfoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            selectedGender = genderOptions[row]
        default:
            break
        }
        
        genderField.text = selectedGender
        genderField.textColor = .bePsBlue500
    }
}
extension AccountInfoViewController: UITextViewDelegate {
//    focus를 얻는 경우: text가 placeholder로 그대로 남아 있다면, 입력을 준비하기 위해서 text를 nil, color를 input색상으로 변경
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == textViewPlaceHolder {
            textView.text = nil
            textView.textColor = .black
        }
    }
//    focus를 읽는 경우: text가 비어있다면 text를 placeholder로 하고 color도 placeholder 색상으로 변경
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = textViewPlaceHolder
            textView.textColor = .beTextEx
        }
    }
}

// MARK: - Logout, Withdraw
extension AccountInfoViewController{
    private func kakaoLogout() {
        // 연결 끊기 요청 성공 시 로그아웃 처리가 함께 이뤄져 토큰이 삭제됩니다.
        UserApi.shared.logout {(error) in
            if let error = error {
                print(error)
            }
            else {
                print("logout() success.")
            }
        }
    }
    
}

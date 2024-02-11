//
//  UserInfoViewController.swift
//  beilsang
//
//  Created by Seyoung on 1/30/24.
//

import UIKit 
import SnapKit

class UserInfoViewController: UIViewController {
    
    //MARK: - Properties
    
    let verticalScrollView = UIScrollView()
    let verticalContentView = UIView()
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
    var birthFieldTextServer : String?
    
    let agreeImage = UIImage(named: "agree")
    let disagreeImage = UIImage(named: "disagree")
    
    private var isProgressBarVisible = true
    private var lastContentOffset: CGFloat = 0
    var isAgree = [false, false]
    
    lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var infoLabel: UILabel = {
        let view = UILabel()
        view.text = "비일상에 필요한 정보들을\n입력해 주세요"
        view.font = UIFont(name: "NotoSansKR-SemiBold", size: 20)
        view.numberOfLines = 2
        view.textColor = .beTextDef
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
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
    
    // 이용약관 동의
    
    lazy var agreeTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "이용약관 동의"
        view.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        view.numberOfLines = 0
        view.textColor = .beTextDef
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    let agreerCircle = CircleView()
    
    lazy var agreeAllButton: UIButton = {
        let button = UIButton()
        button.setImage(disagreeImage, for: .normal)
        button.addTarget(self, action: #selector(agreeAllButtonHandelr), for: .touchDown)
        
        return button
    }()
    
    lazy var agreeAllLabel: UILabel = {
        let view = UILabel()
        view.text = "약관 전체 동의"
        view.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        view.numberOfLines = 0
        view.textColor = .beTextDef
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var agreeAllButtonArea: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(agreeAllButtonHandelr), for: .touchDown)
        
        return button
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .beBorderDis
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var agreeButton: UIButton = {
        let button = UIButton()
        button.setImage(disagreeImage, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(agreeButtonHandelr), for: .touchDown)
        button.tag = 0
        
        return button
    }()
    
    lazy var needAgreeLabel: UILabel = {
        let view = UILabel()
        view.text = "(필수)"
        view.font = UIFont(name: "NotoSansKR-SemiBold", size: 14)
        view.numberOfLines = 0
        view.textColor = .beScPurple600
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var agreeLabel: UILabel = {
        let view = UILabel()
        view.text = "이용약관 동의"
        view.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        view.numberOfLines = 0
        view.textColor = .beTextDef
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var agreeButtonArea: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(agreeButtonHandelr), for: .touchDown)
        button.tag = 0
        
        return button
    }()
    
    lazy var agreeSection: UIView = {
        let view = UIView()
        view.backgroundColor = .beBgCard
        view.layer.borderColor = UIColor.beBorderDis.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        view.clipsToBounds  = true
        
        return view
    }()
    
    lazy var agreeText: UILabel = {
        let view = UILabel()
        view.text = "제1조 목적 \n 본 이용약관은 '비일상'의 서비스의 이용조건과 운영에 관한 제반사항 규정을 목적으로 합니다. \n \n 제2조 용어의 정의 \n 본 약관에서 사용되는 주요한 용어의 정의는 다음과 같습니다.\n ① 회원 : 본 사이트의 약관에 동의하고 개인정보를 제공하여 회원등록을 한 자로서, 사이트와의 이용계약을 체결하고 사이트를 이용하는 이용자를 말합니다.\n ② 이용계약 : 본 사이트 이용과 관련하여 사이트와 회원간에 체결 하는 계약을 말합니다."
        view.font = UIFont(name: "NotoSansKR-Regular", size: 11)
        view.numberOfLines = 10
        view.textColor = .beTextInfo
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var privacyAgreeButton: UIButton = {
        let button = UIButton()
        button.setImage(disagreeImage, for: .normal)
        button.addTarget(self, action: #selector(agreeButtonHandelr), for: .touchDown)
        button.tag = 1
        
        return button
    }()
    
    lazy var needPrivacyLabel: UILabel = {
        let view = UILabel()
        view.text = "(필수)"
        view.font = UIFont(name: "NotoSansKR-SemiBold", size: 14)
        view.numberOfLines = 0
        view.textColor = .beScPurple600
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var privacyLabel: UILabel = {
        let view = UILabel()
        view.text = "개인정보 수집 및 이용동의"
        view.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        view.numberOfLines = 0
        view.textColor = .beTextDef
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var privacyButtonArea: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(agreeButtonHandelr), for: .touchDown)
        button.tag = 1
        
        return button
    }()
    
    lazy var privacySection: UIView = {
        let view = UIView()
        view.backgroundColor = .beBgCard
        view.layer.borderColor = UIColor.beBorderDis.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        view.clipsToBounds  = true
        
        return view
    }()
    
    lazy var privacyText: UILabel = {
        let view = UILabel()
        view.text = "제1조 목적 \n 본 이용약관은 '비일상'의 서비스의 이용조건과 운영에 관한 제반사항 규정을 목적으로 합니다. \n \n 제2조 용어의 정의 \n 본 약관에서 사용되는 주요한 용어의 정의는 다음과 같습니다.\n ① 회원 : 본 사이트의 약관에 동의하고 개인정보를 제공하여 회원등록을 한 자로서, 사이트와의 이용계약을 체결하고 사이트를 이용하는 이용자를 말합니다.\n ② 이용계약 : 본 사이트 이용과 관련하여 사이트와 회원간에 체결 하는 계약을 말합니다."
        view.font = UIFont(name: "NotoSansKR-Regular", size: 11)
        view.numberOfLines = 10
        view.textColor = .beTextInfo
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .beScPurple400
        button.setTitle("다음으로", for: .normal)
        button.setTitleColor(.beTextWhite, for: .normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        button.addTarget(self, action: #selector(nextAction), for: .touchDown)
        
        return button
    }()
    
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setVerticalScrollView()
        setTextField()
        setupToolBar()
        setupDatePicker()
        createPickerView()
        setupUI()
        setupLayout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showNavigationBarOnDisappear()
    }
    
    //MARK: - UI Setup
    
    private func setupUI() {
        //navigationBarHidden()
        view.backgroundColor = .beBgDef
        view.addSubview(headerView)
        view.addSubview(verticalScrollView)
        verticalScrollView.addSubview(verticalContentView)
        verticalContentView.addSubview(infoLabel)
        verticalContentView.addSubview(nameLabel)
        verticalContentView.addSubview(nameCircle)
        verticalContentView.addSubview(nameField)
        verticalContentView.addSubview(nameInfoView)
        verticalContentView.addSubview(nameDuplicateButton)
        
        verticalContentView.addSubview(birthLabel)
        verticalContentView.addSubview(birthCircle)
        verticalContentView.addSubview(birthField)
        
        verticalContentView.addSubview(genderLabel)
        verticalContentView.addSubview(genderCircle)
        verticalContentView.addSubview(genderField)
        
        verticalContentView.addSubview(addressLabel)
        verticalContentView.addSubview(zipCodeField)
        verticalContentView.addSubview(zipCodeSearchButton)
        verticalContentView.addSubview(addressField)
        verticalContentView.addSubview(addressDetailField)
        
        verticalContentView.addSubview(divider)
        
        verticalContentView.addSubview(agreeTitleLabel)
        verticalContentView.addSubview(agreerCircle)
        verticalContentView.addSubview(agreeAllButton)
        verticalContentView.addSubview(agreeAllLabel)
        verticalContentView.addSubview(agreeAllButtonArea)
        
        verticalContentView.addSubview(lineView)
        
        verticalContentView.addSubview(agreeButton)
        verticalContentView.addSubview(needAgreeLabel)
        verticalContentView.addSubview(agreeLabel)
        verticalContentView.addSubview(agreeButtonArea)
        verticalContentView.addSubview(agreeSection)
        
        verticalContentView.addSubview(privacyAgreeButton)
        verticalContentView.addSubview(needPrivacyLabel)
        verticalContentView.addSubview(privacyLabel)
        verticalContentView.addSubview(privacyButtonArea)
        verticalContentView.addSubview(privacySection)
        
        verticalContentView.addSubview(nextButton)
        
        agreeSection.addSubview(agreeText)
        privacySection.addSubview(privacyText)
        
        nameInfoView.addSubview(nameInfoImage)
        nameInfoView.addSubview(nameInfoLabel)
    }
    
    private func setupLayout() {
        
        headerView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(view.safeAreaInsets.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44) // 네비게이션 바의 높이를 고려하여 조절
        }
        
        verticalScrollView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.bottom.leading.trailing.equalToSuperview()
        }
        
        //let height = UIScreen.main.bounds.height
        
        verticalContentView.snp.makeConstraints { make in
            make.edges.equalTo(verticalScrollView.contentLayoutGuide)
            make.width.equalTo(verticalScrollView.frameLayoutGuide)
            make.height.equalTo(1481)
        }
        
        infoLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalToSuperview().offset(16)
        }
        
        nameLabel.snp.makeConstraints{ make in
            make.top.equalTo(infoLabel.snp.bottom).offset(56)
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
            make.height.equalTo(0)
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
        
        agreeTitleLabel.snp.makeConstraints{ make in
            make.top.equalTo(divider.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
        }
        
        agreerCircle.snp.makeConstraints{ make in
            make.top.equalTo(agreeTitleLabel)
            make.leading.equalTo(agreeTitleLabel.snp.trailing).offset(2)
            make.width.height.equalTo(4)
        }
        
        agreeAllButton.snp.makeConstraints{ make in
            make.top.equalTo(agreeTitleLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.height.width.equalTo(28)
        }
        
        agreeAllLabel.snp.makeConstraints{ make in
            make.centerY.equalTo(agreeAllButton)
            make.leading.equalTo(agreeAllButton.snp.trailing).offset(8)
        }
        
        agreeAllButtonArea.snp.makeConstraints{ make in
            make.leading.equalTo(agreeAllButton.snp.trailing)
            make.trailing.equalToSuperview()
            make.top.equalTo(agreeTitleLabel.snp.bottom)
            make.height.equalTo(56)
        }
        
        lineView.snp.makeConstraints{ make in
            make.top.equalTo(agreeAllButton.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(0.75)
        }
        
        agreeButton.snp.makeConstraints{ make in
            make.top.equalTo(lineView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.height.width.equalTo(28)
        }
        
        needAgreeLabel.snp.makeConstraints{ make in
            make.leading.equalTo(agreeButton.snp.trailing).offset(8)
            make.centerY.equalTo(agreeButton)
        }
        
        agreeLabel.snp.makeConstraints{ make in
            make.leading.equalTo(needAgreeLabel.snp.trailing).offset(4)
            make.centerY.equalTo(agreeButton)
        }
        
        agreeButtonArea.snp.makeConstraints{ make in
            make.leading.equalTo(agreeButton.snp.trailing)
            make.trailing.equalToSuperview()
            make.top.equalTo(lineView.snp.bottom)
            make.height.equalTo(56)
        }
        
        agreeSection.snp.makeConstraints{ make in
            make.top.equalTo(agreeButton.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(128)
        }
        
        agreeText.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(14)
            make.leading.equalToSuperview().offset(19)
            make.trailing.equalToSuperview().offset(-19)
        }
        
        privacyAgreeButton.snp.makeConstraints{ make in
            make.top.equalTo(agreeSection.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.height.width.equalTo(28)
        }
        
        needPrivacyLabel.snp.makeConstraints{ make in
            make.leading.equalTo(privacyAgreeButton.snp.trailing).offset(8)
            make.centerY.equalTo(privacyAgreeButton)
        }
        
        privacyLabel.snp.makeConstraints{ make in
            make.leading.equalTo(needPrivacyLabel.snp.trailing).offset(4)
            make.centerY.equalTo(privacyAgreeButton)
        }
        
        privacyButtonArea.snp.makeConstraints{ make in
            make.leading.equalTo(privacyAgreeButton.snp.trailing)
            make.trailing.equalToSuperview()
            make.top.equalTo(agreeSection.snp.bottom)
            make.height.equalTo(56)
        }
        
        privacySection.snp.makeConstraints{ make in
            make.top.equalTo(privacyAgreeButton.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(128)
        }
        
        privacyText.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(14)
            make.leading.equalToSuperview().offset(19)
            make.trailing.equalToSuperview().offset(-19)
        }
        
        nextButton.snp.makeConstraints{ make in
            make.top.equalTo(privacySection.snp.bottom).offset(76)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(56)
        }
        
    }
    
    // MARK: - Navigation Bar
    
    private func showNavigationBarOnDisappear() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.hidesBarsOnSwipe = false
    }
    
    private func setNavigationBar() {
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.hidesBarsOnSwipe = true
    }
    
    // MARK: - ScrollView
    
    private func setVerticalScrollView() {
        verticalScrollView.showsVerticalScrollIndicator = true
        verticalScrollView.delegate = self
    }
    
    // MARK: - TextField
    
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
        formatter.dateFormat = "yyyy년 MM월 dd일"
        
        return formatter.string(from: date)
    }
    
    private func dateFormatServer(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter.string(from: date)
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
            nameInfoViewNoHidden()
            nameInfoImage.image = UIImage(named: "iconCheck")
            nameInfoLabel.text = "사용 가능한 닉네임입니다."
            nameInfoLabel.textColor = .bePsBlue500
        case "inavaliable":
            nameInfoView.isHidden = false
            nameInfoViewNoHidden()
            nameInfoImage.image = UIImage(named: "iconAttention")
            nameInfoLabel.text = "닉네임은 2-8자 이내로 입력해 주세요."
            nameInfoLabel.textColor = .beWnRed500
        case "exist":
            nameInfoView.isHidden = false
            nameInfoViewNoHidden()
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
        
        let userInput = nameField.text ?? ""
        let serverInput = Bool.random()
        
        if serverInput  {
            nameInfoViewChanged(state: "avaliable")
            textFieldChanged(textField: nameField, state: "basic")
            nameDuplicate = true
            
            isNext[0] = true
            
            updateNextButtonState()
        }
        else {
            nameInfoViewChanged(state: "exist")
            textFieldChanged(textField: nameField, state: "inavaliable")
            nameDuplicate = false
            
            updateNextButtonState()
            
        }
        
    }
    
    
    // MARK: - next Button
    
    func updateNextButtonState() {
        if isNext.allSatisfy({ $0 }) {
          nextButton.backgroundColor = .beScPurple600
          nextButton.isEnabled = true
        } else {
          nextButton.isEnabled = false
          nextButton.backgroundColor = .beScPurple400
        }
      }
    /*
     private func nextButtonDisabled() {
         
         guard nameDuplicate else {
             nextButtonActive = false
             return
         }
          
         // birthField의 선택 여부 확인
         guard let birthDate = birthField.text, !birthDate.isEmpty else {
             nextButtonActive = false
             return
         }
         
         // genderField의 선택 여부 확인
         guard let gender = genderField.text, !gender.isEmpty else {
             nextButtonActive = false
             return
         }
         
         guard agreeAllButton.isSelected else {
             nextButtonActive = false
             return
         }
         
         nextButtonActive = true
         
     }
     */
    
    private func updateAgreeAllButton() {
        if isAgree.allSatisfy({ $0 }) {
            agreeAllButton.isSelected = true
            agreeAllButton.setImage(agreeImage, for: .normal)
            isNext[3] = true
            updateNextButtonState()
        } else {
            agreeAllButton.isSelected = false
            agreeAllButton.setImage(disagreeImage, for: .normal)
            isNext[3] = false
            updateNextButtonState()
        }
    }
    
    //MARK: - nameInfoView Hidden
    
    func nameInfoViewHidden() {
        nameInfoView.snp.updateConstraints { make in
            make.height.equalTo(0) // 높이를 0으로 설정하여 숨김
        }
    }
    
    func nameInfoViewNoHidden() {
        nameInfoView.snp.updateConstraints { make in
            make.height.equalTo(16) // 높이를 0으로 설정하여 숨김
        }
    }
    
    // MARK: - Actions
    
    @objc private func nextAction() {
        
        if selectedGender == "남자" {
            SignUpData.shared.gender = "M"
        }
        else if selectedGender == "여자" {
            SignUpData.shared.gender = "F"
        }
        else{
            print("기타 아직 구현 안됨")
        }
    
        SignUpData.shared.nickName = nameField.text ?? ""
        SignUpData.shared.birth = birthFieldTextServer ?? ""
        
        if let address = addressField.text, let detailAddress = addressDetailField.text {
            let fullAddress = address + " " + detailAddress
            SignUpData.shared.address = fullAddress
        }
        
        let routeViewController = RouteViewController()
        self.navigationController?.pushViewController(routeViewController, animated: true)
    }
    
    @objc private func handleTap() {
        view.endEditing(true)
    }
    
    @objc private func duplicateCheck() {
        nameDuplicateCheck()
    }
    @objc private func zipCodeSearch() {
        kakaoZipCodeVC.userInfoVC = self
        present(kakaoZipCodeVC, animated: true)
    }
    
    @objc private func zipCodeFieldTapped() {
        zipCodeSearch()
    }
    
    @objc private func addressFieldTapped() {
        zipCodeSearch()
    }
    
    @objc func dateChange(_ sender: UIDatePicker) {
        let birthFieldTextServer = dateFormatServer(date: sender.date)
        
        birthField.text = dateFormat(date: sender.date)
        birthField.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        birthField.textColor = .bePsBlue500
    }
    
    @objc func doneButtonHandeler(_ sender: UIBarButtonItem) {
        birthField.resignFirstResponder()
        genderField.resignFirstResponder()
    }
    
    @objc func agreeAllButtonHandelr(_ sender: UIButton) {
        sender.isSelected.toggle()
        
        if sender.isSelected {
            agreeAllButton.setImage(agreeImage, for: .normal)
            agreeButton.isSelected = true
            agreeButton.setImage(agreeImage, for: .normal)
            privacyAgreeButton.isSelected = true
            privacyAgreeButton.setImage(agreeImage, for: .normal)
            
            isNext[3] = true
            
        } else {
            agreeAllButton.setImage(disagreeImage, for: .normal)
            agreeButton.setImage(disagreeImage, for: .normal)
            agreeButton.isSelected = false
            privacyAgreeButton.setImage(disagreeImage, for: .normal)
            privacyAgreeButton.isSelected = false
            
            isNext[3] = false
        }
        
        updateNextButtonState()
    }
    
    @objc func agreeButtonHandelr(_ sender: UIButton) {
        isAgree[sender.tag] = !isAgree[sender.tag]
        
        if sender == agreeButton || sender == privacyAgreeButton {
            sender.isSelected = isAgree[sender.tag]
            
            if isAgree[sender.tag] == true{
                sender.setImage(agreeImage, for: .normal)
            } else {
                sender.setImage(disagreeImage, for: .normal)
            }
        }
        
        else if sender == agreeButtonArea {
            agreeButton.isSelected = isAgree[sender.tag]
            
            if isAgree[sender.tag] == true{
                agreeButton.setImage(agreeImage, for: .normal)
            } else {
                agreeButton.setImage(disagreeImage, for: .normal)
            }
        }
        
        else if sender == privacyButtonArea {
            privacyAgreeButton.isSelected = isAgree[sender.tag]
            
            if isAgree[sender.tag] == true{
                privacyAgreeButton.setImage(agreeImage, for: .normal)
            } else {
                privacyAgreeButton.setImage(disagreeImage, for: .normal)
            }
        }
        
        updateAgreeAllButton()
    }
    
}

extension UserInfoViewController: UIScrollViewDelegate {
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

extension UserInfoViewController: UITextFieldDelegate {
    
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
                    nameInfoView.isHidden = true
                    nameInfoViewHidden()
                    textFieldChanged(textField: nameField, state: "avaliable") //textField 파란색 표시
                }
                else { //2-8자 이내 아님. 그러면 shoulEndEditing일때 바꾼걸유지해야함.
                    
                }
            }
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
            
            updateNextButtonState()
            
        }
        else if textField == genderField {
            textFieldChanged(textField: genderField, state: "basic")
            if let gender = genderField.text, !gender.isEmpty {
                isNext[2] = true
            }
            
            updateNextButtonState()
            

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
                nameInfoViewHidden()
            }
            else
            {
            }
        }
        else {
        }
    }

    
}

extension UserInfoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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

extension String {
    // 한글 숫자 영문 특수문자 포함 정규식 (이모티콘 제외)
    func hasCharactersLogin() -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[a-zA-Z0-9ㄱ-ㅎㅏ-ㅣ가-힣]{2,8}$", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.count)) != nil
        } catch {
            print("Invalid regex pattern: \(error.localizedDescription)")
            return false
        }
    }
}



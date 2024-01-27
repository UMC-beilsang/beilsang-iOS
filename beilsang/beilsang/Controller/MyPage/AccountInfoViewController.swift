//
//  AccountInfoViewController.swift
//  beilsang
//
//  Created by 강희진 on 1/24/24.
//

import Foundation
import UIKit

class AccountInfoViewController: UIViewController, UIScrollViewDelegate {
    // MARK: - Properties
    
    let fullScrollView = UIScrollView()
    let fullContentView = UIView()
    var gender = ["남성", "여성"]
    
    
    lazy var profileImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Mask group")
        image.layer.cornerRadius = 48
        return image
    }()
    lazy var profileShadowView: UIView = {
        let view = UIView()
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 4
//        view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds,
//                               cornerRadius: view.layer.cornerRadius).cgPath
        view.translatesAutoresizingMaskIntoConstraints = false
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
    }()
    lazy var nicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        label.textColor = .black
        label.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        return label
    }()
    lazy var nickNameCircle: UIView = {
        let view = UIView()
        view.backgroundColor = .beWnRed500
        view.layer.cornerRadius = 2
        return view
    }()
    lazy var nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        textField.borderStyle = .roundedRect
        textField.leftPadding()
        textField.keyboardType = .default
        // 자동 수정 활성화 여부
        textField.autocorrectionType = .no
        // 맞춤법 검사 활성화 여부
        textField.spellCheckingType = .no
        // 대문자부터 시작 활성화 여부
        textField.autocapitalizationType = .none
        
        textField.delegate = self
        return textField
    }()
    lazy var dupCheckButton: UIButton = {
        let button = UIButton()
        button.setTitle("중복 확인", for: .normal)
        button.layer.cornerRadius = 8
        // 비활성화 상태일 때
        button.isEnabled = false
        button.setTitleColor(.beBgSub, for: .disabled)
        button.backgroundColor = .beBgDiv
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        
        button.translatesAutoresizingMaskIntoConstraints = false
                button.addTarget(self, action: #selector(duplicateCheck), for: .touchDown)
        return button
    }()
    lazy var systemLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.font = UIFont(name: "NotoSansKR-Medium", size: 11)
        return label
    }()
    lazy var systemImage: UIImageView = {
        let view = UIImageView()
        return view
    }()
    lazy var birthLabel: UILabel = {
        let label = UILabel()
        label.text = "생년월일"
        label.textColor = .black
        label.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        return label
    }()
    lazy var birthCircle: UIView = {
        let view = UIView()
        view.backgroundColor = .beWnRed500
        view.layer.cornerRadius = 2
        return view
    }()
    lazy var birthTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textFieldNormal(textField)
        textField.leftPadding()
        textField.text = dateFormat(date: Date())
        textField.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        // 자동 수정 활성화 여부
        textField.autocorrectionType = .no
        // 맞춤법 검사 활성화 여부
        textField.spellCheckingType = .no
        textField.autocapitalizationType = .none
        
        return textField
    }()
    lazy var birthPicker:  UIDatePicker = {
        let view = UIDatePicker()
        view.backgroundColor = .white
        view.datePickerMode = .date
        view.preferredDatePickerStyle = .wheels
        view.locale = Locale(identifier: "ko-KR")
        // 값이 변할 때마다 dateChange 실행
        view.addTarget(self, action: #selector(dateChange), for: .valueChanged)
        // Done 버튼 추가
        setupBirthToolBar()
        return view
    }()
    lazy var genderLabel: UILabel = {
        let label = UILabel()
        label.text = "성별"
        label.textColor = .black
        label.font = UIFont(name: "NotoSansKR-SemiBold", size: 16)
        return label
    }()
    lazy var genderCircle: UIView = {
        let view = UIView()
        view.backgroundColor = .beWnRed500
        view.layer.cornerRadius = 2
        return view
    }()
    lazy var genderTextField: UITextField = {
        let view = UITextField()
        view.delegate = self
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.beBgDiv.cgColor
        view.autocorrectionType = .no
        view.spellCheckingType = .no
        view.autocapitalizationType = .none
        view.clearButtonMode = .whileEditing
        view.clearsOnBeginEditing = false
        view.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 19.0, height: 0.0))
        view.leftViewMode = .always
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14)
        ]
        view.attributedPlaceholder = NSAttributedString(string: "성별을 입력해주세요.", attributes: attributes)
        view.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        
        return view
    }()
    lazy var genderPickerView : UIPickerView = {
        let view = UIPickerView()
        // Done 버튼 추가
        setupGenderToolBar()
        return view
    }()

    lazy var addressLabel : UILabel = {
        let label = UILabel()
        label.text = "주소"
        label.textColor = .black
        label.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        return label
    }()
    lazy var addressCircle: UIView = {
        let view = UIView()
        view.backgroundColor = .beWnRed500
        view.layer.cornerRadius = 2
        return view
    }()
    lazy var postCodeTextField: UITextField = {
        let textField = UITextField()
        // 입력 방지
        textField.isUserInteractionEnabled = false
        // 자동 수정 활성화 여부
        textField.autocorrectionType = .no
        // 맞춤법 검사 활성화 여부
        textField.spellCheckingType = .no
        textField.borderStyle = .roundedRect
        textField.textColor = .black
        textField.leftPadding()
        textField.text = "04066"
        textField.font = UIFont(name: "NotoSansKR-Medium", size: 14)

        return textField
    }()
    lazy var postCodeButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.setTitle("우편번호 검색", for: .normal)
        button.setTitleColor(UIColor(named: "disabled-grey"), for: .disabled)
        button.backgroundColor = .beBgDiv
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
                button.addTarget(self, action: #selector(duplicateCheck), for: .touchDown)
                
        return button
    }()
    lazy var addressBox1: UITextField = {
        let textField = UITextField()
        // 입력 방지
        textField.isUserInteractionEnabled = false
        // 자동 수정 활성화 여부
        textField.autocorrectionType = .no
        // 맞춤법 검사 활성화 여부
        textField.spellCheckingType = .no
        textField.borderStyle = .roundedRect
        textField.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        return textField
    }()
    lazy var addressBox2: UITextField = {
        let textField = UITextField()
        // 자동 수정 활성화 여부
        textField.autocorrectionType = .no
        // 맞춤법 검사 활성화 여부
        textField.spellCheckingType = .no
        textField.borderStyle = .roundedRect
        textField.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        textField.placeholder = "상세 주소 입력하기"
        textField.leftPadding()
        textField.delegate = self
        return textField
    }()
    
    lazy var line: UIView = {
        let view = UIView()
        view.backgroundColor = .beBgSub
        return view
    }()
    lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그아웃", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        button.addTarget(self, action: #selector(logout), for: .touchDown)
        return button
    }()
    lazy var withdrawButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원탈퇴", for: .normal)
        button.setTitleColor(.beTextEx, for: .normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        button.addTarget(self, action: #selector(withdraw), for: .touchDown)
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
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupAttribute()
        viewConstraint()
        setNavigationBar()
        createPickerView()
    }
}

extension AccountInfoViewController {
    
    func setupAttribute() {
        setFullScrollView()
        setLayout()
        setScrollViewLayout()
    }
    
    func setFullScrollView() {
        fullScrollView.showsVerticalScrollIndicator = true
        fullScrollView.delegate = self
        
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
        [profileShadowView, editProfileImageView, editProfileImageLabel, editProfileImageButton, nicknameLabel, nicknameTextField, dupCheckButton, birthLabel, birthTextField, genderLabel, genderTextField, addressLabel, postCodeTextField, postCodeButton, systemLabel, systemImage, addressBox1, addressBox2, line, logoutButton, withdrawButton, greyBox, privacyPolicy, termsOfUse, bottomBar, nickNameCircle, birthCircle, genderCircle, addressCircle].forEach{view in fullContentView.addSubview(view)}
        
        profileShadowView.addSubview(profileImage)
        // 텍스트필드 입력 수단 연결
        birthTextField.inputView = birthPicker
        genderTextField.inputView = genderPickerView
        
        
    }
    // MARK: - 전체 오토레이아웃 관리
    func viewConstraint(){
        profileImage.snp.makeConstraints { make in
            make.width.equalTo(96)
            make.height.equalTo(96)
            make.centerX.equalTo(profileShadowView)
            make.top.equalTo(profileShadowView)
        }
        profileShadowView.snp.makeConstraints { make in
            make.width.equalTo(96)
            make.height.equalTo(96)
            make.leading.equalToSuperview().offset(super.view.frame.width/2 - 48)
            make.top.equalToSuperview().offset(32)
        }
        editProfileImageView.snp.makeConstraints { make in
            make.width.equalTo(46)
            make.height.equalTo(21)
            make.top.equalTo(profileImage.snp.bottom).offset(16)
            make.centerX.equalTo(profileImage)
        }
        editProfileImageLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(18)
            make.centerX.equalTo(profileImage)
        }
        editProfileImageButton.snp.makeConstraints { make in
            make.width.equalTo(46)
            make.height.equalTo(21)
            make.top.equalTo(profileImage.snp.bottom).offset(16)
            make.centerX.equalTo(profileImage)
        }
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(editProfileImageButton).offset(32)
            make.leading.equalToSuperview().offset(16)
        }
        nicknameTextField.snp.makeConstraints { make in
            make.width.equalTo(254)
            make.height.equalTo(48)
            make.top.equalTo(nicknameLabel.snp.bottom).offset(12)
            make.leading.equalTo(nicknameLabel)
        }
        dupCheckButton.snp.makeConstraints { make in
            make.width.equalTo(96)
            make.height.equalTo(48)
            make.centerY.equalTo(nicknameTextField)
            make.leading.equalTo(nicknameTextField.snp.trailing).offset(8)
        }
        systemLabel.snp.makeConstraints { make in
            make.centerY.equalTo(systemImage)
            make.leading.equalTo(systemImage.snp.trailing).offset(4)
        }
        systemImage.snp.makeConstraints { make in
            make.width.equalTo(14)
            make.height.equalTo(14)
            make.top.equalTo(nicknameTextField.snp.bottom).offset(5)
            make.leading.equalTo(nicknameLabel)
        }
        birthLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(24)
            make.leading.equalTo(nicknameLabel)
        }
        birthTextField.snp.makeConstraints { make in
            make.width.equalTo(358)
            make.height.equalTo(48)
            make.top.equalTo(birthLabel.snp.bottom).offset(12)
            make.leading.equalTo(nicknameLabel)
        }
        genderLabel.snp.makeConstraints { make in
            make.top.equalTo(birthTextField.snp.bottom).offset(24)
            make.leading.equalTo(nicknameLabel)
        }
        genderTextField.snp.makeConstraints { make in
            make.width.equalTo(358)
            make.height.equalTo(48)
            make.top.equalTo(genderLabel.snp.bottom).offset(12)
            make.leading.equalTo(nicknameLabel)
        }        
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(genderTextField.snp.bottom).offset(24)
            make.leading.equalTo(nicknameLabel)
        }
        postCodeTextField.snp.makeConstraints { make in
            make.width.equalTo(254)
            make.height.equalTo(48)
            make.top.equalTo(addressLabel.snp.bottom).offset(12)
            make.leading.equalTo(nicknameLabel)
        }
        postCodeButton.snp.makeConstraints { make in
            make.width.equalTo(96)
            make.height.equalTo(48)
            make.leading.equalTo(postCodeTextField.snp.trailing).offset(8)
            make.centerY.equalTo(postCodeTextField)
        }
        addressBox1.snp.makeConstraints { make in
            make.width.equalTo(358)
            make.height.equalTo(48)
            make.top.equalTo(postCodeTextField.snp.bottom).offset(8)
            make.leading.equalTo(nicknameLabel)
        }
        addressBox2.snp.makeConstraints { make in
            make.width.equalTo(358)
            make.height.equalTo(48)
            make.top.equalTo(addressBox1.snp.bottom).offset(8)
            make.leading.equalTo(nicknameLabel)
        }
        line.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(8)
            make.leading.equalToSuperview()
            make.top.equalTo(addressBox2.snp.bottom).offset(54)
        }
        logoutButton.snp.makeConstraints { make in
            make.leading.equalTo(nicknameLabel)
            make.top.equalTo(line.snp.bottom).offset(24)
        }
        withdrawButton.snp.makeConstraints { make in
            make.leading.equalTo(nicknameLabel)
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
        nickNameCircle.snp.makeConstraints { make in
            make.height.equalTo(4)
            make.width.equalTo(4)
            make.leading.equalTo(nicknameLabel.snp.trailing).offset(2)
            make.top.equalTo(nicknameLabel.snp.top)
        }
        birthCircle.snp.makeConstraints { make in
            make.height.equalTo(4)
            make.width.equalTo(4)
            make.leading.equalTo(birthLabel.snp.trailing).offset(2)
            make.top.equalTo(birthLabel.snp.top)
        }
        genderCircle.snp.makeConstraints { make in
            make.height.equalTo(4)
            make.width.equalTo(4)
            make.leading.equalTo(genderLabel.snp.trailing).offset(2)
            make.top.equalTo(genderLabel.snp.top)
        }
        addressCircle.snp.makeConstraints { make in
            make.height.equalTo(4)
            make.width.equalTo(4)
            make.leading.equalTo(addressLabel.snp.trailing).offset(2)
            make.top.equalTo(addressLabel.snp.top)
        }
    }
// MARK: - 함수
    @objc func dateChange(_ sender: UIDatePicker) {
        birthTextField.text = dateFormat(date: sender.date)
    }
    // 텍스트 필드에 들어갈 텍스트를 DateFormatter 변환
    private func dateFormat(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy . MM . dd"
        
        return formatter.string(from: date)
    }
    private func setupBirthToolBar() {
        
        let toolBar = UIToolbar()
        toolBar.updateConstraintsIfNeeded()
        // flexibleSpace: done 버튼을 맨 끝으로 보내기 위한 item
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(birthDoneButtonHandeler))
        toolBar.items = [flexibleSpace, doneButton]
            
        // 적절한 사이즈로 toolBar의 크기를 만들어 줍니다.
        toolBar.sizeToFit()
        // textField의 경우 클릭 시 키보드 위에 AccessoryView가 표시된다고 합니다.
        // 현재 inputView를 datePicker로 만들어 줬으니 datePicker위에 표시되겠죠?
        birthTextField.inputAccessoryView = toolBar
    }
    private func setupGenderToolBar() {
        
        let toolBar = UIToolbar()
        toolBar.updateConstraintsIfNeeded()
        // flexibleSpace: done 버튼을 맨 끝으로 보내기 위한 item
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(genderDoneButtonHandeler))
        toolBar.items = [flexibleSpace, doneButton]
        // 적절한 사이즈로 toolBar의 크기를 만들어 줍니다.
        toolBar.sizeToFit()
        // textField의 경우 클릭 시 키보드 위에 AccessoryView가 표시된다고 합니다.
        // 현재 inputView를 datePicker로 만들어 줬으니 datePicker위에 표시되겠죠?
        genderTextField.inputAccessoryView = toolBar
    }
    @objc func birthDoneButtonHandeler(_ sender: UIBarButtonItem) {
        birthTextField.text = dateFormat(date: birthPicker.date)
        // 키보드 내리기
        birthTextField.resignFirstResponder()
    }
    @objc func genderDoneButtonHandeler(_ sender: UIBarButtonItem) {
        // 키보드 내리기
        genderTextField.resignFirstResponder()
    }
    @objc private func duplicateCheck() -> Bool {
        print("duplicate button tapped")
        nicknameSuccess("사용 가능한 닉네임입니다.")
        return true
    }
    func buttonFieldSelected(_ button: UIButton){
        // textField 파랗게
        button.layer.borderColor = UIColor.bePsBlue500.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        button.backgroundColor = .bePsBlue100
        button.titleLabel?.textColor = .bePsBlue500
    }
    func selectingNickname(){
        setButton(dupCheckButton, true)
        systemImage.isHidden = true
        systemLabel.isHidden = true
    }
    @objc func logout(){
        print("로그아웃")
        
    }
    @objc func withdraw(){
        print("회원 탈퇴")
        
    }
// MARK: - PickerView
    
    private func createPickerView() {
        /// 피커 세팅
        genderPickerView.delegate = self
        genderPickerView.dataSource = self
        genderTextField.tintColor = .clear
            
    }
}

// 텍스트필드 placeholder 왼쪽에 padding 추가
extension UITextField{
    func leftPadding() {
        // 1
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 19, height: self.frame.height))
        // 2
        self.leftView = paddingView
        // 3
        self.leftViewMode = ViewMode.always
    }
}


            
// MARK: - 네비게이션 바 커스텀
extension AccountInfoViewController{
    private func setNavigationBar() {
        self.navigationItem.titleView = attributeTitleView()
//        navigationController?.navigationBar.shadowImage = UIImage()
        setBackButton()
        
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
    func setBackButton() {
        let leftBarButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon-navigation"), style: .plain, target: self, action: #selector(tabBarButtonTapped))
        // 기존 barbutton이미지 이용할 때 -> (barButtonSystemItem: ., target: self, action: #selector(tabBarButtonTapped))
        leftBarButton.tintColor = .black
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    // 백버튼 액션
    @objc func tabBarButtonTapped() {
            print("뒤로 가기")
    }
}
// MARK: - UITextFieldDelegate
extension AccountInfoViewController: UITextFieldDelegate {
    // 엔터키가 눌러졌을때 호출 (동작할지 말지 물어보는 것)
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 키보드 내리기
        textField.resignFirstResponder()
            return true
        }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            view.endEditing(true)
        }
    // 글자수 검사 & 유효성 검사
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == nicknameTextField{
            // 백스페이스 실행가능하게 하게하기
            if let char = string.cString(using: String.Encoding.utf8) {
                let isBackSpace = strcmp(char, "\\b")
                if (isBackSpace == -92) {
                    selectingNickname()
                    textFieldSelected(textField)
                    return true
                }
            }
            guard textField.text!.count <= 8 else {
                nicknameError("닉네임은 2~8자 이내로 입력해 주세요.")
                return false
            }
            guard string.hasCharacters() else {
                nicknameError("닉네임은 한글, 영어 대소문자, 숫자만 가능합니다.")
                return false
            }
            selectingNickname()
            textFieldSelected(textField)
        }
        return true
    }
    // 입력을 시작할 때 호출
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == nicknameTextField {
            setButton(dupCheckButton, true)
        }
        textFieldSelected(textField)

        // 선택된 textField를 제외한 나머지 Normal 처리
        [self.nicknameTextField, self.birthTextField, self.genderTextField, self.addressBox2].forEach{ view in
            if textField != view {
                textFieldNormal(view)
            }
        }

        systemImage.isHidden = true
        systemLabel.isHidden = true
        return true
    }
    // 입력이 끝날 때 호출, 닉네임 길이 확인
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if textField == nicknameTextField {
            if nicknameTextField.text!.count <= 1 {
                nicknameError("닉네임은 2~8자 이내로 입력해 주세요.")
                textFieldNormal(birthTextField)
                textFieldNormal(genderTextField)
                return false
            }
        }
        return true
    }
    func nicknameError(_ message: String) {
        // 에러 메세지 출력
        systemLabel.isHidden = false
        systemImage.isHidden = false
        systemLabel.text = message
        systemLabel.textColor = .beWnRed500
        systemImage.image = UIImage(named: "icon-attention")
        systemImage.tintColor = .beWnRed500
        
        // textField 빨갛게
        nicknameTextField.layer.borderColor = UIColor.beWnRed500.cgColor
        nicknameTextField.layer.borderWidth = 1
        nicknameTextField.layer.cornerRadius = 8
        nicknameTextField.backgroundColor = .beWnRed100
        nicknameTextField.textColor = .beWnRed500
        
        setButton(dupCheckButton, false)
    }
    func textFieldSelected(_ textField: UITextField){
        // textField 파랗게
        textField.layer.borderColor = UIColor.beScPurple500.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 8
        textField.backgroundColor = .bePsBlue100
        textField.textColor = .beScPurple500
    }
    func textFieldNormal(_ textField: UITextField){
        // textField 베이지색
        textField.layer.borderColor = UIColor.beBgDiv.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 8
        textField.backgroundColor = .white
        textField.textColor = .black
        if textField == nicknameTextField {
            setButton(dupCheckButton, false)
        }
    }
    func setButton(_ button: UIButton, _ enabled: Bool){
        if enabled{
            // 중복 체크 버튼 활성화
            dupCheckButton.isEnabled = true
            dupCheckButton.setTitleColor(.white, for: .normal)
            dupCheckButton.backgroundColor = .beScPurple600
        }else{
            // 중복 체크 버튼 비활성화
            dupCheckButton.isEnabled = false
            dupCheckButton.setTitleColor(.beBgSub, for: .disabled)
            dupCheckButton.backgroundColor = .beBgDiv
        }
    }
    func nicknameSuccess(_ message: String){
        // 성공 메세지 출력
        systemLabel.isHidden = false
        systemImage.isHidden = false
        systemLabel.text = message
        systemLabel.textColor = .beScPurple500
        systemImage.image = .iconCheck
        systemImage.tintColor = .beScPurple500
    }
}
extension String{
    // 한글 숫자 영문 특수문자 포함 정규식 (이모티콘 제외)
    func hasCharacters() -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[a-zA-z0-9ㄱ-ㅎㅏ-ㅣ가-힣]$", options: .caseInsensitive)
            if let _ = regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, self.count)) {
                return true
            }
        }catch {
            print("Invalid regex pattern: \(error.localizedDescription)")
            return false
        }
        return false
    }
}
extension AccountInfoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 /// 년, 월 두 가지 선택하는 피커뷰
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
    
    /// 표출할 텍스트 (2020년, 2021년 / 1월, 2월, 3월, 4월 ... )
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        genderTextField.text = gender[row]
        return gender[row]
    }
}

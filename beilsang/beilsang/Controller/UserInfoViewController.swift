//
//  UserInfoViewController.swift
//  beilsang
//
//  Created by Seyoung on 1/29/24.
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
    
    private var isProgressBarVisible = true
    private var lastContentOffset: CGFloat = 0
    
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
        
        //키보드 관련 설정
        view.returnKeyType = .done
        view.keyboardType = UIKeyboardType.namePhonePad
        view.resignFirstResponder()
        
        
        return view
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .beScPurple600
        button.setTitle("다음으로", for: .normal)
        button.setTitleColor(.beTextWhite, for: .normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = true
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
        verticalContentView.addSubview(nextButton)
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
        
        let height = UIScreen.main.bounds.height
        
        verticalContentView.snp.makeConstraints { make in
            make.edges.equalTo(verticalScrollView.contentLayoutGuide)
            make.width.equalTo(verticalScrollView.frameLayoutGuide)
            make.height.equalTo(height * 3)
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
        
        nameDuplicateButton.snp.makeConstraints{ make in
            make.top.equalTo(nameField)
            make.leading.equalTo(nameField.snp.trailing).offset(8)
            make.height.equalTo(nameField)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        birthLabel.snp.makeConstraints{ make in
            make.top.equalTo(nameField.snp.bottom).offset(24)
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
        
        nextButton.snp.makeConstraints{ make in
            make.bottom.equalToSuperview().offset(-100)
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
    
    // MARK: - textField
    
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
        // UIDatePicker 객체 생성을 해줍니다.
        let datePicker = UIDatePicker()
        // datePickerModed에는 time, date, dateAndTime, countDownTimer가 존재합니다.
        datePicker.datePickerMode = .date
        // datePicker 스타일을 설정합니다. wheels, inline, compact, automatic이 존재합니다.
        datePicker.preferredDatePickerStyle = .wheels
        // 원하는 언어로 지역 설정도 가능합니다.
        datePicker.locale = Locale(identifier: "ko-KR")
        // 값이 변할 때마다 동작을 설정해 줌
        datePicker.addTarget(self, action: #selector(dateChange), for: .valueChanged)
        // textField의 inputView가 nil이라면 기본 할당은 키보드입니다.
        birthField.inputView = datePicker
        // textField에 오늘 날짜로 표시되게 설정
        //birthField.text = dateFormat(date: Date())
    }
    
    private func dateFormat(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        
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
    
    // MARK: - Button Disabled
    
    /*private func selectedMoto(for cell: MotoCollectionViewCell) {
     let check = cell.isSelected
     
     if check {
     nextButton.isEnabled = true
     nextButton.backgroundColor = .beScPurple600
     } else {
     nextButton.isEnabled = false
     nextButton.backgroundColor = .beScPurple400
     // 필요한 경우 check 변수 사용 또는 반환 등을 진행
     }
     }
     */
    
    // MARK: - Actions
    
    @objc private func nextAction() {
        let routeViewController = RouteViewController()
        
        self.navigationController?.pushViewController(routeViewController, animated: true)
        /*
        UIView.transition(with: self.view.window!,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: {
            self.navigationController?.pushViewController(routeViewController, animated: false)
        },
                          completion: nil)
         */
    }
    
    @objc private func handleTap() {
        view.endEditing(true)
    }
    
    @objc private func duplicateCheck() {
        print("duplicate button tapped")
        
    }
    
    @objc private func zipCodeSearch() {
        kakaoZipCodeVC.userInfoVC = self // self는 UserInfoViewController 인스턴스여야 합니다.
        present(kakaoZipCodeVC, animated: true)
        
    }
    
    @objc private func zipCodeFieldTapped() {
            zipCodeSearch()
        }
    
    @objc private func addressFieldTapped() {
            zipCodeSearch()
        }
    
    @objc func dateChange(_ sender: UIDatePicker) {
        // 값이 변하면 UIDatePicker에서 날자를 받아와 형식을 변형해서 textField에 넣어줍니다.
        birthField.text = dateFormat(date: sender.date)
        birthField.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        birthField.textColor = .bePsBlue500
    }
    
    @objc func doneButtonHandeler(_ sender: UIBarButtonItem) {
        //birthField.text = dateFormat(date: datePicker.date)
        // 키보드 내리기
        birthField.resignFirstResponder()
        genderField.resignFirstResponder()
    }
}

extension UserInfoViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        
        // 맨 위로 스크롤될 때 네비게이션 바를 다시 표시
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
        else if textField == birthField {
            
        }
            
            return true
        }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == nameField  {
            nameField.layer.borderColor = UIColor.bePsBlue500.cgColor
            nameField.layer.backgroundColor = UIColor.bePsBlue100.cgColor
            nameField.textColor = UIColor.bePsBlue500
            nameField.setPlaceholderColor(.bePsBlue500)
        }
        else if textField == birthField {
            birthField.layer.borderColor = UIColor.bePsBlue500.cgColor
            birthField.layer.backgroundColor = UIColor.bePsBlue100.cgColor
            birthField.textColor = UIColor.bePsBlue500
            birthField.setPlaceholderColor(.bePsBlue500)
        }
        else if textField == genderField {
            genderField.layer.borderColor = UIColor.bePsBlue500.cgColor
            genderField.layer.backgroundColor = UIColor.bePsBlue100.cgColor
            genderField.textColor = UIColor.bePsBlue500
            genderField.setPlaceholderColor(.bePsBlue500)
        }
        else if textField == addressDetailField {
            addressDetailField.layer.borderColor = UIColor.bePsBlue500.cgColor
            addressDetailField.layer.backgroundColor = UIColor.bePsBlue100.cgColor
            addressDetailField.textColor = UIColor.bePsBlue500
            addressDetailField.setPlaceholderColor(.bePsBlue500)
        }
    }
   
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == nameField {
            nameField.layer.borderColor = UIColor.beBorderDis.cgColor
            nameField.layer.backgroundColor = UIColor.clear.cgColor
            nameField.textColor = UIColor.beTextDef
            nameField.setPlaceholderColor(.beTextEx)
            
            nameDuplicateButton.isEnabled = true
            nameDuplicateButton.setTitleColor(.beTextWhite, for: .normal)
            nameDuplicateButton.backgroundColor = .beScPurple600
        }
        else if textField == birthField {
            birthField.layer.borderColor = UIColor.beBorderDis.cgColor
            birthField.layer.backgroundColor = UIColor.clear.cgColor
            birthField.textColor = UIColor.beTextDef
            birthField.setPlaceholderColor(.beTextEx)
        }
        else if textField == genderField {
            genderField.layer.borderColor = UIColor.beBorderDis.cgColor
            genderField.layer.backgroundColor = UIColor.clear.cgColor
            genderField.textColor = UIColor.beTextDef
            genderField.setPlaceholderColor(.beTextEx)
        }
        else if textField == addressDetailField {
            addressDetailField.layer.borderColor = UIColor.beBorderDis.cgColor
            addressDetailField.layer.backgroundColor = UIColor.clear.cgColor
            addressDetailField.textColor = UIColor.beTextDef
            addressDetailField.setPlaceholderColor(.beTextEx)
        }
        
        return true
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


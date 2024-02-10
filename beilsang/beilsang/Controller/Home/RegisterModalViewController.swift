//
//  RegisterModalViewController.swift
//  beilsang
//
//  Created by 곽은채 on 2/2/24.
//

import SnapKit
import UIKit

class RegisterModalViewController: UIViewController {
    
    // MARK: - properties
    // 모달 제외 뷰(모달 아닌 부분 클릭하면 dismiss 모달)
    lazy var notModalView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 33.0/255.0)
        
        return view
    }()
    
    // 모달 전체 뷰
    lazy var modalView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        
        return view
    }()
    
    // 유의사항 등록 제목 레이블
    lazy var noticeRegisterLabel: UILabel = {
        let view = UILabel()
        
        view.text = "챌린지 인증 유의사항 등록"
        view.textColor = .beTextSub
        view.textAlignment = .left
        view.font = UIFont(name: "NotoSansKR-SemiBold", size: 18)
        
        return view
    }()
    
    // 유의사항 등록 텍스트필드
    lazy var noticeRegisterField = customTextField(textFieldText: "챌린지 유의사항을 30자 이내로 입력해 주세요")
    
    // 유의사항 등록 버튼
    lazy var noticeRegisterButton: UIButton = {
        let view = UIButton()
        
        view.backgroundColor = .beScPurple400
        view.layer.cornerRadius = 10
        view.setTitle("등록하기", for: .normal)
        view.setTitleColor(.beTextWhite, for: .normal)
        view.titleLabel?.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        view.addTarget(self, action: #selector(noticeRegisterButtonClicked), for: .touchUpInside)
        
        return view
    }()
    
    // 텍스트필드 텍스트 넘길 변수
    var completion: ((String) -> Void)?
    
    // MARK: - lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        
        setAttribute()
        setTextField()
    }
    
    // MARK: - Actions
    @objc func noticeRegisterButtonClicked() {
        if let text = noticeRegisterField.text {
            completion?(text)
        }
        noticeRegisterField.resignFirstResponder()
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.view.frame.origin.y = -keyboardHeight
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    @objc func dismissModal(gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: self.view)
        if !modalView.frame.contains(location) {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

// MARK: - layout setting
extension RegisterModalViewController {
    func setAttribute() {
        setModalKeyboard()
        setUI()
        setAddViews()
        setLayout()
    }
    
    func setUI() {
        noticeRegisterButton.isEnabled = false
        
        // 탭 제스처 인식기 생성 및 등록
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissModal(gesture:)))
        notModalView.addGestureRecognizer(tapGesture)
    }
    
    func setModalKeyboard() {
        // 키보드 알림 등록
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setAddViews() {
        view.addSubview(notModalView)
        view.addSubview(modalView)
        
        [noticeRegisterLabel, noticeRegisterField, noticeRegisterButton].forEach { view in
            modalView.addSubview(view)
        }
    }
    
    func setLayout() {
        notModalView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        modalView.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view)
            make.left.right.equalTo(self.view)
            make.height.equalTo(250)
        }
        
        noticeRegisterLabel.snp.makeConstraints { make in
            make.top.equalTo(modalView.snp.top).offset(24)
            make.leading.equalTo(modalView.snp.leading).offset(16)
        }
        
        noticeRegisterField.snp.makeConstraints { make in
            make.top.equalTo(noticeRegisterLabel.snp.bottom).offset(12)
            make.leading.equalTo(modalView.snp.leading).offset(16)
            make.centerX.equalTo(modalView.snp.centerX)
            make.height.equalTo(48)
        }
        
        noticeRegisterButton.snp.makeConstraints { make in
            make.top.equalTo(noticeRegisterField.snp.bottom).offset(60)
            make.leading.equalTo(modalView.snp.leading).offset(16)
            make.centerX.equalTo(modalView.snp.centerX)
            make.height.equalTo(56)
        }
    }
}

// MARK: - 텍스트필드 설정
extension RegisterModalViewController: UITextFieldDelegate {
    // MARK: - 텍스트 필드 설정
    func setTextField() {
        noticeRegisterField.delegate = self
        
        // 화면 터치시 키보드 내려감
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    // 텍스트필드 입력 관련
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        // 텍스트필드의 텍스트 개수에 따른 동작
        if updatedText.count < 1 || updatedText.count > 30 {
            noticeRegisterButton.backgroundColor = .beScPurple400
            noticeRegisterButton.isEnabled = false
            return updatedText.count <= 30
        } else {
            noticeRegisterButton.backgroundColor = .beScPurple600
            noticeRegisterButton.isEnabled = true
            return true
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        noticeRegisterField.textColor = UIColor.bePsBlue500
        noticeRegisterField.layer.borderColor = UIColor.bePsBlue500.cgColor
        noticeRegisterField.backgroundColor = .bePsBlue100
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        noticeRegisterField.textColor = UIColor.bePsBlue500
    }
    
    // MARK: - 툴바 설정
    func setupToolBar() {
        let toolBar = UIToolbar()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonHandeler))
        
        toolBar.items = [flexibleSpace, doneButton]
        // 적절한 사이즈로 toolBar의 크기를 만들어 줍니다.
        toolBar.sizeToFit()
        
        noticeRegisterField.inputAccessoryView = toolBar
    }
    
    // MARK: - actions
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    // 키보드 내리기
    @objc func doneButtonHandeler(_ sender: UIBarButtonItem) {
        noticeRegisterField.resignFirstResponder()
    }
    
    // MARK: - 텍스트 필드 커스텀 함수
    func customTextField(textFieldText: String) -> UITextField {
        let customField: UITextField = {
            let view = UITextField()
            
            view.layer.cornerRadius = 8
            view.layer.borderWidth = 1
            view.layer.borderColor = UIColor.beBorderDis.cgColor
            view.backgroundColor = .beBgCard
            
            view.autocorrectionType = .no
            view.spellCheckingType = .no
            view.autocapitalizationType = .none
            view.clearButtonMode = .never
            view.clearsOnBeginEditing = false
            
            view.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 19.0, height: 0.0))
            view.leftViewMode = .always
            let placeholderText = textFieldText
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 14),
                .foregroundColor: UIColor.beTextEx
            ]
            view.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
            view.font = UIFont(name: "NotoSansKR-Regular", size: 14)
            view.tintColor = .clear // 커서 지우기
            
            view.returnKeyType = .done
            
            return view
        }()
        
        return customField
    }
}

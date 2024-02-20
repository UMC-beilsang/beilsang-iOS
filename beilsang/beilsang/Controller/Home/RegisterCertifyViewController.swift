//
//  RegisterCertifyViewController.swift
//  beilsang
//
//  Created by 곽은채 on 2/6/24.
//

import SnapKit
import UIKit

// [홈] 챌린지 인증 화면
class RegisterCertifyViewController: UIViewController {
    
    // MARK: - properties
    // 네비게이션 바 - 네비게이션 버튼
    lazy var navigationButton: UIBarButtonItem = {
        let view = UIBarButtonItem(image: UIImage(named: "icon-navigation"), style: .plain, target: self, action: #selector(navigationButtonClicked))
        view.tintColor = .beIconDef
        
        return view
    }()
    
    // 네비게이션 바 - 레이블
    lazy var makeChallengeLabel: UILabel = {
        let view = UILabel()
        
        view.text = "챌린지 인증하기"
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
    
    // 인증하기 버튼 활성화를 위한 변수
    var isNext = [false, false]
    
    // 인증 사진 등록 레이블
    lazy var certifyPhotoLabel = customLabelView(labelText: "인증사진")
    
    // 인증 사진 등록하기 이미지 피커
    let certifyImagePicker = UIImagePickerController()
    
    // 인증 사진 등록 버튼
    lazy var certifyPhotoButton: UIButton = {
        let view = UIButton()
        
        view.backgroundColor = .beBgCard
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.beBorderDis.cgColor
        view.addTarget(self, action: #selector(certifyPhotoButtonClicked), for: .touchUpInside)
        
        return view
    }()
    
    // 인증 사진 등록 버튼 이미지
    lazy var certifyPhotoButtonImage: UIImageView = {
        let view = UIImageView()
        
        view.image = UIImage(named: "camera")
        view.contentMode = .center
        view.tintColor = .beIconDef
        
        return view
    }()
    
    // 인증 사진 등록 버튼 레이블
    lazy var certifyPhotoButtonLabel: UILabel = {
        let view = UILabel()
        
        view.text = "사진 등록하기\n0/1"
        view.textColor = .beTextSub
        view.textAlignment = .center
        view.numberOfLines = 2
        view.font = UIFont(name: "NotoSansKR-Medium", size: 12)
        
        return view
    }()
    
    // 인증 사진 등록 후 이미지
    lazy var certifyPhotoImage: UIImageView = {
        let view = UIImageView()
        
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.backgroundColor = .beBgCard
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.beBorderDis.cgColor
        view.isUserInteractionEnabled = true
        
        return view
    }()
    
    // 인증 사진 등록 취소 버튼
    lazy var photoCloseButton: UIButton = {
        let view = UIButton()
        
        view.setImage(UIImage(named: "icon-close-circle"), for: .normal)
        view.addTarget(self, action: #selector(photoCloseButtonClicked), for: .touchUpInside)
        
        return view
    }()
    
    // 후기 선택 레이블
    lazy var reviewLabel = customLabelView(labelText: "후기")
    
    let textViewPlaceHolder = "후기를 20~80자 이내로 입력해 주세요"
    // 후기 텍스트필드
    lazy var reviewTextView: UITextView = {
        let view = UITextView()
        
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.beBorderDis.cgColor
        view.backgroundColor = .beBgCard
        
        view.isEditable = true // 편집 가능하게 설정
        view.isScrollEnabled = true // 스크롤 가능하게 설정
        view.autocorrectionType = .no // 자동 수정 활성화 여부
        view.spellCheckingType = .no // 맞춤법 검사 활성화 여부
        view.autocapitalizationType = .none // 대문자부터 시작 활성화 여부
        
        view.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        view.textColor = .beTextEx
        view.text = textViewPlaceHolder
        
        view.textContainerInset = UIEdgeInsets(top: 14, left: 19, bottom: 14, right: 19)
        
        return view
    }()
    
    // 후기 텍스트필드 안내 레이블 이미지
    lazy var reviewFieldAlertImage: UIImageView = {
        let view = UIImageView()
        
        view.image = UIImage(named: "icon_information-circle")
        view.contentMode = .center
        
        return view
    }()
    
    // 후기 텍스트필드 안내 레이블 이미지
    lazy var reviewFieldAlertLabel: UILabel = {
        let view = UILabel()
        
        view.text = "글자수 안내 레이블입니다"
        view.textColor = .beWnRed500
        view.textAlignment = .left
        view.numberOfLines = 1
        view.font = UIFont(name: "NotoSansKR-Light", size: 11)
        
        return view
    }()
    
    // 인증글 작성시 유의사항 전체 뷰
    lazy var certifyNoticeView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .beBgSub
        
        return view
    }()
    
    // 인증글 작성시 유의사항 제목
    lazy var certifyNoticeViewTitleLabel: UILabel = {
        let view = UILabel()
        
        view.text = "인증글 작성시 유의사항"
        view.textColor = .beTextEx
        view.textAlignment = .left
        view.font = UIFont(name: "NotoSansKR-Medium", size: 12)
        
        return view
    }()
    
    // 인증글 작성시 유의사항 1
    lazy var certifyNoticeView1Label: UILabel = {
        let view = UILabel()
        
        view.text = "1. 욕설, 챌린지와 관련 없는 내용은 통보 없이 삭제됩니다."
        view.textColor = .beTextEx
        view.textAlignment = .left
        view.font = UIFont(name: "NotoSansKR-Regular", size: 12)
        
        return view
    }()
    
    // 인증글 작성시 유의사항 2
    lazy var certifyNoticeView2Label: UILabel = {
        let view = UILabel()
        
        view.text = "2. 인증 가이드라인에 따르지 않은 사진을 업로드하면 인증 실패로 간주됩\n니다."
        view.textColor = .beTextEx
        view.textAlignment = .left
        view.numberOfLines = 2
        view.font = UIFont(name: "NotoSansKR-Regular", size: 12)
        
        return view
    }()
    
    // 인증글 작성시 유의사항 3
    lazy var certifyNoticeView3Label: UILabel = {
        let view = UILabel()
        
        view.text = "3. 동일 이미지 중복 사용시 인증 실패로 간주됩니다."
        view.textColor = .beTextEx
        view.textAlignment = .left
        view.font = UIFont(name: "NotoSansKR-Regular", size: 12)
        
        return view
    }()
    
    // 인증하기 전체 뷰
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
    
    // 다음으로 버튼
    lazy var certifyButton: UIButton = {
        let view = UIButton()
        
        view.setTitle("인증하기", for: .normal)
        view.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        view.setTitleColor(.beTextWhite, for: .normal)
        view.backgroundColor = .beScPurple300
        view.layer.cornerRadius = 10
        view.addTarget(self, action: #selector(certifyButtonClicked), for: .touchUpInside)
        
        return view
    }()
    
    var reviewChallengeId : Int? = nil
    var challengeCertify : ChallengeCertify? = nil

    // MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        setModal()
        
        setupAttribute()
        setImagePicker()
        setTextView()
        setupToolBar()
    }
    
    // MARK: - actions
    @objc func navigationButtonClicked() {
        print("이전으로")
        navigationController?.popViewController(animated: true)
    }
    
    @objc func certifyPhotoButtonClicked() {
        // 사용자가 사진 또는 카메라 중 선택할 수 있는 액션 시트 표시
        let alert = UIAlertController(title: nil, message: "사진을 선택하세요", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "사진 앨범", style: .default, handler: { _ in
            self.openGallery(imagePicker: self.certifyImagePicker)
        }))
        alert.addAction(UIAlertAction(title: "카메라", style: .default, handler: { _ in
            self.openCamera(imagePicker: self.certifyImagePicker)
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc func photoCloseButtonClicked() {
        certifyPhotoImage.isHidden = true
        certifyPhotoButtonLabel.text = "사진 등록하기\n0/1"
        
        isNext[0] = false
        updateCertifyButtonState()
    }
    
    @objc func certifyButtonClicked() {
        print("인증하기")
        
        guard let image = certifyPhotoImage.image else { return }
        let imageData = image.jpegData(compressionQuality: 0.5)
        ChallengeCertifySingleton.shared.image = imageData
        ChallengeCertifySingleton.shared.review = reviewTextView.text
        
        reviewPost()
        
        ChallengeCertifySingleton.shared.resetData()
        
        // 인증하기 눌렀던 챌린지 세부화면으로(popnavigation)
        let nextVC = TabBarViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

// MARK: - Layout setting
extension RegisterCertifyViewController {
    
    func setModal() {
        let modalVC = RegisterCertifyModalViewController()
        modalVC.reviewModalChallengeId = reviewChallengeId
        modalVC.modalPresentationStyle = .overCurrentContext
        present(modalVC, animated: true, completion: nil)
    }
    
    func setupAttribute() {
        setNavigationBar()
        setUI()
        setAddViews()
        setLayout()
    }
    
    func setUI() {
        certifyPhotoImage.isHidden = true
        reviewFieldAlertImage.isHidden = true
        reviewFieldAlertLabel.isHidden = true
        
        certifyButton.isEnabled = false
    }
    
    func setNavigationBar() {
        navigationItem.titleView = makeChallengeLabel
        navigationItem.leftBarButtonItem = navigationButton
    }
    
    func updateCertifyButtonState() {
        if isNext.allSatisfy({ $0 }) {
            certifyButton.backgroundColor = .beScPurple600
            certifyButton.isEnabled = true
        } else {
            certifyButton.isEnabled = false
            certifyButton.backgroundColor = .beScPurple400
        }
    }
    
    func setAddViews() {
        [topViewBorder, certifyPhotoLabel, certifyPhotoImage, certifyPhotoButton, reviewLabel, reviewTextView, reviewFieldAlertImage, reviewFieldAlertLabel, certifyNoticeView, bottomView].forEach { view in
            self.view.addSubview(view)
        }
        
        [certifyPhotoButtonImage, certifyPhotoButtonLabel].forEach { view in
            certifyPhotoButton.addSubview(view)
        }
        
        certifyPhotoImage.addSubview(photoCloseButton)
        
        [certifyNoticeViewTitleLabel, certifyNoticeView1Label, certifyNoticeView2Label, certifyNoticeView3Label].forEach { view in
            certifyNoticeView.addSubview(view)
        }
        
        bottomView.addSubview(certifyButton)
    }
    
    func setLayout() {        
        topViewBorder.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.width.equalToSuperview()
            make.height.equalTo(1)
        }
        
        certifyPhotoLabel.snp.makeConstraints { make in
            make.top.equalTo(topViewBorder.snp.top).offset(32)
            make.leading.equalTo(view.snp.leading).offset(16)
            make.height.equalTo(23)
        }
        
        certifyPhotoButton.snp.makeConstraints { make in
            make.top.equalTo(certifyPhotoLabel.snp.bottom).offset(12)
            make.leading.equalTo(view.snp.leading).offset(16)
            make.width.equalTo(120)
            make.height.equalTo(120)
        }
        
        certifyPhotoButtonImage.snp.makeConstraints { make in
            make.top.equalTo(certifyPhotoButton.snp.top).offset(25)
            make.width.height.equalTo(32)
            make.centerX.equalTo(certifyPhotoButton.snp.centerX)
        }
        
        certifyPhotoButtonLabel.snp.makeConstraints { make in
            make.top.equalTo(certifyPhotoButtonImage.snp.bottom).offset(4)
            make.centerX.equalTo(certifyPhotoButton.snp.centerX)
        }
        
        certifyPhotoImage.snp.makeConstraints { make in
            make.top.equalTo(certifyPhotoButton.snp.top)
            make.leading.equalTo(certifyPhotoButton.snp.trailing).offset(8)
            make.width.height.equalTo(120)
        }
        
        photoCloseButton.snp.makeConstraints { make in
            make.top.equalTo(certifyPhotoImage.snp.top).offset(4)
            make.trailing.equalTo(certifyPhotoImage.snp.trailing).offset(-4)
            make.width.height.equalTo(24)
        }
        
        reviewLabel.snp.makeConstraints { make in
            make.top.equalTo(certifyPhotoButton.snp.bottom).offset(24)
            make.leading.equalTo(view.snp.leading).offset(16)
            make.height.equalTo(23)
        }
        
        reviewTextView.snp.makeConstraints { make in
            make.top.equalTo(reviewLabel.snp.bottom).offset(12)
            make.leading.equalTo(reviewLabel.snp.leading)
            make.trailing.equalTo(view.snp.trailing).offset(-16)
            make.width.height.equalTo(112)
        }
        
        reviewFieldAlertImage.snp.makeConstraints { make in
            make.top.equalTo(reviewTextView.snp.bottom).offset(4)
            make.leading.equalTo(reviewLabel.snp.leading)
            make.width.height.equalTo(14)
        }
        
        reviewFieldAlertLabel.snp.makeConstraints { make in
            make.top.equalTo(reviewFieldAlertImage.snp.top)
            make.leading.equalTo(reviewFieldAlertImage.snp.trailing).offset(4)
            make.centerY.equalTo(reviewFieldAlertImage.snp.centerY)
        }
        
        certifyNoticeView.snp.makeConstraints { make in
            make.top.equalTo(reviewTextView.snp.bottom).offset(60)
            make.width.equalToSuperview()
            make.height.equalTo(228)
        }
        
        certifyNoticeViewTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(certifyNoticeView.snp.top).offset(16)
            make.leading.equalTo(view.snp.leading).offset(16)
        }
        
        certifyNoticeView1Label.snp.makeConstraints { make in
            make.top.equalTo(certifyNoticeViewTitleLabel.snp.bottom).offset(8)
            make.leading.equalTo(certifyNoticeViewTitleLabel.snp.leading)
        }
        
        certifyNoticeView2Label.snp.makeConstraints { make in
            make.top.equalTo(certifyNoticeView1Label.snp.bottom).offset(4)
            make.leading.equalTo(certifyNoticeViewTitleLabel.snp.leading)
        }
        
        certifyNoticeView3Label.snp.makeConstraints { make in
            make.top.equalTo(certifyNoticeView2Label.snp.bottom).offset(4)
            make.leading.equalTo(certifyNoticeViewTitleLabel.snp.leading)
        }
        
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(certifyNoticeView.snp.bottom)
            make.bottom.equalTo(view.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(80)
        }
        
        certifyButton.snp.makeConstraints { make in
            make.centerY.equalTo(bottomView.snp.centerY)
            make.trailing.equalTo(bottomView.snp.trailing).offset(-32)
            make.height.equalTo(52)
            make.width.equalTo(160)
        }
    }
}

// MARK: - 이미지 피커 설정
extension RegisterCertifyViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func setImagePicker() {
        certifyImagePicker.delegate = self
    }
    
    func openGallery(imagePicker: UIImagePickerController) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func openCamera(imagePicker: UIImagePickerController) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        } else {
            print("카메라를 사용할 수 없습니다.")
        }
    }
    
    // 이미지 피커에서 이미지를 선택한 후 호출되는 메소드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            if picker == certifyImagePicker {
                // imagePicker1에서 선택한 이미지를 사용하는 코드
                certifyPhotoImage.image = image
                certifyPhotoImage.isHidden = false  // 이미지 뷰 표시
                certifyPhotoButtonLabel.text = "사진 등록하기\n1/1"
                isNext[0] = true
                updateCertifyButtonState()
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    // 이미지 피커에서 취소 버튼을 누른 후 호출되는 메소드
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

// MARK: - 텍스트뷰 설정
extension RegisterCertifyViewController: UITextViewDelegate {
    func setTextView() {
        reviewTextView.delegate = self
        
        // 화면 터치시 키보드 내려감
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    // 텍스트뷰 입력 관련
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
                
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        
        // 텍스트뷰 글자 개수에 따른 동작
        if updatedText.count < 20 {
            reviewTextView.textColor = UIColor.beRed500
            reviewTextView.layer.borderColor = UIColor.beRed500.cgColor
            reviewTextView.backgroundColor = .beRed100
            
            reviewFieldAlertImage.isHidden = false
            reviewFieldAlertLabel.isHidden = false
            reviewFieldAlertLabel.text = "후기는 20자 이상이어야 합니다."
            
            isNext[1] = false
        } else if updatedText.count > 80 {
            reviewTextView.textColor = UIColor.beRed500
            reviewTextView.layer.borderColor = UIColor.beRed500.cgColor
            reviewTextView.backgroundColor = .beRed100
            
            reviewFieldAlertImage.isHidden = false
            reviewFieldAlertLabel.isHidden = false
            reviewFieldAlertLabel.text = "후기는 80자를 넘을 수 없습니다."
            
            isNext[1] = false
            
            return false
        } else {
            reviewTextView.textColor = UIColor.bePsBlue500
            reviewTextView.layer.borderColor = UIColor.bePsBlue500.cgColor
            reviewTextView.backgroundColor = .bePsBlue100
            
            reviewFieldAlertImage.isHidden = true
            reviewFieldAlertLabel.isHidden = true
            
            isNext[1] = true
        }
        updateCertifyButtonState()
        
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        // 입력 전 텍스트뷰 지우기
        if textView.text == textViewPlaceHolder {
            textView.text = nil
        }
        
        textView.textColor = UIColor.bePsBlue500
        textView.layer.borderColor = UIColor.bePsBlue500.cgColor
        textView.backgroundColor = .bePsBlue100
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = textViewPlaceHolder
            textView.textColor = .beTextEx
        }
        
        textView.textColor = UIColor.beTextDef
        textView.layer.borderColor = UIColor.beBorderDis.cgColor
        textView.backgroundColor = .beBgCard
    }
    
    // MARK: - 툴바 설정
    func setupToolBar() {
        let toolBar = UIToolbar()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonHandeler))
        
        toolBar.items = [flexibleSpace, doneButton]
        // 적절한 사이즈로 toolBar의 크기를 만들어 줍니다.
        toolBar.sizeToFit()
        
        reviewTextView.inputAccessoryView = toolBar
    }
    
    // MARK: - actions
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    // 키보드 내리기
    @objc func doneButtonHandeler(_ sender: UIBarButtonItem) {
        reviewTextView.resignFirstResponder()
    }
}

// MARK: - 필수 표시 포함하는 레이블 커스텀 함수
extension RegisterCertifyViewController {
    func customLabelView(labelText: String) -> UIView {
        // 커스텀 레이블 전체 뷰
        let customView: UIView = {
            let view = UIView()
            
            return view
        }()
        
        // 커스텀 레이블 - 레이블
        let customLabel: UILabel = {
            let view = UILabel()
            
            view.text = labelText
            view.textColor = .beTextDef
            view.textAlignment = .left
            view.font = UIFont(name: "NotoSansKR-Medium", size: 16)
            
            return view
        }()
        
        // 커스텀 레이블 - 필수 표시 뷰
        let redDot: UIView = {
            let view = UIView()
            
            view.backgroundColor = .beCta
            view.layer.cornerRadius = 2
            
            return view
        }()
        
        customView.addSubview(customLabel)
        customView.addSubview(redDot)
        
        customLabel.snp.makeConstraints { make in
            make.top.equalTo(customView.snp.top)
            make.leading.equalTo(customView.snp.leading)
            make.trailing.equalTo(customView.snp.trailing)
            make.height.equalTo(23)
        }
        
        redDot.snp.makeConstraints { make in
            make.top.equalTo(customLabel.snp.top)
            make.leading.equalTo(customLabel.snp.trailing).offset(2)
            make.width.height.equalTo(4)
        }
        
        return customView
    }
}

// MARK: - network
extension RegisterCertifyViewController {
    func reviewPost() {        
        ChallengeService.shared.reviewPost(reviewChallengeId: reviewChallengeId ?? 0) { response in
            self.challengeCertify = response
            print(response)
        }
    }
}

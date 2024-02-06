//
//  RegisterViewController.swift
//  beilsang
//
//  Created by 곽은채 on 1/29/24.
//

import SCLAlertView
import SnapKit
import UIKit

// [홈] 챌린지 등록 화면
class RegisterFirstViewController: UIViewController, UIScrollViewDelegate {
    
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
    
    // 다음으로 버튼 활성화를 위한 변수
    var isNext = [false, false, false, false, false, false]
    
    // 대표 사진 등록 레이블
    lazy var representativePhotoLabel = customLabelView(labelText: "대표 사진 등록")
    
    // 대표 사진 등록하기 이미지 피커
    let representativeImagePicker = UIImagePickerController()
    
    // 대표 사진 등록 버튼
    lazy var representativePhotoButton: UIButton = {
        let view = UIButton()
        
        view.backgroundColor = .beBgCard
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.beBorderDis.cgColor
        view.addTarget(self, action: #selector(representativePhotoButtonClicked), for: .touchUpInside)
        
        return view
    }()
    
    // 대표 사진 등록 버튼 이미지
    lazy var representativePhotoButtonImage: UIImageView = {
        let view = UIImageView()
        
        view.image = UIImage(named: "camera")
        view.contentMode = .center
        view.tintColor = .beIconDef
        
        return view
    }()
    
    // 대표 사진 등록 버튼 레이블
    lazy var representativePhotoButtonLabel: UILabel = {
        let view = UILabel()
        
        view.text = "사진 등록하기\n0/1"
        view.textColor = .beTextSub
        view.textAlignment = .center
        view.numberOfLines = 2
        view.font = UIFont(name: "NotoSansKR-Medium", size: 12)
        
        return view
    }()
    
    // 대표 사진 등록 후 이미지
    lazy var representativePhotoImage: UIImageView = {
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
    
    // 사진 등록 취소 버튼
    lazy var photoCloseButton: UIButton = {
        let view = UIButton()
        
        view.setImage(UIImage(named: "icon-close-circle"), for: .normal)
        view.addTarget(self, action: #selector(photoCloseButtonClicked), for: .touchUpInside)
        
        return view
    }()
    
    // 챌린지 제목 레이블
    lazy var challengeTitleLabel = customLabelView(labelText: "챌린지 제목")
    
    // 챌린지 제목 텍스트 필드
    lazy var challengeTitleField = customTextField(textFieldText: "4~15자 이내로 입력해 주세요")
    
    // 챌린지 제목 검사 이미지
    lazy var challengeTitleCheckImage: UIImageView = {
        let view = UIImageView()
        
        return view
    }()
    
    // 챌린지 제목 검사 레이블
    lazy var challengeTitleCheckLabel: UILabel = {
        let view = UILabel()
        
        return view
    }()
    
    // 카테고리 분류 레이블
    lazy var categoryLabel = customLabelView(labelText: "카테고리 분류")
    
    // 카테고리 분류 선택하기 버튼
    let categoryPickerView = UIPickerView()
    let categoryOptions = ["다회용컵", "리필스테이션", "다회용기", "친환경제품", "플로깅", "비건", "대중교통", "자전거", "재활용"]
    var selectedCategory: String?
    lazy var categoryField = customTextField(textFieldText: "카테고리 선택하기")
    
    // 시작일 레이블
    lazy var startLabel = customLabelView(labelText: "시작일")
    
    // 시작일 선택하기 버튼
    let datePicker = UIDatePicker()
    lazy var startField = customTextField(textFieldText: "시작일 선택하기")
    
    // 실천 기간 선택 레이블
    lazy var dayLabel = customLabelView(labelText: "실천 기간 선택")
    
    // 실천 기간 선택하기 버튼
    let dayPickerView = UIPickerView()
    let dayOptions = ["일주일", "한 달"]
    var selectedDay: String?
    lazy var dayField = customTextField(textFieldText: "실천 기간 선택하기")
    
    // 실천 횟수 선택 레이블
    lazy var countLabel = customLabelView(labelText: "실천 횟수 선택")
    
    // 실천 횟수 선택 단위 레이블
    lazy var countUnitLabel: UILabel = {
        let view = UILabel()
        
        view.text = "(단위: 일)"
        view.textColor = .beTextEx
        view.font = UIFont(name: "NotoSansKR-Light", size: 12)
        
        return view
    }()
    
    // 실천 횟수 레이블
    var countMin = 1
    var countMax = 7
    var count = 1
    lazy var countIntLabel: UILabel = {
        let view = UILabel()
        
        view.backgroundColor = .beBgCard
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.beBorderDis.cgColor
        view.text = "\(count)"
        view.textColor = .beTextDef
        view.textAlignment = .center
        view.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        
        return view
    }()
    
    // 실천 횟수 선택 - 버튼
    lazy var countMinusButton: UIButton = {
        let view = UIButton()
        
        view.backgroundColor = .beScPurple400
        view.layer.cornerRadius = 8
        view.setImage(UIImage(named: "button-minus"), for: .normal)
        view.addTarget(self, action: #selector(countMinusButtonClicked), for: .touchUpInside)
        
        return view
    }()
    
    // 실천 횟수 선택 + 버튼
    lazy var countPlusButton: UIButton = {
        let view = UIButton()
        
        view.backgroundColor = .beScPurple600
        view.layer.cornerRadius = 8
        view.setImage(UIImage(named: "button-plus"), for: .normal)
        view.addTarget(self, action: #selector(countPlusButtonClicked), for: .touchUpInside)
        
        return view
    }()
    
    // 실천 횟수 선택 안내 레이블
    lazy var countNoticeLabel: UILabel = {
        let view = UILabel()
        
        view.textColor = .bePsBlue500
        view.textAlignment = .left
        view.font = UIFont(name: "NotoSansKR-Regular", size: 11)
        
        return view
    }()
    
    // 다음으로 전체 뷰
    lazy var bottomView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .beBgSub
        
        return view
    }()
    
    // 다음으로 버튼
    lazy var nextButton: UIButton = {
        let view = UIButton()
        
        view.setTitle("다음으로", for: .normal)
        view.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        view.setTitleColor(.beTextWhite, for: .normal)
        view.backgroundColor = .beScPurple300
        view.layer.cornerRadius = 10
        view.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        
        return view
    }()
    
    // MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupAttribute()
        setImagePicker()
        setTextField()
        setupToolBar()
        setupDatePicker()
        createPickerView()
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
        
        cancleAlertViewResponder?.close()
    }
    
    // 챌린지 등록하기 알림창 - 챌린지 등록하기 버튼 클릭
    @objc func continueButtonClicked(){
        print("계속 작성하기")

        cancleAlertViewResponder?.close()
    }
    
    @objc func representativePhotoButtonClicked() {
        // 사용자가 사진 또는 카메라 중 선택할 수 있는 액션 시트 표시
        let alert = UIAlertController(title: nil, message: "사진을 선택하세요", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "사진 앨범", style: .default, handler: { _ in
            self.openGallery(imagePicker: self.representativeImagePicker)
        }))
        alert.addAction(UIAlertAction(title: "카메라", style: .default, handler: { _ in
            self.openCamera(imagePicker: self.representativeImagePicker)
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc func photoCloseButtonClicked() {
        representativePhotoImage.isHidden = true
        representativePhotoButtonLabel.text = "사진 등록하기\n0/1"
        
        isNext[0] = false
        updateNextButtonState()
    }
    
    @objc func challengeTitleFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }

        if text.count >= 4 && text.count <= 15 {
            challengeTitleCheckImage.image = UIImage(named: "icon_information-circle")
            challengeTitleCheckLabel.text = "4~15자 이내로 입력해 주세요"
            challengeTitleCheckLabel.textColor = .beWnRed500
        } else {
            // 챌린지 제목이 존재하지 않는다면
            challengeTitleCheckImage.image = UIImage(named: "icon-check")
            challengeTitleCheckLabel.text = "사용 가능한 챌린지 제목입니다"
            challengeTitleCheckLabel.textColor = .bePsBlue500
            
            // 챌린지 제목이 존재한다면
//            challengeTitleCheckImage.image = UIImage(named: "icon_information-circle")
//            challengeTitleCheckLabel.text = "이미 존재하는 챌린지 제목입니다"
//            challengeTitleCheckLabel.textColor = .beWnRed500
        }
    }
    
    @objc func countMinusButtonClicked() {
        if count > countMin {
            count -= 1
            countIntLabel.text = "\(count)"
        }
        checkCountButtonState()
    }
    
    @objc func countPlusButtonClicked() {
        if count < countMax {
            count += 1
            countIntLabel.text = "\(count)"
        }
        checkCountButtonState()
    }
    
    func checkCountButtonState() {
        if count > countMin {
            countMinusButton.isEnabled = true
            countMinusButton.backgroundColor = .beScPurple600
        } else {
            countMinusButton.backgroundColor = .beScPurple400
        }
        if count < countMax {
            countPlusButton.isEnabled = true
            countPlusButton.backgroundColor = .beScPurple600
        } else {
            countPlusButton.backgroundColor = .beScPurple400
        }
        
        if Int(countIntLabel.text!)! > 0 {
            isNext[5] = true
            updateNextButtonState()
        }
    }
    
    @objc func nextButtonClicked() {
        print("다음으로")
        
        let nextVC = RegisterSecondViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

// MARK: - Layout setting
extension RegisterFirstViewController {
    
    func setupAttribute() {
        setFullScrollView()
        setLayout()
        setNavigationBar()
        setUI()
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
        representativePhotoImage.isHidden = true
        
        challengeTitleCheckImage.isHidden = true
        challengeTitleCheckLabel.isHidden = true
        
        countMinusButton.isEnabled = false
        countPlusButton.isEnabled = false
        
        nextButton.isEnabled = false
    }
    
    func updateNextButtonState() {
        if isNext.allSatisfy({ $0 }) {
            nextButton.backgroundColor = .beScPurple600
            nextButton.isEnabled = true
        } else {
            nextButton.isEnabled = false
            nextButton.backgroundColor = .beScPurple400
        }
    }
    
    func setLayout() {
        view.addSubview(fullScrollView)
        view.addSubview(bottomView)
        
        fullScrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.width.leading.trailing.equalToSuperview()
            make.bottom.equalTo(bottomView.snp.top)
        }
        
        fullScrollView.addSubview(fullContentView)
        // fullScrollView.contentInsetAdjustmentBehavior = .never
        
        fullContentView.snp.makeConstraints { make in
            make.edges.equalTo(fullScrollView.contentLayoutGuide)
            make.width.equalTo(fullScrollView.frameLayoutGuide)
            make.height.equalTo(770)
        }
        
        fullContentView.addSubview(topViewBorder)
        fullContentView.addSubview(representativePhotoLabel)
        fullContentView.addSubview(representativePhotoImage)
        fullContentView.addSubview(representativePhotoButton)
        fullContentView.addSubview(challengeTitleLabel)
        fullContentView.addSubview(challengeTitleField)
        fullContentView.addSubview(challengeTitleCheckImage)
        fullContentView.addSubview(challengeTitleCheckLabel)
        fullContentView.addSubview(categoryLabel)
        fullContentView.addSubview(categoryField)
        fullContentView.addSubview(startLabel)
        fullContentView.addSubview(startField)
        fullContentView.addSubview(dayLabel)
        fullContentView.addSubview(dayField)
        fullContentView.addSubview(countLabel)
        fullContentView.addSubview(countUnitLabel)
        fullContentView.addSubview(countMinusButton)
        fullContentView.addSubview(countIntLabel)
        fullContentView.addSubview(countPlusButton)
        fullContentView.addSubview(countNoticeLabel)
        
        representativePhotoButton.addSubview(representativePhotoButtonImage)
        representativePhotoButton.addSubview(representativePhotoButtonLabel)
        
        representativePhotoImage.addSubview(photoCloseButton)
        
        bottomView.addSubview(nextButton)
        
        topViewBorder.snp.makeConstraints { make in
            make.top.equalTo(fullScrollView.snp.top)
            make.width.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }

        representativePhotoLabel.snp.makeConstraints { make in
            make.top.equalTo(topViewBorder.snp.top).offset(32)
            make.leading.equalTo(fullScrollView.snp.leading).offset(16)
            make.height.equalTo(23)
        }
        
        representativePhotoButton.snp.makeConstraints { make in
            make.top.equalTo(representativePhotoLabel.snp.bottom).offset(12)
            make.leading.equalTo(fullScrollView.snp.leading).offset(16)
            make.width.equalTo(120)
            make.height.equalTo(120)
        }
        
        representativePhotoButtonImage.snp.makeConstraints { make in
            make.top.equalTo(representativePhotoButton.snp.top).offset(25)
            make.width.height.equalTo(32)
            make.centerX.equalTo(representativePhotoButton.snp.centerX)
        }
        
        representativePhotoButtonLabel.snp.makeConstraints { make in
            make.top.equalTo(representativePhotoButtonImage.snp.bottom).offset(4)
            make.centerX.equalTo(representativePhotoButton.snp.centerX)
        }
        
        representativePhotoImage.snp.makeConstraints { make in
            make.top.equalTo(representativePhotoButton.snp.top)
            make.leading.equalTo(representativePhotoButton.snp.trailing).offset(8)
            make.width.height.equalTo(120)
        }
        
        photoCloseButton.snp.makeConstraints { make in
            make.top.equalTo(representativePhotoImage.snp.top).offset(4)
            make.trailing.equalTo(representativePhotoImage.snp.trailing).offset(-4)
            make.width.height.equalTo(24)
        }
        
        challengeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(representativePhotoButton.snp.bottom).offset(24)
            make.leading.equalTo(fullScrollView.snp.leading).offset(16)
            make.height.equalTo(23)
        }
        
        challengeTitleField.snp.makeConstraints { make in
            make.top.equalTo(challengeTitleLabel.snp.bottom).offset(12)
            make.leading.equalTo(fullScrollView.snp.leading).offset(16)
            make.trailing.equalTo(fullScrollView.snp.trailing).offset(-16)
            make.height.equalTo(48)
        }
        
        challengeTitleCheckImage.snp.makeConstraints { make in
            make.top.equalTo(challengeTitleField.snp.bottom).offset(4)
            make.leading.equalTo(fullScrollView.snp.leading).offset(16)
            make.width.height.equalTo(14)
        }
        
        challengeTitleCheckLabel.snp.makeConstraints { make in
            make.top.equalTo(challengeTitleCheckImage.snp.top)
            make.leading.equalTo(challengeTitleCheckImage.snp.trailing).offset(4)
            make.centerY.equalTo(challengeTitleCheckImage.snp.centerY)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(challengeTitleField.snp.bottom).offset(24)
            make.leading.equalTo(fullScrollView.snp.leading).offset(16)
            make.height.equalTo(23)
        }
        
        categoryField.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(12)
            make.leading.equalTo(fullScrollView.snp.leading).offset(16)
            make.trailing.equalTo(fullScrollView.snp.trailing).offset(-16)
            make.height.equalTo(48)
        }
        
        startLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryField.snp.bottom).offset(24)
            make.leading.equalTo(fullScrollView.snp.leading).offset(16)
            make.height.equalTo(23)
        }
        
        startField.snp.makeConstraints { make in
            make.top.equalTo(startLabel.snp.bottom).offset(12)
            make.leading.equalTo(fullScrollView.snp.leading).offset(16)
            make.trailing.equalTo(fullScrollView.snp.trailing).offset(-16)
            make.height.equalTo(48)
        }
        
        dayLabel.snp.makeConstraints { make in
            make.top.equalTo(startField.snp.bottom).offset(24)
            make.leading.equalTo(fullScrollView.snp.leading).offset(16)
            make.height.equalTo(23)
        }
        
        dayField.snp.makeConstraints { make in
            make.top.equalTo(dayLabel.snp.bottom).offset(12)
            make.leading.equalTo(fullScrollView.snp.leading).offset(16)
            make.trailing.equalTo(fullScrollView.snp.trailing).offset(-16)
            make.height.equalTo(48)
        }
        
        countLabel.snp.makeConstraints { make in
            make.top.equalTo(dayField.snp.bottom).offset(24)
            make.leading.equalTo(fullScrollView.snp.leading).offset(16)
            make.height.equalTo(23)
        }
        
        countUnitLabel.snp.makeConstraints { make in
            make.centerY.equalTo(countLabel.snp.centerY)
            make.leading.equalTo(countLabel.snp.trailing).offset(16)
        }
        
        let countButtonWidth = (UIScreen.main.bounds.width - 32) / 3.73
        let countLabelWidth = (UIScreen.main.bounds.width - 32) / 2.39
        
        countMinusButton.snp.makeConstraints { make in
            make.top.equalTo(countLabel.snp.bottom).offset(12)
            make.leading.equalTo(fullScrollView.snp.leading).offset(16)
            make.height.equalTo(48)
            make.width.equalTo(countButtonWidth)
        }
        
        countIntLabel.snp.makeConstraints { make in
            make.centerY.equalTo(countMinusButton.snp.centerY)
            make.leading.equalTo(countMinusButton.snp.trailing).offset(8)
            make.height.equalTo(48)
            make.width.equalTo(countLabelWidth)
        }
        
        countPlusButton.snp.makeConstraints { make in
            make.centerY.equalTo(countMinusButton.snp.centerY)
            make.leading.equalTo(countIntLabel.snp.trailing).offset(8)
            make.height.equalTo(48)
            make.width.equalTo(countButtonWidth)
        }
        
        countNoticeLabel.snp.makeConstraints { make in
            make.top.equalTo(countMinusButton.snp.bottom).offset(8)
            make.leading.equalTo(countMinusButton.snp.leading)
        }
        
        bottomView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(80)
        }
        
        nextButton.snp.makeConstraints { make in
            make.centerY.equalTo(bottomView.snp.centerY)
            make.trailing.equalTo(bottomView.snp.trailing).offset(-22)
            make.height.equalTo(52)
            make.width.equalTo(167)
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
}

// MARK: - 이미지 피커, 텍스트 필드, 피커, Date, 툴바 설정
extension RegisterFirstViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    // MARK: - 이미지 피커 설정
    func setImagePicker() {
        representativeImagePicker.delegate = self
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
            if picker == representativeImagePicker {
                // imagePicker1에서 선택한 이미지를 사용하는 코드
                representativePhotoImage.image = image
                representativePhotoImage.isHidden = false  // 이미지 뷰 표시
                representativePhotoButtonLabel.text = "사진 등록하기\n1/1"
                isNext[0] = true
                updateNextButtonState()
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    // 이미지 피커에서 취소 버튼을 누른 후 호출되는 메소드
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - 텍스트 필드 설정
    func setTextField() {
        challengeTitleField.delegate = self
        startField.delegate = self
        dayField.delegate = self
        categoryField.delegate = self
        
        // 화면 터치시 키보드 내려감
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == challengeTitleField {
            textField.backgroundColor = .bePsBlue100
            textField.textColor = .bePsBlue500
            textField.layer.borderColor = UIColor.bePsBlue500.cgColor
            
            challengeTitleCheckImage.isHidden = false
            challengeTitleCheckLabel.isHidden = false
            categoryLabel.snp.makeConstraints { make in
                make.top.equalTo(challengeTitleField.snp.bottom).offset(44)
            }
        }
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == challengeTitleField {
            isNext[1] = true
        }
        else if textField == categoryField {
            categoryField.textColor = UIColor.beTextDef
            isNext[2] = true
        }
        else if textField == startField {
            startField.textColor = UIColor.beTextDef
            isNext[3] = true
        }
        else if textField == dayField {
            dayField.textColor = UIColor.beTextDef
            isNext[4] = true
        }
        
        updateNextButtonState()
        
        return true
    }
    
    // MARK: - Date 설정
    func setupDatePicker() {
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
        startField.inputView = datePicker
        // textField에 오늘 날짜로 표시되게 설정
        // startField.text = dateFormat(date: Date())
    }
    
    func dateFormat(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        
        return formatter.string(from: date)
    }
    
    // MARK: - Picker 설정
    func createPickerView() {
        // 피커 세팅
        dayPickerView.delegate = self
        dayPickerView.dataSource = self
        dayField.tintColor = .clear
        
        categoryPickerView.delegate = self
        categoryPickerView.dataSource = self
        categoryField.tintColor = .clear
        
        // 텍스트필드 입력 수단 연결
        dayField.inputView = dayPickerView
        categoryField.inputView = categoryPickerView
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == dayPickerView {
            return 1
        }
        else if pickerView == categoryPickerView {
            return 1
        }
        else {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == dayPickerView {
            return 2
        }
        else if pickerView == categoryPickerView {
            return 9
        }
        else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == dayPickerView {
            return dayOptions[row]
        }
        else if pickerView == categoryPickerView {
            return categoryOptions[row]
        }
        else {
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == dayPickerView {
            switch component {
            case 0:
                selectedDay = dayOptions[row]
            default:
                break
            }
            dayField.text = selectedDay
            
            if selectedDay == dayOptions[0] {
                countNoticeLabel.text = "📌3회 설정시, 일주일 중 3일을 실천 후 인증해야 합니다."
                countMin = 1
                countMax = 7
            } else if selectedDay == dayOptions[1] {
                countNoticeLabel.text = "📌10회 설정시, 한 달 중 10일을 실천 후 인증해야 합니다."
                countMin = 1
                countMax = 30
            }
            countMinusButton.isEnabled = true
            countPlusButton.isEnabled = true
        }
        else if pickerView == categoryPickerView {
            switch component {
            case 0:
                selectedCategory = categoryOptions[row]
            default:
                break
            }
            categoryField.text = selectedCategory
        }
    }
    
    // MARK: - 툴바 설정
    func setupToolBar() {
        let toolBar = UIToolbar()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonHandeler))
        
        toolBar.items = [flexibleSpace, doneButton]
        // 적절한 사이즈로 toolBar의 크기를 만들어 줍니다.
        toolBar.sizeToFit()
        
        startField.inputAccessoryView = toolBar
        dayField.inputAccessoryView = toolBar
        categoryField.inputAccessoryView = toolBar
    }
    
    // MARK: - actions
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    @objc func dateChange(_ sender: UIDatePicker) {
        // 값이 변하면 UIDatePicker에서 날짜를 받아와 형식을 변형해서 textField에 넣어줍니다.
        startField.text = dateFormat(date: sender.date)
        startField.font = UIFont(name: "NotoSansKR-Regular", size: 14)
    }
    
    @objc func doneButtonHandeler(_ sender: UIBarButtonItem) {
        // startField.text = dateFormat(date: datePicker.date)
        // 키보드 내리기
        startField.resignFirstResponder()
        dayField.resignFirstResponder()
        categoryField.resignFirstResponder()
    }
}

// MARK: - 뷰 커스텀을 위한 extension
extension RegisterFirstViewController {
    
    // MARK: - 필수 표시 포함하는 레이블 커스텀 함수
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
    
    // MARK: - 챌린지 제목 아래 레이블 커스텀(불허 ver.)
    func challengeNOTitle(LabelText: String) -> UILabel {
        // 챌린지 제목 허용 여부 레이블
        lazy var challengeTitleOKLabel: UILabel = {
            let view = UILabel()
            
            view.font = UIFont(name: "NotoSansKR-Regular", size: 11)
            view.textAlignment = .left
            
            return view
        }()
        
        // 챌린지 제목 허용 이미지
        lazy var challengeTitleOKImage: UIImageView = {
            let view = UIImageView()
            
            view.image = UIImage(named: "icon-check")
            view.contentMode = .scaleAspectFill
            view.tintColor = .bePsBlue500
            
            return view
        }()
        
        // 챌린지 제목 경고 이미지
        lazy var challengeTitleNOImage: UIImageView = {
            let view = UIImageView()
            
            view.image = UIImage(named: "icon-attention")
            view.contentMode = .scaleAspectFill
            view.tintColor = .beWnRed500
            
            return view
        }()
        
        return challengeTitleOKLabel
    }
    
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

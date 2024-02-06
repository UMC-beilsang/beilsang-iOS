//
//  RegisterSecondViewController.swift
//  beilsang
//
//  Created by 곽은채 on 1/31/24.
//

import SCLAlertView
import SnapKit
import UIKit

// [홈] 챌린지 등록하기
// 한 페이지에서 세 페이지로 나눠짐에 따라 생성된 VC
class RegisterSecondViewController: UIViewController, UIScrollViewDelegate, UIViewControllerTransitioningDelegate {
    
    // MARK: properties
    // 전체 화면 scrollview
    let fullScrollView = UIScrollView()
    let fullContentView = UIView()
    var fullContentViewHeight = 670
    
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
    var isNext = [false, false, false, false]
    
    // 세부 설명 레이블
    lazy var detailLabel = customLabelView(labelText: "세부 설명")
    
    // 세부 설명 텍스트 필드
    lazy var detailField = customTextField(textFieldText: "챌린지에 대한 설명을 20~80자 이내로 입력해 주세요")
    
    // 챌린지 유의사항 레이블
    lazy var noticeTitleLabel = customLabelView(labelText: "챌린지 인증 유의사항")
    
    // 챌린지 유의사항
    var noticeLabels: [String] = []
    
    // 챌린지 유의사항 콜렉션 뷰
    lazy var noticeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    // 챌린지 유의사항 툴팁 버튼
    lazy var toolTipButton: UIButton = {
        let view = UIButton()
        
        view.setImage(UIImage(named: "icon_information-circle"), for: .normal)
        view.addTarget(self, action: #selector(toolTipButtonClicked), for: .touchUpInside)
        
        return view
    }()
    
    // 챌린지 유의사항 툴팁 레이블
    lazy var toolTipLabel = noticeToolTipView()
    
    // 유의사항 등록하기 버튼 전체
    lazy var noticeButton: UIButton = {
        let view = UIButton()
        
        view.backgroundColor = .beBgCard
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.beBorderDis.cgColor
        view.addTarget(self, action: #selector(noticeRegisterButtonClicked), for: .touchUpInside)
        
        return view
    }()
    
    // 유의사항 등록하기 버튼 이미지
    lazy var noticeButtonImage: UIImageView = {
        let view = UIImageView()
        
        view.image = UIImage(named: "icon-check-black")
        view.contentMode = .center
        view.tintColor = .beIconDef
        
        return view
    }()
    
    // 유의사항 등록하기 버튼 레이블
    lazy var noticeButtonLabel: UILabel = {
        let view = UILabel()
        
        view.text = "챌린지 인증 유의사항 등록하기"
        view.textColor = .beTextSub
        view.textAlignment = .center
        view.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        
        return view
    }()
    
    lazy var noticeButtonCountLabel: UILabel = {
        let view = UILabel()
        
        view.text = "(\(noticeLabels.count)/5)"
        view.textColor = .beTextSub
        view.textAlignment = .center
        view.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        
        return view
    }()
    
    // 모범 인증 사진 추가 레이블
    lazy var examplePhotoLabel = customLabelView(labelText: "모범 인증 사진 등록")
    
    // 모범 인증 사진 등록하기 이미지 피커
    lazy var exampleImagePicker = UIImagePickerController()
    
    // 모범 인증 사진 등록하기 버튼
    lazy var examplePhotoButton: UIButton = {
        let view = UIButton()
        
        view.backgroundColor = .beBgCard
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.beBorderDis.cgColor
        view.addTarget(self, action: #selector(examplePhotoButtonClicked), for: .touchUpInside)
        
        return view
    }()
    
    // 모범 인증 사진 등록 버튼 이미지
    lazy var examplePhotoButtonImage: UIImageView = {
        let view = UIImageView()
        
        view.image = UIImage(named: "camera")
        view.contentMode = .center
        view.tintColor = .beIconDef
        
        return view
    }()
    
    // 모범 인증 사진 버튼 레이블
    lazy var examplePhotoButtonLabel: UILabel = {
        let view = UILabel()
        
        view.text = "사진 등록하기\n0/1"
        view.textColor = .beTextSub
        view.textAlignment = .center
        view.numberOfLines = 2
        view.font = UIFont(name: "NotoSansKR-Medium", size: 12)
        
        return view
    }()
    
    // 모범 인증 사진 등록 후 이미지
    lazy var examplePhotoImage: UIImageView = {
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
    
    // 최소 참여 포인트 레이블
    lazy var pointLabel = customLabelView(labelText: "최소 참여 포인트")
    
    // 최소 참여 포인트 단위 레이블
    lazy var pointUnitLabel: UILabel = {
        let view = UILabel()
        
        view.text = "(단위: 100)"
        view.textColor = .beTextEx
        view.font = UIFont(name: "NotoSansKR-Light", size: 12)
        
        return view
    }()
    
    // 최소 참여 포인트 레이블
    var pointMin = 0
    var pointMax = 1000
    var point = 0
    lazy var pointIntLabel: UILabel = {
        let view = UILabel()
        
        view.backgroundColor = .beBgCard
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.beBorderDis.cgColor
        view.text = "\(point)"
        view.textColor = .beTextDef
        view.textAlignment = .center
        view.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        
        return view
    }()
    
    // 최소 참여 포인트 - 버튼
    lazy var pointMinusButton: UIButton = {
        let view = UIButton()
        
        view.backgroundColor = .beScPurple400
        view.layer.cornerRadius = 8
        view.setImage(UIImage(named: "button-minus"), for: .normal)
        view.addTarget(self, action: #selector(pointMinusButtonClicked), for: .touchUpInside)
        
        return view
    }()
    
    // 최소 참여 포인트 + 버튼
    lazy var pointPlusButton: UIButton = {
        let view = UIButton()
        
        view.backgroundColor = .beScPurple600
        view.layer.cornerRadius = 8
        view.setImage(UIImage(named: "button-plus"), for: .normal)
        view.addTarget(self, action: #selector(pointPlusButtonClicked), for: .touchUpInside)
        
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
        setCollectionView()
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
    
    @objc func noticeRegisterButtonClicked() {
        if noticeLabels.count >= 5 {
            noticeButton.isEnabled = false
        } else {
            noticeRegisterButtonEnabled()
        }
    }
    
    func noticeRegisterButtonEnabled() {
        print("챌린지 인증 유의사항")
        
        let modalVC = RegisterModalViewController()
        
        modalVC.completion = { text in
            // 모달창에서 전달받은 내용(사용자가 입력한 내용) noticeLabels 배열에 추가
            self.noticeLabels.append(text)
            // noticeLabels의 내용이 변경됐으므로
            // 컬렉션뷰의 내용 업데이트
            self.noticeCollectionView.reloadData()
            // 등록하기 숫자 업데이트
            self.noticeButtonCountLabel.text = "(\(self.noticeLabels.count)/5)"
            // 컬렉션뷰 높이 업데이트
            let collectionViewHeight = (self.noticeLabels.count * 48) + ((self.noticeLabels.count) * 8)
            self.noticeCollectionView.snp.updateConstraints { make in
                make.height.equalTo(collectionViewHeight)
            }
            // 스크롤뷰 높이 업데이트
            let contentViewHeight = collectionViewHeight + 618
            self.fullContentView.snp.updateConstraints { make in
                make.height.equalTo(contentViewHeight)
            }
            
            if self.noticeLabels.count > 0 {
                self.isNext[1] = true
                self.updateNextButtonState()
            }
        }
        
        // 모달창 스타일 설정
        modalVC.modalPresentationStyle = .overCurrentContext
        
        // 버튼 누르면 모달창 나타남
        present(modalVC, animated: true, completion: nil)
    }
    
    @objc func examplePhotoButtonClicked() {
        // 사용자가 사진 또는 카메라 중 선택할 수 있는 액션 시트 표시
        let alert = UIAlertController(title: nil, message: "사진을 선택하세요", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "사진 앨범", style: .default, handler: { _ in
            self.openGallery(imagePicker: self.exampleImagePicker)
        }))
        alert.addAction(UIAlertAction(title: "카메라", style: .default, handler: { _ in
            self.openCamera(imagePicker: self.exampleImagePicker)
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc func photoCloseButtonClicked() {
        print("사진 취소")
        examplePhotoImage.isHidden = true
        examplePhotoButtonLabel.text = "사진 등록하기\n0/1"
        
        isNext[2] = false
        updateNextButtonState()
    }
    
    @objc func toolTipButtonClicked() {
        toolTipLabel.isHidden = !(toolTipLabel.isHidden)
    }
    
    @objc func pointMinusButtonClicked() {
        if point > pointMin {
            point -= 100
            pointIntLabel.text = "\(point)"
        }
        checkPointButtonState()
    }
    
    @objc func pointPlusButtonClicked() {
        if point < pointMax {
            point += 100
            pointIntLabel.text = "\(point)"
        }
        
        checkPointButtonState()
    }
    
    func checkPointButtonState() {
        if point > pointMin {
            pointMinusButton.isEnabled = true
            pointMinusButton.backgroundColor = .beScPurple600
        } else {
            pointMinusButton.backgroundColor = .beScPurple400
        }
        if point < pointMax {
            pointPlusButton.isEnabled = true
            pointPlusButton.backgroundColor = .beScPurple600
        } else {
            pointPlusButton.backgroundColor = .beScPurple400
        }
        
        if Int(pointIntLabel.text!)! > 0 {
            isNext[3] = true
            updateNextButtonState()
        }
    }
    
    @objc func beforeButtonClicked() {
        print("이전")
        
        let beforeVC = RegisterFirstViewController()
        navigationController?.pushViewController(beforeVC, animated: true)
    }
    
    @objc func nextButtonClicked() {
        print("다음으로")
        
        let nextVC = RegisterThirdViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

// MARK: - Layout setting
extension RegisterSecondViewController {
    
    func setupAttribute() {
        setFullScrollView()
        setNavigationBar()
        setUI()
        setAddViews()
        setLayout()
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
        toolTipLabel.isHidden = true
        
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
    
    func setAddViews() {
        view.addSubview(fullScrollView)
        view.addSubview(bottomView)
        
        fullScrollView.addSubview(fullContentView)
        
        [topViewBorder, detailLabel, detailField, noticeTitleLabel, noticeButton, toolTipButton, toolTipLabel, noticeCollectionView, examplePhotoLabel, examplePhotoImage, examplePhotoButton, pointLabel, pointUnitLabel, pointMinusButton, pointIntLabel, pointPlusButton].forEach { view in
            fullContentView.addSubview(view)
        }
        
        [noticeButtonImage, noticeButtonLabel, noticeButtonCountLabel].forEach { view in
            noticeButton.addSubview(view)
        }
        
        [examplePhotoButtonImage, examplePhotoButtonLabel].forEach { view in
            examplePhotoButton.addSubview(view)
        }
        
        examplePhotoImage.addSubview(photoCloseButton)
        
        [beforeButton, nextButton].forEach { view in
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
            make.height.equalTo(666)
        }
        
        topViewBorder.snp.makeConstraints { make in
            make.top.equalTo(fullScrollView.snp.top)
            make.width.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(topViewBorder.snp.bottom).offset(24)
            make.leading.equalTo(fullScrollView.snp.leading).offset(16)
            make.height.equalTo(23)
        }
        
        detailField.snp.makeConstraints { make in
            make.top.equalTo(detailLabel.snp.bottom).offset(12)
            make.leading.equalTo(fullScrollView.snp.leading).offset(16)
            make.trailing.equalTo(fullScrollView.snp.trailing).offset(-16)
            make.height.equalTo(112)
        }
        
        noticeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(detailField.snp.bottom).offset(24)
            make.leading.equalTo(fullScrollView.snp.leading).offset(16)
            make.height.equalTo(23)
        }
        
        toolTipButton.snp.makeConstraints { make in
            make.centerY.equalTo(noticeTitleLabel.snp.centerY)
            make.leading.equalTo(noticeTitleLabel.snp.trailing).offset(8)
            make.width.height.equalTo(16)
        }
        
        toolTipLabel.snp.makeConstraints { make in
            make.top.equalTo(toolTipButton.snp.bottom).offset(8.5)
            make.leading.equalTo(toolTipButton.snp.leading)
            make.width.equalTo(200)
            make.height.equalTo(144)
        }
        
        let collectionViewHeight = (self.noticeLabels.count * 48) + ((self.noticeLabels.count - 1) * 8)
        noticeCollectionView.snp.makeConstraints { make in
            make.top.equalTo(noticeTitleLabel.snp.bottom).offset(12)
            make.leading.equalTo(fullScrollView.snp.leading)
            make.trailing.equalTo(fullScrollView.snp.trailing)
            make.height.equalTo(collectionViewHeight)
        }
        
        noticeButton.snp.makeConstraints { make in
            make.top.equalTo(noticeCollectionView.snp.bottom)
            make.leading.equalTo(fullScrollView.snp.leading).offset(16)
            make.trailing.equalTo(fullScrollView.snp.trailing).offset(-16)
            make.height.equalTo(64)
        }
        
        noticeButtonImage.snp.makeConstraints { make in
            make.width.height.equalTo(32)
            make.centerY.equalTo(noticeButton.snp.centerY)
            make.leading.equalTo(noticeButton.snp.leading).offset(63)
        }
        
        noticeButtonLabel.snp.makeConstraints { make in
            make.centerY.equalTo(noticeButton.snp.centerY)
            make.leading.equalTo(noticeButtonImage.snp.trailing).offset(12)
        }
        
        noticeButtonCountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(noticeButton.snp.centerY)
            make.leading.equalTo(noticeButtonLabel.snp.trailing).offset(12)
        }
        
        examplePhotoLabel.snp.makeConstraints { make in
            make.top.equalTo(noticeButton.snp.bottom).offset(24)
            make.leading.equalTo(fullScrollView.snp.leading).offset(16)
            make.height.equalTo(23)
        }
        
        examplePhotoButton.snp.makeConstraints { make in
            make.top.equalTo(examplePhotoLabel.snp.bottom).offset(12)
            make.leading.equalTo(fullScrollView.snp.leading).offset(16)
            make.width.equalTo(120)
            make.height.equalTo(120)
        }
        
        examplePhotoButtonImage.snp.makeConstraints { make in
            make.top.equalTo(examplePhotoButton.snp.top).offset(25)
            make.width.height.equalTo(32)
            make.centerX.equalTo(examplePhotoButton.snp.centerX)
        }
        
        examplePhotoButtonLabel.snp.makeConstraints { make in
            make.top.equalTo(examplePhotoButtonImage.snp.bottom).offset(4)
            make.centerX.equalTo(examplePhotoButton.snp.centerX)
        }
        
        examplePhotoImage.snp.makeConstraints { make in
            make.top.equalTo(examplePhotoButton.snp.top)
            make.leading.equalTo(examplePhotoButton.snp.trailing).offset(8)
            make.width.height.equalTo(120)
        }
        
        photoCloseButton.snp.makeConstraints { make in
            make.top.equalTo(examplePhotoImage.snp.top).offset(4)
            make.trailing.equalTo(examplePhotoImage.snp.trailing).offset(-4)
            make.width.height.equalTo(24)
        }
        
        pointLabel.snp.makeConstraints { make in
            make.top.equalTo(examplePhotoButton.snp.bottom).offset(24)
            make.leading.equalTo(fullScrollView.snp.leading).offset(16)
            make.height.equalTo(23)
        }
        
        pointUnitLabel.snp.makeConstraints { make in
            make.centerY.equalTo(pointLabel.snp.centerY)
            make.leading.equalTo(pointLabel.snp.trailing).offset(16)
        }
        
        let pointButtonWidth = (UIScreen.main.bounds.width - 32) / 3.73
        let pointLabelWidth = (UIScreen.main.bounds.width - 32) / 2.39
        
        pointMinusButton.snp.makeConstraints { make in
            make.top.equalTo(pointLabel.snp.bottom).offset(12)
            make.leading.equalTo(fullScrollView.snp.leading).offset(16)
            make.height.equalTo(48)
            make.width.equalTo(pointButtonWidth)
        }
        
        pointIntLabel.snp.makeConstraints { make in
            make.centerY.equalTo(pointMinusButton.snp.centerY)
            make.leading.equalTo(pointMinusButton.snp.trailing).offset(8)
            make.height.equalTo(48)
            make.width.equalTo(pointLabelWidth)
        }
        
        pointPlusButton.snp.makeConstraints { make in
            make.centerY.equalTo(pointMinusButton.snp.centerY)
            make.leading.equalTo(pointIntLabel.snp.trailing).offset(8)
            make.height.equalTo(48)
            make.width.equalTo(pointButtonWidth)
        }
        
        bottomView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(80)
        }
        
        beforeButton.snp.makeConstraints { make in
            make.centerY.equalTo(bottomView.snp.centerY)
            make.leading.equalTo(bottomView.snp.leading).offset(38)
        }
        
        nextButton.snp.makeConstraints { make in
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
}
    
// MARK: - 이미지 피커, 텍스트 필드, 피커, 툴바 설정
extension RegisterSecondViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    // MARK: - 이미지 피커 설정
    func setImagePicker() {
        exampleImagePicker.delegate = self
        
        examplePhotoImage.isHidden = true
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
            if picker == exampleImagePicker {
                // imagePicker2에서 선택한 이미지를 사용하는 코드
                examplePhotoImage.image = image
                examplePhotoImage.isHidden = false  // 이미지 뷰 표시\
                examplePhotoButtonLabel.text = "사진 등록하기\n1/1"
                isNext[2] = true
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
        detailField.delegate = self
        
        // 화면 터치시 키보드 내려감
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == detailField {
            detailField.textColor = UIColor.beTextDef
            isNext[0] = true
        }
        
        updateNextButtonState()
        
        return true
    }
    
    // MARK: - 툴바 설정
    func setupToolBar() {
        let toolBar = UIToolbar()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonHandeler))
        
        toolBar.items = [flexibleSpace, doneButton]
        // 적절한 사이즈로 toolBar의 크기를 만들어 줍니다.
        toolBar.sizeToFit()
        
        detailField.inputAccessoryView = toolBar
    }
    
    // MARK: - actions
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    // 키보드 내리기
    @objc func doneButtonHandeler(_ sender: UIBarButtonItem) {
        detailField.resignFirstResponder()
    }
}


// MARK: - 뷰 커스텀을 위한 extension
extension RegisterSecondViewController {
    
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
    
    // MARK: - 이미지피커 버튼 커스텀 함수
    func customButton(action: Selector) -> UIButton {
        // 커스텀 버튼 전체
        lazy var customButton: UIButton = {
            let view = UIButton()
            
            view.backgroundColor = .beBgCard
            view.layer.cornerRadius = 10
            view.layer.borderWidth = 1
            view.layer.borderColor = UIColor.beBorderDis.cgColor
            view.addTarget(self, action: action, for: .touchUpInside)
            
            return view
        }()
        
        // 버튼 이미지
        lazy var buttonImage: UIImageView = {
            let view = UIImageView()
            
            view.image = UIImage(named: "camera")
            view.contentMode = .center
            view.tintColor = .beIconDef
            
            return view
        }()
        
        // 버튼 레이블
        lazy var buttonLabel: UILabel = {
            let view = UILabel()
            
            view.text = "사진 등록하기\n0/1"
            view.textColor = .beTextSub
            view.textAlignment = .center
            view.numberOfLines = 2
            view.font = UIFont(name: "NotoSansKR-Medium", size: 12)
            
            return view
        }()
        
        customButton.addSubview(buttonImage)
        customButton.addSubview(buttonLabel)
        
        buttonImage.snp.makeConstraints { make in
            make.top.equalTo(customButton.snp.top).offset(25)
            make.width.height.equalTo(32)
            make.centerX.equalTo(customButton.snp.centerX)
        }
        
        buttonLabel.snp.makeConstraints { make in
            make.top.equalTo(buttonImage.snp.bottom).offset(4)
            make.centerX.equalTo(customButton.snp.centerX)
        }
        
        return customButton
    }
    
    // MARK: - 챌린지 유의사항 레이블
    func noticeToolTipView() -> UIView {
        lazy var toolTipView: UIView = {
            let view = UIView()
            
            view.backgroundColor = .beBgPopUp.withAlphaComponent(0.8)
            view.layer.cornerRadius = 4
            
            return view
        }()
        
        // 챌린지 유의사항 툴팁
        lazy var title: UILabel = {
            let view = UILabel()
            
            view.text = "챌린지를 인증할 때 참가자들이 유의해/n야하는 내용을 알려주세요!"
            view.numberOfLines = 2
            view.textColor = .beTextWhite
            view.textAlignment = .left
            view.font = UIFont(name: "NotoSansKR-Medium", size: 11)
            
            return view
        }()
        
        // 챌린지 유의사항 툴팁 텀블러
        lazy var tumblur: UILabel = {
            let view = UILabel()
            
            view.text = "* 텀블러 사용 챌린지의 경우"
            view.textColor = .beTextWhite
            view.textAlignment = .left
            view.font = UIFont(name: "NotoSansKR-Medium", size: 11)
            
            return view
        }()
        
        lazy var tumblurEx: UILabel = {
            let view = UILabel()
            
            view.text = "텀블러를 손으로 잡고 찍어 주세요!"
            view.textColor = .beTextWhite
            view.textAlignment = .left
            view.font = UIFont(name: "NotoSansKR-Regular", size: 11)
            
            return view
        }()
        
        // 챌린지 유의사항 툴팁 플로깅
        lazy var flogging: UILabel = {
            let view = UILabel()
            
            view.text = "* 플로깅 챌린지의 경우"
            view.textColor = .beTextWhite
            view.numberOfLines = 2
            view.textAlignment = .left
            view.font = UIFont(name: "NotoSansKR-Medium", size: 11)
            
            return view
        }()
        
        lazy var floggingEx: UILabel = {
            let view = UILabel()
            
            view.text = "쓰레기를 줍는 사진으로 인증해 주세요!"
            view.textColor = .beTextWhite
            view.numberOfLines = 2
            view.textAlignment = .left
            view.font = UIFont(name: "NotoSansKR-Regular", size: 11)
            
            return view
        }()
        
        [title, tumblur, tumblurEx, flogging, floggingEx].forEach { view in
            toolTipView.addSubview(view)
        }
        
        title.snp.makeConstraints { make in
            make.top.equalTo(toolTipView.snp.top).offset(12)
            make.leading.equalTo(toolTipView.snp.leading).offset(12)
            make.trailing.equalTo(toolTipView.snp.trailing).offset(-12)
        }
        
        tumblur.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(12)
            make.leading.equalTo(toolTipView.snp.leading).offset(12)
        }
        
        tumblurEx.snp.makeConstraints { make in
            make.top.equalTo(tumblur.snp.bottom).offset(2)
            make.leading.equalTo(tumblur.snp.leading)
        }
        
        flogging.snp.makeConstraints { make in
            make.top.equalTo(tumblurEx.snp.bottom).offset(8)
            make.leading.equalTo(tumblur.snp.leading)
        }
        
        floggingEx.snp.makeConstraints { make in
            make.top.equalTo(flogging.snp.bottom).offset(2)
            make.leading.equalTo(tumblur.snp.leading)
        }
        
        return toolTipView
    }
}

// MARK: - collectionView setting(챌린지 유의사항 리스트)
extension RegisterSecondViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // 콜렉션뷰 세팅
    func setCollectionView() {
        noticeCollectionView.delegate = self
        noticeCollectionView.dataSource = self
        noticeCollectionView.register(NoticeCollectionViewCell.self, forCellWithReuseIdentifier: NoticeCollectionViewCell.identifier)
    }
    
    // 셀 개수 설정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return noticeLabels.count
    }
    
    // 셀 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoticeCollectionViewCell.identifier, for: indexPath) as?
                NoticeCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.noticeLabel.text = noticeLabels[indexPath.item]
        cell.deleteButton.addTarget(self, action: #selector(deleteButtonClicked(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    // 셀 크기 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - 32
        
        return CGSize(width: width , height: 48)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8 // 행 혹은 열 사이의 최소 간격
    }
    
    // MARK: - actions
    @objc func deleteButtonClicked(sender: UIButton) {
        if let cell = sender.superview?.superview as? NoticeCollectionViewCell {
            if let labelText = cell.noticeLabel.text,
               let index = noticeLabels.firstIndex(of: labelText) {
                noticeLabels.remove(at: index)
                // UICollectionView 다시 로드
                noticeCollectionView.reloadData()
                // 등록하기 숫자 업데이트
                noticeButtonCountLabel.text = "(\(noticeLabels.count)/5)"
                // 컬렉션뷰 높이 업데이트
                let collectionViewHeight = (noticeLabels.count * 48) + ((noticeLabels.count) * 8)
                noticeCollectionView.snp.updateConstraints { make in
                    make.height.equalTo(collectionViewHeight)
                }
                // 스크롤뷰 높이 업데이트
                let contentViewHeight = collectionViewHeight + 618
                fullContentView.snp.updateConstraints { make in
                    make.height.equalTo(contentViewHeight)
                }
            }
            
            if noticeLabels.count > 0 {
                isNext[1] = true
                updateNextButtonState()
            } else {
                isNext[1] = false
                updateNextButtonState()
            }
        }
    }
}

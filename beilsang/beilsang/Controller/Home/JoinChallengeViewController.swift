//
//  JoinChallengeViewController.swift
//  beilsang
//
//  Created by Seyoung on 2/7/24.
//

import UIKit
import SnapKit
import SCLAlertView
import SafariServices
import Kingfisher

class JoinChallengeViewController: UIViewController {
    
    //MARK: - Properties
    
    let verticalScrollView = UIScrollView()
    let verticalContentView = UIView()
    let imageConfig = UIImage.SymbolConfiguration(pointSize: 22, weight: .medium)

    var alertViewResponder: SCLAlertViewResponder? = nil
    
    // 신고하기 팝업
    
    lazy var reportAlert: SCLAlertView = {
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
    
    lazy var reportSubView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    lazy var reportLabel: UILabel = {
        let view = UILabel()
        view.text = "해당 인증 사진을 신고하는 게 맞을까요? \n 신고시 본 챌린저는 챌린지 실패로 처리됩니다"
        view.font = UIFont(name: "NotoSansKR-Medium", size: 12)
        view.numberOfLines = 2
        view.textColor = .beTextInfo
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        
        return view
    }()
    
    lazy var reportCancelButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .beBgSub
        button.setTitleColor(.beTextEx, for: .normal)
        button.setTitle("취소", for: .normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(close), for: .touchUpInside)
        
        return button
    }()
    
    lazy var reportButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .beScPurple600
        button.setTitleColor(.white, for: .normal)
        button.setTitle("신고하기", for: .normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(reportButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // 네비게이션 바 - 네비게이션 버튼
    lazy var navigationButton: UIBarButtonItem = {
        let view = UIBarButtonItem(image: UIImage(named: "icon-navigation"), style: .plain, target: self, action: #selector(navigationButtonClicked))
        view.tintColor = .beIconDef
        
        return view
    }()
    
    lazy var menu: UIMenu = {
        let menuAction = UIAction(title: "신고하기", image: nil, identifier: nil, discoverabilityTitle: nil, attributes: [], state: .off) { action in
            self.alertViewResponder = self.reportAlert.showInfo("챌린지 인증 신고하기")
        }
        
        return UIMenu(title: "", options: [], children: [menuAction])
    }()
    
    // 네비게이션 바 - 레이블
    lazy var challengeLabel: UILabel = {
        let view = UILabel()
        
        view.text = "챌린지"
        view.font = UIFont(name: "NotoSansKR-Medium", size: 20)
        view.textColor = .beTextDef
        view.textAlignment = .center
        
        return view
    }()
    
    //view
    lazy var representImageView : UIImageView = {
        let view = UIImageView()
        
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "NotoSansKR-SemiBold", size: 20)
        view.numberOfLines = 0
        view.textColor = .beTextDef
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var peopleNumLabel: UILabel = {
        let view = UILabel()
        view.backgroundColor = .beBgSub
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        view.font = UIFont(name: "NotoSansKR-Medium", size: 12)
        view.numberOfLines = 0
        view.textColor = .beNavy500
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        
        return view
    }()
    
    lazy var writerLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        view.numberOfLines = 0
        view.textColor = .beTextEx
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var writeDateLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        view.numberOfLines = 0
        view.textColor = .beTextEx
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .beTextEx
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var categoryView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.beBorderDis.cgColor
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var categoryIcon: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        view.numberOfLines = 0
        view.textColor = .beTextDef
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var categoryLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        view.numberOfLines = 0
        view.textColor = .beTextDef
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var progressTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "진행도"
        view.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        view.numberOfLines = 0
        view.textColor = .beTextInfo
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var progressView: UIProgressView = {
        let view = UIProgressView()
        view.trackTintColor = .beBgSub
        view.progressTintColor = .beScPurple400
        view.clipsToBounds = true
        view.subviews[1].clipsToBounds = true
        view.layer.cornerRadius = 8
        view.subviews[1].layer.cornerRadius = 8
        view.setProgress(0.25, animated: true)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var challengePeriodView: UIView = {
        let view = UIView()
        view.backgroundColor = .beBgSub
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var challengPeriodImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "challengePeriod")
        
        return view
    }()
    
    lazy var challengePeriodTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "실천 기간"
        view.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        view.numberOfLines = 0
        view.textColor = .beTextSub
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var challengePeriodLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "NotoSansKR-Regular", size: 12)
        view.numberOfLines = 0
        view.textColor = .beTextSub
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var divider1: UIView = {
        let view = UIView()
        view.backgroundColor = .beBgSub
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var galleryTitleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name:"NotoSansKR-Medium", size: 18)
        view.numberOfLines = 0
        view.text = "인증 갤러리 🙌"
        view.textColor = .beTextDef
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var gallerySubTitleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name:"NotoSansKR-Regular", size: 12)
        view.numberOfLines = 0
        view.text = "함께하는 챌린저들의 이야기를 봐볼까요? 🤩"
        view.textColor = .beTextEx
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    // 인증 갤러리 데이터 존재
    
    lazy var galleryCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
        return collectionView
    }()
    
    lazy var feedDetailCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
        return collectionView
    }()
    
    //인증 갤러리 데이터 존재 X
    lazy var notStartedLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name:"NotoSansKR-Regular", size: 12)
        view.numberOfLines = 0
        view.textColor = .beTextInfo
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var homeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .beBgDef
        button.setTitle("홈으로 돌아가기", for: .normal)
        button.setTitleColor(.beTextDef, for: .normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.beBorderDis.cgColor
        button.layer.cornerRadius = 20
        button.isEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(homeButtonTapped), for: .touchDown)
        
        return button
    }()
    
    lazy var reportLabelButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.isEnabled = true
        button.setTitle("신고하기", for: .normal)
        button.setTitleColor(.beTextEx, for: .normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Regular", size: 11)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(reportLabelButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    //bottom View
    lazy var bottomView: UIView = {
        let view = UIView()
        view.layer.shadowColor = UIColor.beTextDef.cgColor
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: 4, height: 4)
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 1
        view.backgroundColor = .beBgSub
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var bookMarkButton: UIButton = {
        let view = UIButton()
        let image = UIImage(systemName: "star", withConfiguration: imageConfig)
        let selectedImage = UIImage(systemName: "star.fill", withConfiguration: imageConfig)
        
        view.setImage(image, for: .normal)
        view.setImage(selectedImage, for: .selected)
        view.tintColor = .beScPurple600
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addTarget(self, action: #selector(bookMarkButtonTapped), for: .touchDown)
        return view
    }()
    
    lazy var bookMarkLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        view.numberOfLines = 0
        view.textColor = .beTextDef
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        
        return view
    }()
    
    lazy var proofButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .beScPurple400
        button.setTitle("인증하기", for: .normal)
        button.setTitleColor(.beTextWhite, for: .normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        button.layer.cornerRadius = 8
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(proofButtonTapped), for: .touchDown)
        
        return button
    }()
    
    var joinChallengeId : Int? = nil
    
    var challengeDetailData : ChallengeDetailData? = nil
    var challengeFeedData : [ChallengeJoinFeedData] = []
    
    var collectionViewHeight : Constraint?
    var viewHeight : Constraint?
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setFeedData()
        setChallengeData()
        
        setUI()
        setNavigationBar()
        setupUI()
        setupLayout()
        setCollectionView()
    }
    
    //MARK: - UI Setup
    private func setNavigationBar() {
        let menuButton: UIBarButtonItem = UIBarButtonItem(title: nil, image: UIImage(named: "icon-meatballs"), target: self, action: nil, menu: menu)
        menuButton.tintColor = .beIconDef
        
        navigationItem.titleView = challengeLabel
        navigationItem.leftBarButtonItem = navigationButton
        navigationItem.rightBarButtonItem = menuButton
    }
    
    private func setUI() {
        // 인증 피드 없을 때
        notStartedLabel.isHidden = true
        homeButton.isHidden = true
        // 인증 피드 있을 때
        galleryCollectionView.isHidden = true
        // 인증 피드 중 하나 선택했을 때
        feedDetailCollectionView.isHidden = true
        reportLabelButton.isHidden = true
    }
    
    private func setupUI() {
        view.backgroundColor = .beBgDef
        view.addSubview(verticalScrollView)
        view.addSubview(bottomView)
        
        verticalScrollView.addSubview(verticalContentView)
        
        reportAlert.customSubview = reportSubView
        reportSubView.addSubview(reportLabel)
        reportSubView.addSubview(reportCancelButton)
        reportSubView.addSubview(reportButton)
        
        [representImageView, titleLabel,peopleNumLabel,writerLabel,writeDateLabel, lineView, categoryView, progressTitleLabel,progressView,challengePeriodView, divider1, galleryTitleLabel,gallerySubTitleLabel, notStartedLabel, homeButton, galleryCollectionView, feedDetailCollectionView, reportLabelButton].forEach{view in verticalContentView.addSubview(view)}
        
        [bookMarkButton, bookMarkLabel, proofButton].forEach{ view in bottomView.addSubview(view)}
        
        [categoryIcon, categoryLabel].forEach({view in categoryView.addSubview(view)})
        
        [challengePeriodTitleLabel,challengePeriodLabel,challengPeriodImageView].forEach({view in challengePeriodView.addSubview(view)})
    }
    
    private func setupLayout() {
        
        let width = UIScreen.main.bounds.width
        
        verticalScrollView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        verticalContentView.snp.makeConstraints { make in
            make.edges.equalTo(verticalScrollView.contentLayoutGuide)
            make.width.equalTo(verticalScrollView.frameLayoutGuide)
            viewHeight = make.height.equalTo(0).constraint
        }
        
        representImageView.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.width.equalTo(width)
            make.height.equalTo(240)
        }
        
        titleLabel.snp.makeConstraints{ make in
            make.top.equalTo(representImageView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(29)
        }
        
        peopleNumLabel.snp.makeConstraints{ make in
            make.centerY.equalTo(titleLabel)
            make.trailing.equalToSuperview().offset(-16)
            make.width.equalTo(86)
            make.height.equalTo(24)
        }
        
        writerLabel.snp.makeConstraints{ make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(21)
        }
        
        lineView.snp.makeConstraints{ make in
            make.centerY.equalTo(writerLabel)
            make.leading.equalTo(writerLabel.snp.trailing).offset(8)
            make.height.equalTo(18)
            make.width.equalTo(0.75)
        }
        
        writeDateLabel.snp.makeConstraints{ make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.equalTo(lineView.snp.trailing).offset(8)
            make.height.equalTo(21)
        }
        
        categoryView.snp.makeConstraints{ make in
            make.top.equalTo(writerLabel.snp.bottom).offset(28)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(40)
        }
        
        categoryIcon.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
        
        categoryLabel.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(categoryIcon.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        progressTitleLabel.snp.makeConstraints{ make in
            make.top.equalTo(categoryView.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(21)
        }
        
        progressView.snp.makeConstraints{ make in
            make.centerY.equalTo(progressTitleLabel)
            make.leading.equalTo(progressTitleLabel.snp.trailing).offset(24)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(16)
        }
        
        challengePeriodView.snp.makeConstraints{ make in
            make.top.equalTo(progressTitleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(72)
        }
        
        challengPeriodImageView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(14)
            make.leading.equalToSuperview().offset(19)
            make.width.height.equalTo(20)
        }
        
        challengePeriodTitleLabel.snp.makeConstraints{ make in
            make.centerY.equalTo(challengPeriodImageView)
            make.leading.equalTo(challengPeriodImageView.snp.trailing).offset(4)
        }
        
        challengePeriodLabel.snp.makeConstraints{ make in
            make.bottom.equalToSuperview().offset(-14)
            make.leading.equalToSuperview().offset(19)
        }
        
        divider1.snp.makeConstraints{ make in
            make.top.equalTo(challengePeriodView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(8)
        }
        
        galleryTitleLabel.snp.makeConstraints{ make in
            make.top.equalTo(divider1.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(26)
        }
        
        gallerySubTitleLabel.snp.makeConstraints{ make in
            make.top.equalTo(galleryTitleLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(17)
        }
        
        notStartedLabel.snp.makeConstraints{ make in
            make.top.equalTo(gallerySubTitleLabel.snp.bottom).offset(48)
            make.centerX.equalToSuperview()
            make.height.equalTo(17)
        }
        
        homeButton.snp.makeConstraints{ make in
            make.top.equalTo(notStartedLabel.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(75)
            make.trailing.equalToSuperview().offset(-75)
            make.height.equalTo(40)
            make.bottom.equalTo(verticalContentView.snp.bottom).offset(-84)
        }
        
        galleryCollectionView.snp.makeConstraints{ make in
            make.top.equalTo(gallerySubTitleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            collectionViewHeight = make.height.equalTo(0).constraint
        }
        
        feedDetailCollectionView.snp.makeConstraints { make in
            make.top.equalTo(galleryCollectionView.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(647)
        }
        
        reportLabelButton.snp.makeConstraints{ make in
            make.top.equalTo(feedDetailCollectionView.snp.bottom).offset(12)
            make.trailing.equalTo(verticalContentView.snp.trailing).offset(-16)
        }
        
        bottomView.snp.makeConstraints{ make in
            make.bottom.equalToSuperview()
            make.height.equalTo(96)
            make.leading.trailing.equalToSuperview()
        }
        
        bookMarkButton.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(28)
            make.height.width.equalTo(30)
        }
        
        bookMarkLabel.snp.makeConstraints{ make in
            make.top.equalTo(bookMarkButton.snp.bottom)
            make.centerX.equalTo(bookMarkButton)
        }
        
        proofButton.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(14)
            make.trailing.equalToSuperview().offset(-28)
            make.width.equalTo(140)
            make.height.equalTo(52)
        }
        
        //신고하기 팝업
        reportSubView.snp.makeConstraints{ make in
            make.width.equalTo(318)
            make.height.equalTo(120)
        }
        
        reportCancelButton.snp.makeConstraints{ make in
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview().offset(-6)
            make.height.equalTo(48)
            make.trailing.equalTo(reportSubView.snp.centerX).offset(-3)
        }
        
        reportButton.snp.makeConstraints{ make in
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-6)
            make.height.equalTo(48)
            make.leading.equalTo(reportSubView.snp.centerX).offset(3)
        }
        
        reportLabel.snp.makeConstraints{ make in
            make.bottom.equalTo(reportCancelButton.snp.top).offset(-28)
            make.centerX.equalToSuperview()
        }
    }

    //MARK: - Toast Popup
    lazy var toastLabel: UILabel = {
        let view = UILabel()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        view.textColor = .white
        view.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        view.textAlignment = .center
        //other text = "🌳 현재 진행도는 70%입니다!"
        view.alpha = 1.0
        view.layer.cornerRadius = 20
        view.clipsToBounds  =  true
        
        return view
    }()
    
    private func showToast() {
        self.view.addSubview(toastLabel)
        
        toastLabel.snp.makeConstraints { make in
            make.bottom.equalTo(bottomView.snp.top).offset(12)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(44)
        }
        
        UIView.animate(withDuration: 2, delay: 1, options: .curveEaseOut, animations: {
            self.toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            self.toastLabel.removeFromSuperview()
        })
    }
    
    //MARK: - Actions
    // 네비게이션 아이템 누르면 alert 띄움
    @objc func navigationButtonClicked() {
        print("챌린지 작성 취소")
        navigationController?.popViewController(animated: true)
    }
    
    @objc func proofButtonTapped(_ sender: UIButton) {
        print("인증인증")
        
        let challengeId = joinChallengeId
        let certifyVC = RegisterCertifyViewController()
        certifyVC.reviewChallengeId = challengeId
        certifyVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(certifyVC, animated: true)
    }
    
    @objc func reportLabelButtonTapped() {
        print("버튼클릭")
        alertViewResponder = reportAlert.showInfo("챌린지 인증 신고하기")
    }
    
    @objc func bookMarkButtonTapped() {
        if bookMarkButton.isSelected {
            deleteBookmark()
        } else {
            postBookmark()
        }
    }
    
    @objc func reportButtonTapped() {
        let reportUrl = NSURL(string: "https://moaform.com/q/dcQIJc")
        let reportSafariView: SFSafariViewController = SFSafariViewController(url: reportUrl! as URL)
        self.present(reportSafariView, animated: true, completion: nil)
        alertViewResponder?.close()
    }
    
    @objc func close(){
        alertViewResponder?.close()
    }
    
    @objc func exitButtonTapped(_ sender: UIButton) {
        print("exitButton Tapped")
        setFeedData()
    }
    
    @objc func homeButtonTapped(_ sender: UIButton) {
        let homeVC = HomeMainViewController()

        if let navigationController = self.navigationController {
            navigationController.setViewControllers([homeVC], animated: true)
            //처리가 어떻게 될지 모르겠음
        }
    }
}
    
// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension JoinChallengeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func setCollectionView() {
        [galleryCollectionView, feedDetailCollectionView].forEach { view in
            view.delegate = self
            view.dataSource = self
        }
        
        //Cell 등록
        galleryCollectionView.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.identifier)
        feedDetailCollectionView.register(FeedDetailCollectionViewCell.self, forCellWithReuseIdentifier: FeedDetailCollectionViewCell.identifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case galleryCollectionView:
            return challengeFeedData.count
        case feedDetailCollectionView:
            return 1
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case galleryCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.identifier, for: indexPath) as?
                    GalleryCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let url = URL(string: challengeFeedData[indexPath.row].feedUrl)
            cell.galleryImage.kf.setImage(with: url)
            
            return cell
        case feedDetailCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedDetailCollectionViewCell.identifier, for: indexPath) as?
                    FeedDetailCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.delegate = self
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case galleryCollectionView:
            let width = (UIScreen.main.bounds.width - 48) / 2
            
            return CGSize(width: width, height: 140)
        case feedDetailCollectionView:
            let detailWidth = UIScreen.main.bounds.width - 32
            
            return CGSize(width: detailWidth, height: 647)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == galleryCollectionView {
            let cell = collectionView.cellForItem(at: indexPath) as! GalleryCollectionViewCell
            feedDetailCollectionView.isHidden = false
            reportLabelButton.isHidden = false
            
            self.showFeedDetail(feedId: cell.feedId ?? 0, feedImage: cell.galleryImage.image!)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == galleryCollectionView {
            return 16 // 행 혹은 열 사이의 최소 간격
        }
        return 0
    }
}

// MARK: - 참여 중 챌린지 세팅
extension JoinChallengeViewController {
    // 챌린지의 모든 데이터를 가져오는 함수
    func setChallengeData() {
        ChallengeService.shared.challengeDetail(detailChallengeId: joinChallengeId ?? 0) { response in
            self.challengeDetailData = response.data
            
            let representURL = URL(string: (response.data.imageUrl!))
            self.representImageView.kf.setImage(with: representURL) // 대표 사진 이미지
            self.titleLabel.text = response.data.title // 챌린지 제목
            self.peopleNumLabel.text = "\(response.data.attendeeCount)명 참여중" // 참여 중인 유저 수
            self.writerLabel.text = response.data.hostName // 작성자
            self.writeDateLabel.text = response.data.createdDate // 작성일: yyyy-MM-dd
            let categoryIcon = CategoryConverter.shared.convertToIcon(response.data.category)
            self.categoryIcon.text = categoryIcon // 카테고리 아이콘
            let categoryText = CategoryConverter.shared.convertToKorean(response.data.category)
            self.categoryLabel.text = categoryText // 카테고리 한글
            let startDate = DateConverter.shared.convertJoin(from: response.data.startDate) // 시작일
            self.challengeStartDateCheck(date: response.data.startDate)
            let period = PeriodConverter.shared.convertToKorean(response.data.period) // 실천 기간
            self.updatePeriodLabel(weekCountText: period ?? "", sessionCountText: response.data.totalGoalDay, startDateText: startDate!)
            self.bookMarkButton.isSelected = response.data.like // 북마크 했는지 여부
            self.bookMarkLabel.text = String(response.data.likes) // 북마크 수
            
            self.toastLabel.text = "📆 챌린지가 \(response.data.dday)일 뒤 시작됩니다!"
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            if let date = dateFormatter.date(from: response.data.startDate) {
                // 서버에서 넘겨준 startDate를 오늘 날짜와 비교
                let today = Date()
                let result = date.compare(today)
                if result == .orderedAscending {
                    self.notStartedLabel.text = "아직 챌린지가 시작되지 않았어요👀"
                } else {
                    self.notStartedLabel.text = "아직 인증 갤러리 피드가 없어요👀"
                }
            }
        }
    }
    
    func setFeedData() {
        ChallengeService.shared.challengeFeed(joinFeedChallengeId: joinChallengeId ?? 0) { response in
            if response.data?.feeds.count == 0 {
                self.notStartedLabel.isHidden = false
                self.homeButton.isHidden = false
                self.viewHeight!.update(offset: 875)
            } else {
                self.setChallengesFeedList(response.data!.feeds)
                self.galleryCollectionView.isHidden = false
            }
        }
    }
    
    @MainActor
    private func setChallengesFeedList(_ response: [ChallengeJoinFeedData]) {
        self.challengeFeedData = response
        self.galleryCollectionView.reloadData()
        
        if challengeFeedData.count < 3 {
            let height = 140
            self.collectionViewHeight!.update(offset: height)
            self.viewHeight!.update(offset: 694 + height)
        } else {
            let height = 292
            self.collectionViewHeight!.update(offset: height)
            self.viewHeight!.update(offset: 694 + height)
        }
    }
    
    func showFeedDetail(feedId: Int, feedImage: UIImage){
        let feedCell = feedDetailCollectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as! FeedDetailCollectionViewCell
        
        MyPageService.shared.getMyPageFeedDetail(baseEndPoint: .feeds, addPath: "/\(String(describing: feedId))") { response in
            feedCell.reviewContent.text = response.data.review
            if response.data.day > 3{
                feedCell.dateLabel.text = response.data.uploadDate
            } else {
                feedCell.dateLabel.text = "\(response.data.day)일 전"
            }
            feedCell.feedImage.image = feedImage
            feedCell.titleTag.text = "#\(response.data.challengeTitle)"
            feedCell.categoryTag.text = "#\(response.data.category)"
            feedCell.nicknameLabel.text = response.data.nickName
            if let imageUrl = response.data.profileImage {
                let url = URL(string: response.data.profileImage!)
                feedCell.profileImage.kf.setImage(with: url)
            }
            if response.data.like {
                feedCell.heartButton.setImage(UIImage(named: "iconamoon_fullheart-bold"), for: .normal)
            }
        }
        
        let height = 647
        self.viewHeight!.update(offset: 694 + height)
    }
    
    // 실천 기간과 횟수만 빨간색 글자로 바꾸기 위한 함수
    func updatePeriodLabel(weekCountText: String, sessionCountText: Int, startDateText: String) {
        let fullText = "시작일(\(startDateText))로부터 \(weekCountText) 동안 \(sessionCountText)회 진행"
        
        let attributedText = NSMutableAttributedString(string: fullText)
        
        let range = (fullText as NSString).range(of: "\(weekCountText) 동안 \(sessionCountText)회")
        
        attributedText.addAttribute(.foregroundColor, value: UIColor.beCta, range: range)
        
        let font = UIFont(name: "NotoSansKR-Medium", size: 12)
        attributedText.addAttribute(.font, value: font!, range: range)
        
        challengePeriodLabel.attributedText = attributedText
    }
    
    func challengeStartDateCheck(date: String) {
        let check = checkDate(with: date)
        
        if check {
            proofButton.isEnabled = true
            proofButton.backgroundColor = .beScPurple600
        } else {
            proofButton.isEnabled = false
            proofButton.backgroundColor = .beScPurple400
        }
    }
    
    func checkDate(with dateString: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: dateString) {
            let today = Date()
            let result = date.compare(today)
            return result == .orderedSame || result == .orderedAscending
        } else {
            print("날짜 변환에 실패했습니다.")
            return false
        }
    }
}

// MARK: - 챌린지 북마크 post, delete
extension JoinChallengeViewController {
    func postBookmark() {
        ChallengeService.shared.challengeBookmarkPost(likeChallengeId: joinChallengeId ?? 0) { response in
            print(response)
            
            ChallengeService.shared.challengeDetail(detailChallengeId: self.joinChallengeId ?? 0) { response in
                self.challengeDetailData = response.data
                
                self.bookMarkButton.isSelected = response.data.like // 북마크 했는지 여부
                self.bookMarkLabel.text = String(response.data.likes) // 북마크 수
            }
        }
    }
    
    func deleteBookmark() {
        ChallengeService.shared.challengeBookmarkDelete(dislikeChallengeId: joinChallengeId ?? 0) { response in
            print(response)
            
            ChallengeService.shared.challengeDetail(detailChallengeId: self.joinChallengeId ?? 0) { response in
                self.challengeDetailData = response.data
                
                self.bookMarkButton.isSelected = response.data.like // 북마크 했는지 여부
                self.bookMarkLabel.text = String(response.data.likes) // 북마크 수
            }
        }
    }
}

extension JoinChallengeViewController: CustomFeedCellDelegate {
    func didTapRecommendButton(id: Int) {} // 다른 컨트롤러에서 이용하는 것
    
    func didTapReportButton() {} // 다른 컨트롤러에서 이용하는 것
    
    func didTapButton() {
        feedDetailCollectionView.isHidden = true
    }
}

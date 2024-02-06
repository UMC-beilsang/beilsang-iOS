//
//  JoinChallengeViewController.swift
//  beilsang
//
//  Created by Seyoung on 2/2/24.
//

import UIKit
import SnapKit
import SCLAlertView
import SafariServices

class JoinChallengeViewController: UIViewController {
    
    //MARK: - Properties
    
    let verticalScrollView = UIScrollView()
    let verticalContentView = UIView()
    let galleryDataList = GalleryData.data
    let imageConfig = UIImage.SymbolConfiguration(pointSize: 22, weight: .medium)
    let galleryDetailView = UIView()

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
    
    //view
    
    lazy var representImageView : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "representImage")
        
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "우리 가치 플로깅하자  👀👟"
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
        view.text = "62명 참여중"
        view.font = UIFont(name: "NotoSansKR-Medium", size: 12)
        view.numberOfLines = 0
        view.textColor = .beNavy500
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        
        return view
    }()
    
    lazy var writerLabel: UILabel = {
        let view = UILabel()
        view.text = "작성자명"
        view.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        view.numberOfLines = 0
        view.textColor = .beTextEx
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var writeDateLabel: UILabel = {
        let view = UILabel()
        view.text = "작성일"
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
        view.text = "👟"
        view.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        view.numberOfLines = 0
        view.textColor = .beTextDef
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var categoryLabel: UILabel = {
        let view = UILabel()
        view.text = "플로깅"
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
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.identifier)
        return collectionView
    }()
    
    //인증 갤러리 데이터 존재 X
    
    lazy var notStartedLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name:"NotoSansKR-Regular", size: 12)
        view.numberOfLines = 0
        view.text = "아직 챌린지가 시작되지 않았어요 👀"
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
    
    // 인증갤러리 세부화면
    
    lazy var selectedCellImageView : UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.beBorderDis.cgColor
        
        return view
    }()
    
    lazy var profileImageView : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "profileImage")
        view.layer.shadowColor = UIColor.beTextDef.cgColor
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.12
        
        return view
    }()
    
    lazy var nickNameLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name:"NotoSansKR-Medium", size: 16)
        view.numberOfLines = 0
        view.text = "춤추는 텀블러"
        view.textColor = .beTextDef
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var dayBeforeLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name:"NotoSansKR-Medium", size: 12)
        view.numberOfLines = 0
        view.text = "1일 전"
        view.textColor = .beTextSub
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var heartButton: UIButton = {
        let view = UIButton()
        let image = UIImage(named:"heart")
        view.setImage(image, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
        return view
    }()
    
    lazy var categoryTagLabel: UILabel = {
        //카테고리 받아와서 text로 설정
        let view = UILabel()
        view.font = UIFont(name:"NotoSansKR-Medium", size: 12)
        view.numberOfLines = 0
        view.text = "#\(categoryLabel.text ?? "")"
        view.textColor = .beTextSub
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var titleTagLabel: UILabel = {
        // 이모지 뺀 챌린지 제목 받아와서 text로 설정
        let titleWithoutSpecialCharacters = titleLabel.text?.textWithoutSpecialCharacters ?? ""
        let view = UILabel()
        view.font = UIFont(name:"NotoSansKR-Medium", size: 12)
        view.numberOfLines = 0
        view.text = "#\(titleWithoutSpecialCharacters)"
        view.textColor = .beTextSub
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var reviewTitleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name:"NotoSansKR-Medium", size: 14)
        view.numberOfLines = 0
        view.text = "챌린지 후기"
        view.textColor = .beTextSub
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var reviewView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.backgroundColor = .beBgSub
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var reviewLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name:"NotoSansKR-Medium", size: 14)
        view.numberOfLines = 0
        view.text = "플로깅을 하면서 즐거운 경험을 할 수 있었습니다! 친환경을 위해 앞장설 수 있어서 좋았어요!"
        view.textColor = .beTextSub
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
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
    
    lazy var exitButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "xicon"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = true
        button.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
        
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
        view.setImage(image, for: .normal)
        view.tintColor = .beScPurple600
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(bookMarkButtonTapped), for: .touchUpInside)
    
        return view
    }()
    
    lazy var bookMarkLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        view.text = "121"
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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        updateChallengeLabelText()
        setGalleryView()
    }
    
    //MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = .beBgDef
        view.addSubview(verticalScrollView)
        view.addSubview(bottomView)
        
        verticalScrollView.addSubview(verticalContentView)
        
        reportAlert.customSubview = reportSubView
        reportSubView.addSubview(reportLabel)
        reportSubView.addSubview(reportCancelButton)
        reportSubView.addSubview(reportButton)
        
        [representImageView, titleLabel,peopleNumLabel,writerLabel,writeDateLabel, lineView, categoryView, progressTitleLabel,progressView,challengePeriodView, divider1, galleryTitleLabel,gallerySubTitleLabel].forEach{view in verticalContentView.addSubview(view)}
        
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
            make.height.equalTo(1500)
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
        }
        
        categoryView.snp.makeConstraints{ make in
            make.top.equalTo(writerLabel.snp.bottom).offset(28)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(108)
            make.height.equalTo(40)
        }
        
        categoryIcon.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
        
        categoryLabel.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
        }
        
        progressTitleLabel.snp.makeConstraints{ make in
            make.top.equalTo(categoryView.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(16)
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
        }
        
        gallerySubTitleLabel.snp.makeConstraints{ make in
            make.top.equalTo(galleryTitleLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(16)
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
  
    //MARK: - UpdateLabel
    
    private func updateChallengeLabelText() {
        let weekCountText = "일주일"//"\(challengeModel.weekCount) weeks"
        let sessionCountText = "5"//"\(challengeModel.sessionCount) sessions"
        let startDateText = "1/11"
        
        let fullText = "시작일(\(startDateText))로부터 \(weekCountText) 동안 \(sessionCountText)회 진행"
        
        let attributedText = NSMutableAttributedString(string: fullText)
        
        let weekCountRange = (fullText as NSString).range(of: "\(weekCountText) 동안")
        let sessionCountRange = (fullText as NSString).range(of: "\(sessionCountText)회")

        attributedText.addAttribute(.foregroundColor, value: UIColor.beCta, range: weekCountRange)
        attributedText.addAttribute(.foregroundColor, value: UIColor.beCta, range: sessionCountRange)
        
        let font = UIFont(name: "NotoSansKR-Medium", size: 12)
        attributedText.addAttribute(.font, value: font!, range: weekCountRange)
        attributedText.addAttribute(.font, value: font!, range: sessionCountRange)
        
        challengePeriodLabel.attributedText = attributedText
    }
    
    //MARK: - Toast Popup
    
    private func showChallengeLeftDayToast() {
        let toastLabel = UILabel()
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = .white
        toastLabel.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        toastLabel.textAlignment = .center
        toastLabel.text = "📆 챌린지가 1일 뒤 시작됩니다!"
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 20
        toastLabel.clipsToBounds  =  true
        
        self.view.addSubview(toastLabel)
        
        toastLabel.snp.makeConstraints { make in
            make.bottom.equalTo(bottomView.snp.top).offset(12)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(44)
        }
        
        UIView.animate(withDuration: 2, delay: 1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    // MARK: - Button Disabled
    
    private func challengeStartDateCheck() {
        // challengeStartDate가 현재 날짜이거나, 지남
        let check = false
        
        if check {
            proofButton.isEnabled = true
            proofButton.backgroundColor = .beScPurple600
        } else {
            proofButton.isEnabled = false
            proofButton.backgroundColor = .beScPurple400
        }
    }
    
    //MARK: - Actions
    
    @objc func proofButtonTapped(_ sender: UIButton) {
        print("인증인증")
    }
    
    @objc func reportLabelButtonTapped(_ sender: UIButton) {
        print("버튼클릭")
        alertViewResponder = reportAlert.showInfo("챌린지 인증 신고하기")
    }
    
    @objc func heartButtonTapped() {
        heartButton.isSelected = !heartButton.isSelected
        
        let image = UIImage(named:"heart")
        let selectedImage = UIImage(named: "heartfill")
        
        if heartButton.isSelected {
            heartButton.setImage(selectedImage, for: .selected)
        } else {
            heartButton.setImage(image, for: .normal)
        }
    }
    
    @objc func bookMarkButtonTapped() {
        bookMarkButton.isSelected = !bookMarkButton.isSelected
        
        let image = UIImage(systemName: "star", withConfiguration: imageConfig)
        let selectedImage = UIImage(systemName: "star.fill", withConfiguration: imageConfig)
        
        if bookMarkButton.isSelected {
            bookMarkButton.setImage(selectedImage, for: .selected)
        } else {
            bookMarkButton.setImage(image, for: .normal)
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
        setGalleryView()
    }
    
    @objc func homeButtonTapped(_ sender: UIButton) {
        let homeVC = HomeMainViewController()

        if let navigationController = self.navigationController {
            navigationController.setViewControllers([homeVC], animated: true)
            //처리가 어떻게 될지 모르겠음
        }
    }
}

//MARK: - 인증갤러리 뷰 변경

extension JoinChallengeViewController {
    func setGalleryView() {
        galleryCollectionView.isHidden = false
        galleryDetailView.isHidden = true
        
        if galleryDataList.count == 0 {
            
            verticalContentView.addSubview(notStartedLabel)
            verticalContentView.addSubview(homeButton)
            
            notStartedLabel.snp.makeConstraints{ make in
                make.top.equalTo(gallerySubTitleLabel.snp.bottom).offset(48)
                make.centerX.equalToSuperview()
            }
            
            homeButton.snp.makeConstraints{ make in
                make.top.equalTo(notStartedLabel.snp.bottom).offset(12)
                make.centerX.equalToSuperview()
                make.leading.equalToSuperview().offset(75)
                make.trailing.equalToSuperview().offset(-75)
                make.height.equalTo(40)
            }
        }
        else {
            verticalContentView.addSubview(galleryCollectionView)
            
            let cellHeight: CGFloat = 140
            
            galleryCollectionView.snp.makeConstraints{ make in
                make.top.equalTo(gallerySubTitleLabel.snp.bottom).offset(20)
                make.leading.equalToSuperview().offset(16)
                make.trailing.equalToSuperview().offset(-16)
                make.height.equalTo(cellHeight * CGFloat(galleryDataList.count / 2) + 12 * (CGFloat(galleryDataList.count / 2) - 1))
            }
        }
    }
    
    func setGalleryDetail(at index: IndexPath) {
        galleryDetailView.isHidden = false
        galleryCollectionView.isHidden = true
        
        verticalContentView.addSubview(galleryDetailView)
        
        // 다른 뷰에 추가
        [selectedCellImageView, exitButton, profileImageView, nickNameLabel, dayBeforeLabel, heartButton, categoryTagLabel,titleTagLabel, reviewTitleLabel, reviewView, reportLabelButton].forEach{view in galleryDetailView.addSubview(view)}
        
        reviewView.addSubview(reviewLabel)
        
        galleryDetailView.snp.makeConstraints{ make in
            make.top.equalTo(gallerySubTitleLabel.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        selectedCellImageView.snp.makeConstraints{ make in
            make.height.width.equalTo(358)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        exitButton.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-26)
            make.height.width.equalTo(32)
        }
        
        profileImageView.snp.makeConstraints{ make in
            make.top.equalTo(selectedCellImageView.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(26)
            make.height.width.equalTo(48)
        }
        
        nickNameLabel.snp.makeConstraints{ make in
            make.top.equalTo(profileImageView.snp.top).offset(2)
            make.leading.equalTo(profileImageView.snp.trailing).offset(16)
        }
        
        dayBeforeLabel.snp.makeConstraints{ make in
            make.top.equalTo(nickNameLabel.snp.bottom).offset(4)
            make.leading.equalTo(nickNameLabel)
        }
        
        heartButton.snp.makeConstraints{ make in
            make.trailing.equalToSuperview().offset(-26)
            make.centerY.equalTo(profileImageView)
            make.height.width.equalTo(40)
        }
        
        categoryTagLabel.snp.makeConstraints{ make in
            make.top.equalTo(profileImageView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(26)
        }
        
        titleTagLabel.snp.makeConstraints{ make in
            make.top.equalTo(profileImageView.snp.bottom).offset(16)
            make.leading.equalTo(categoryTagLabel.snp.trailing).offset(8)
        }
        
        reviewTitleLabel.snp.makeConstraints{ make in
            make.top.equalTo(categoryTagLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
        }
        
        reviewView.snp.makeConstraints { make in
            make.top.equalTo(reviewTitleLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.greaterThanOrEqualTo(140)
        }
        
        reviewLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(19)
            make.trailing.equalToSuperview().offset(-19)
            make.top.equalToSuperview().offset(14)
        }

    
        
        reportLabelButton.snp.makeConstraints{ make in
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(reviewView.snp.bottom).offset(12)
        }
        
    }
}
    
    
    
// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

extension JoinChallengeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return galleryDataList.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.identifier, for: indexPath) as?
                GalleryCollectionViewCell else {
            return UICollectionViewCell()
        }
        let target = galleryDataList[indexPath.row]
        
        cell.galleryImage.image = UIImage(named: target.image)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let cellWidth = (collectionViewWidth - 16) / 2
        
        return CGSize(width: cellWidth, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? GalleryCollectionViewCell
        
        selectedCellImageView.image = cell?.galleryImage.image
        setGalleryDetail(at: indexPath)

    }
}

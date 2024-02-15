//
//  ChallengeDetailViewController.swift
//  beilsang
//
//  Created by Seyoung on 2/7/24.
//

import UIKit
import SnapKit
import SCLAlertView
import SafariServices
import Kingfisher

class ChallengeDetailViewController: UIViewController {
    
    //MARK: - Properties
    
    let verticalScrollView = UIScrollView()
    let verticalContentView = UIView()
    
    let cautionDataList = CautionChallenge.data
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
        view.text = "해당 챌린지의 신고 사유가 무엇인가요? \n 하단 링크를 통해 알려 주세요!"
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

    // 참여하기 팝업
    
    lazy var joinAlert: SCLAlertView = {
        let apperance = SCLAlertView.SCLAppearance(
            kWindowWidth: 342, kWindowHeight : 321,
            kTitleFont: UIFont(name: "NotoSansKR-SemiBold", size: 18)!,
            showCloseButton: false,
            showCircularIcon: false,
            dynamicAnimatorActive: false
        )
        let alert = SCLAlertView(appearance: apperance)
        
        return alert
    }()
    
    lazy var joinSubView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    lazy var popUpSubView: UIView = {
        let view = UIView()
        view.backgroundColor = .beBgSub
        
        return view
    }()
    
    lazy var popLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .beBorderDis
        
        return view
    }()
    
    lazy var popPointMinTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "챌린지 최소 참여 포인트"
        view.font = UIFont(name: "NotoSansKR-Medium", size: 12)
        view.numberOfLines = 0
        view.textColor = .beTextSub
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var popPeriodTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "챌린지 실천 기간"
        view.font = UIFont(name: "NotoSansKR-Medium", size: 12)
        view.numberOfLines = 0
        view.textColor = .beTextSub
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var popPointLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "NotoSansKR-SemiBold", size:14)
        view.numberOfLines = 0
        view.textColor = .beCta
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var popPeriodLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        view.numberOfLines = 0
        view.textColor = .beTextInfo
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var popLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        view.text = "해당 챌린지를 참여할까요? 👀"
        view.numberOfLines = 0
        view.textColor = .beTextInfo
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var popCancelButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .beBgSub
        button.setTitleColor(.beTextEx, for: .normal)
        button.setTitle("취소", for: .normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(close), for: .touchUpInside)
        
        return button
    }()
    
    lazy var popJoinButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .beScPurple600
        button.setTitleColor(.white, for: .normal)
        button.setTitle("참여하기", for: .normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(popJoinButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //토스트 팝업
    
    lazy var toastLabel : UILabel = {
        let view = UILabel()
        view.text = "🌱 함께 참여하고 친환경 일상을 만들어요!"
        view.textColor = .white
        view.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.textAlignment = .center
        view.backgroundColor = .beTextDef.withAlphaComponent(0.8)
        view.isHidden = false
        
        return view
    }()
    
    //컬렉션뷰
    
    lazy var recommendCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(RecommendCollectionViewCell.self, forCellWithReuseIdentifier: RecommendCollectionViewCell.identifier)
        return collectionView
    }()
    
    lazy var cautionCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CautionCollectionViewCell.self, forCellWithReuseIdentifier: CautionCollectionViewCell.identifier)
        collectionView.backgroundColor = .beBgSub
        return collectionView
    }()
    
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
    
    lazy var startDateTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "시작일"
        view.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        view.numberOfLines = 0
        view.textColor = .beTextSub
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var leftDayLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        view.numberOfLines = 0
        view.textColor = .beWnRed500
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var startDateLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        view.numberOfLines = 0
        view.textColor = .beTextDef
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var joinPointTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "참여 포인트"
        view.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        view.numberOfLines = 0
        view.textColor = .beTextSub
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var joinPointLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        view.numberOfLines = 0
        view.textColor = .beTextDef
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
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
    
    lazy var detailTitleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "NotoSansKR-SemiBold", size: 14)
        view.text = "세부 설명"
        view.numberOfLines = 0
        view.textColor = .beTextSub
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var detailView: UIView = {
        let view = UIView()
        view.backgroundColor = .beBgSub
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var detailLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        view.numberOfLines = 5
        view.textColor = .beTextDef
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var cautionTitleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "NotoSansKR-SemiBold", size: 14)
        view.text = "챌린지 유의사항"
        view.numberOfLines = 0
        view.textColor = .beTextSub
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var cautionDetailLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "NotoSansKR-Regular", size: 12)
        view.text = "아래 챌린지 모범 인증 사진을 확인해 보세요!"
        view.numberOfLines = 0
        view.textColor = .beTextInfo
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var cautionView: UIView = {
        let view = UIView()
        view.backgroundColor = .beBgSub
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var cautionImageView: UIImageView = {
        let view = UIImageView()
        
        return view
    }()
    
    lazy var divider2: UIView = {
        let view = UIView()
        view.backgroundColor = .beBgSub
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var pointExpTitleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "NotoSansKR-SemiBold", size: 14)
        view.text = "보상 포인트 안내"
        view.numberOfLines = 0
        view.textColor = .beTextSub
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var pointExpView: UIView = {
        let view = UIView()
        view.backgroundColor = .beBgSub
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var pointImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "pointImage")
        
        return view
    }()
    
    lazy var pointExpLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "NotoSansKR-Medium", size: 12)
        view.text = "보상 포인트 안내"
        view.numberOfLines = 0
        view.textColor = .beTextInfo
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var pointExpSmallLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "NotoSansKR-SemiBold", size: 14)
        view.text = "성공한 챌린저와 함께 포인트를 나누어 지급"
        view.numberOfLines = 0
        view.textColor = .beCta
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var divider3: UIView = {
        let view = UIView()
        view.backgroundColor = .beBgSub
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var recommendTitleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        view.text = "이런 챌린지는 어떠세요? 👀"
        view.numberOfLines = 0
        view.textColor = .beTextSub
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
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
        
        view.addTarget(self, action: #selector(bookMarkTapped), for: .touchDown)
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
    
    lazy var joinButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .beScPurple600
        button.setTitle("참여하기", for: .normal)
        button.setTitleColor(.beTextWhite, for: .normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        button.layer.cornerRadius = 8
        button.isEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(joinButtonTapped), for: .touchDown)
        
        return button
    }()
    
    var challengeId : Int? = 22
    
    var challengeDetailData : ChallengeDetailData? = nil
    var challengeRecommendData : [ChallengeRecommendsData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupLayout()
        showPromoToast()
        
        setChallengeData()
        challengeRecommend()
    }
    
    //MARK: - UI Setup
    
    private func setupUI() {
        
        view.backgroundColor = .beBgDef
        
        [verticalScrollView, bottomView, toastLabel].forEach { view in
            self.view.addSubview(view)
        }
        
        verticalScrollView.addSubview(verticalContentView)
        
        [representImageView, titleLabel, peopleNumLabel, writerLabel, writeDateLabel, lineView, categoryView, startDateTitleLabel, leftDayLabel, startDateLabel, joinPointTitleLabel, joinPointLabel, challengePeriodView, divider1, detailTitleLabel, detailView, cautionTitleLabel, cautionDetailLabel, cautionView, cautionImageView, divider2, pointExpTitleLabel, pointExpView, divider3, recommendTitleLabel, recommendCollectionView].forEach { view in
            verticalContentView.addSubview(view)
        }
        
        joinAlert.customSubview = joinSubView
        [popUpSubView, popLabel, popCancelButton, popJoinButton].forEach { view in
            joinSubView.addSubview(view)
        }
        
        reportAlert.customSubview = reportSubView
        [reportLabel, reportCancelButton, reportButton].forEach { view in
            reportSubView.addSubview(view)
        }
        
        [popPointMinTitleLabel, popPeriodTitleLabel, popPointLabel, popPeriodLabel, popLineView].forEach { view in
            popUpSubView.addSubview(view)
        }
        
        [categoryIcon, categoryLabel].forEach { view in
            categoryView.addSubview(view)
        }
        
        [challengPeriodImageView, challengePeriodTitleLabel, challengePeriodLabel].forEach { view in
            challengePeriodView.addSubview(view)
        }
        
        detailView.addSubview(detailLabel)
        
        cautionView.addSubview(cautionCollectionView)
        
        [pointImageView, pointExpLabel, pointExpSmallLabel].forEach { view in
            pointExpView.addSubview(view)
        }
        
        [bookMarkButton, joinButton, bookMarkLabel].forEach { view in
            bottomView.addSubview(view)
        }
    }
    
    private func setupLayout() {
        
        let width = UIScreen.main.bounds.width
        
        verticalScrollView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        verticalContentView.snp.makeConstraints { make in
            make.edges.equalTo(verticalScrollView.contentLayoutGuide)
            make.width.equalTo(verticalScrollView.frameLayoutGuide)
            make.height.equalTo(1867)
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
        
        startDateTitleLabel.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(categoryView.snp.bottom).offset(32)
        }
        
        leftDayLabel.snp.makeConstraints{ make in
            make.centerY.equalTo(startDateTitleLabel)
            make.leading.equalTo(startDateTitleLabel.snp.trailing).offset(52)
        }
        
        startDateLabel.snp.makeConstraints{ make in
            make.centerY.equalTo(startDateTitleLabel)
            make.leading.equalTo(leftDayLabel.snp.trailing).offset(12)
        }
        
        joinPointTitleLabel.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(startDateTitleLabel.snp.bottom).offset(12)
        }
        
        joinPointLabel.snp.makeConstraints{ make in
            make.centerY.equalTo(joinPointTitleLabel)
            make.leading.equalTo(leftDayLabel)
        }
        
        challengePeriodView.snp.makeConstraints{ make in
            make.top.equalTo(joinPointTitleLabel.snp.bottom).offset(20)
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
        
        detailTitleLabel.snp.makeConstraints{ make in
            make.top.equalTo(divider1.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
        }
        
        detailView.snp.makeConstraints{ make in
            make.top.equalTo(detailTitleLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(detailLabel.snp.height).offset(28)
        }
        
        detailLabel.snp.makeConstraints{ make in
            make.center.equalTo(detailView)
            make.leading.equalToSuperview().offset(19).priority(999)
            make.trailing.equalToSuperview().offset(-19).priority(999)
            make.top.greaterThanOrEqualToSuperview().offset(14)
            make.bottom.lessThanOrEqualToSuperview().offset(-14)
        }
        
        cautionTitleLabel.snp.makeConstraints{ make in
            make.top.equalTo(detailView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
        }
        
        cautionDetailLabel.snp.makeConstraints{ make in
            make.top.equalTo(cautionTitleLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(16)
        }
        
        cautionCollectionView.snp.makeConstraints { make in
            make.center.equalTo(cautionView)
            make.leading.equalToSuperview().offset(19).priority(999)
            make.trailing.equalToSuperview().offset(-19).priority(999)
            make.top.greaterThanOrEqualToSuperview().offset(14)
            make.bottom.lessThanOrEqualToSuperview().offset(-14)
            make.height.equalTo(calculateNewCollectionViewHeight())
        }

        // cautionView
        cautionView.snp.makeConstraints { make in
            make.top.equalTo(cautionDetailLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(cautionCollectionView.snp.bottom).offset(14)
        }
        
        cautionImageView.snp.makeConstraints{ make in
            make.top.equalTo(cautionView.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(200)
        }
        
        divider2.snp.makeConstraints{ make in
            make.top.equalTo(cautionImageView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(8)
        }
        
        pointExpTitleLabel.snp.makeConstraints{ make in
            make.top.equalTo(divider2.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
        }
        
        pointExpView.snp.makeConstraints{ make in
            make.top.equalTo(pointExpTitleLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(110)
        }
        
        pointImageView.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(14)
        }
        
        pointExpLabel.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(pointImageView.snp.bottom).offset(8)
        }
        
        pointExpSmallLabel.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(pointExpView.snp.bottom).offset(-14)
        }
        
        divider3.snp.makeConstraints{ make in
            make.top.equalTo(pointExpView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(8)
        }
        
        recommendTitleLabel.snp.makeConstraints{ make in
            make.top.equalTo(divider3.snp.bottom).offset(28)
            make.leading.equalToSuperview().offset(24)
        }
        
        recommendCollectionView.snp.makeConstraints{ make in
            make.top.equalTo(recommendTitleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.bottom.equalTo(verticalContentView.snp.bottom)
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
        
        joinButton.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(14)
            make.trailing.equalToSuperview().offset(-28)
            make.width.equalTo(140)
            make.height.equalTo(52)
        }
        
        toastLabel.snp.makeConstraints{ make in
            make.bottom.equalTo(bottomView.snp.top).offset(12)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(44)
        }
        
        // 신고하기 팝업
        
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
        
        // 참여하기 팝업
        
        joinSubView.snp.makeConstraints{ make in
            make.width.equalTo(318)
            make.height.equalTo(240)
        }
        
        popUpSubView.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalToSuperview()
            make.height.equalTo(130)
        }
        
        popLabel.snp.makeConstraints{ make in
            make.top.equalTo(popUpSubView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        popCancelButton.snp.makeConstraints{ make in
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview().offset(-6)
            make.height.equalTo(48)
            make.trailing.equalTo(joinSubView.snp.centerX).offset(-3)
        }
        
        popJoinButton.snp.makeConstraints{ make in
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-6)
            make.height.equalTo(48)
            make.leading.equalTo(joinSubView.snp.centerX).offset(3)
        }
        
        popPointMinTitleLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(14)
            make.centerX.equalToSuperview()
        }
        
        popPointLabel.snp.makeConstraints{ make in
            make.top.equalTo(popPointMinTitleLabel.snp.bottom).offset(2)
            make.centerX.equalToSuperview()
        }
        
        popLineView.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.height.equalTo(1)
        }
        
        popPeriodLabel.snp.makeConstraints{ make in
            make.bottom.equalToSuperview().offset(-14)
            make.centerX.equalToSuperview()
        }
        
        popPeriodTitleLabel.snp.makeConstraints{ make in
            make.bottom.equalTo(popPeriodLabel.snp.top).offset(-2)
            make.centerX.equalToSuperview()
        }
    }
    
    //MARK: - Cell Height
    
    private func calculateNewCollectionViewHeight() -> CGFloat {
        let cellHeight: CGFloat = 18
        let numberOfCells = cautionDataList.count
        let newHeight = (CGFloat(numberOfCells) * cellHeight) + (8 * CGFloat(numberOfCells))
        return newHeight
    }
    
    //MARK: - showToast
    
    private func showPromoToast() {
        UIView.animate(withDuration: 2, delay: 1, options: .curveEaseOut, animations: {
            self.toastLabel.alpha = 0.0
        }, completion: { (isCompleted) in
            self.toastLabel.removeFromSuperview()
        })
    }
    
    private func showChallengeJoinToast() {
        let toastLabel = UILabel()
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = .white
        toastLabel.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        toastLabel.textAlignment = .center
        toastLabel.text = "🙌 해당 챌린지 신청이 완료되었습니다!"
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

    //MARK: - Actions
    
    @objc func joinButtonTapped(_ sender: UIButton) {
        alertViewResponder = joinAlert.showInfo("챌린지 참여하기")
    }
    
    @objc func testButtonTapped(_ sender: UIButton){
        alertViewResponder = reportAlert.showInfo("챌린지 신고하기")
    }
    
    @objc func bookMarkTapped(_ sender: UIButton) {
        //서버에게 이거..이거됐어요 하고보내기
    }
    
    @objc func reportButtonTapped() {
        let reportUrl = NSURL(string: "https://moaform.com/q/dcQIJc")
        let reportSafariView: SFSafariViewController = SFSafariViewController(url: reportUrl! as URL)
        self.present(reportSafariView, animated: true, completion: nil)
        alertViewResponder?.close()
    }
    
    @objc func popJoinButtonTapped() {
        print("참여해벌임")
        alertViewResponder?.close()
        showChallengeJoinToast()
    }

    @objc func close(){
        alertViewResponder?.close()
    }
    
}


// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

extension ChallengeDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case recommendCollectionView :
            return challengeRecommendData.count
        case cautionCollectionView :
            return 3
        default:
            return 2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case recommendCollectionView :
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendCollectionViewCell.identifier, for: indexPath) as?
                    RecommendCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.challengeId = challengeRecommendData[indexPath.row].challengeId
            
            let url = URL(string: challengeRecommendData[indexPath.row].imageUrl!)
            cell.recommendImageView.kf.setImage(with: url)
            cell.categoryLabel.text = challengeRecommendData[indexPath.row].category
            cell.titleLabel.text = challengeRecommendData[indexPath.row].title
            
            return cell
        case cautionCollectionView :
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CautionCollectionViewCell.identifier, for: indexPath) as?
                    CautionCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let target = cautionDataList[indexPath.row]
            
            cell.cautionLabel.text = target.label
            
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == recommendCollectionView {
            return CGSize(width: 342, height: 90)
        }
        
        else if collectionView == cautionCollectionView {
            return CGSize(width: 320, height: 18)
        }
        
        return CGSize()
    }
     
}

// MARK: - 참여중 챌린지, 추천 챌린지 api 세팅
extension ChallengeDetailViewController {
    func setChallengeData() {
        ChallengeService.shared.challengeDetail(challengId: challengeId!) { response in
            self.challengeDetailData = response.data
            
            self.popPointLabel.text = "\(response.data!.joinPoint)P"
            let representURL = URL(string: (response.data?.imageUrl!)!)
            self.representImageView.kf.setImage(with: representURL)
            self.titleLabel.text = response.data?.title
            self.peopleNumLabel.text = "\(response.data?.attendeeCount ?? 0)명 참여중"
            self.writerLabel.text = response.data?.hostName
            self.writeDateLabel.text = response.data?.createdDate
//            let serverResponse = response.data?.category
//            self.categoryIcon.text = self.categoryIconMap[serverResponse!]
//            self.categoryLabel.text = self.categoryMap[serverResponse!]
            self.leftDayLabel.text = "D-\(response.data?.dday ?? 0)"
            self.startDateLabel.text = response.data?.startDate
            self.joinPointLabel.text = "\(response.data!.joinPoint)P"
            updatePeriodLabel(weekCountText: response.data!.period, sessionCountText: response.data!.totalGoalDay)
            self.detailLabel.text = response.data?.details
            let cautionURL = URL(string: (response.data?.certImageUrl!)!)
            self.cautionImageView.kf.setImage(with: cautionURL)
            self.bookMarkButton.isSelected = response.data?.like ?? false
            self.bookMarkLabel.text = String(response.data!.likes)
        }
        
        func updatePeriodLabel(weekCountText: String, sessionCountText: Int) {
            let fullText = "시작일로부터 \(weekCountText) 동안 \(sessionCountText)회 진행"
            
            let attributedText = NSMutableAttributedString(string: fullText)
            
            let weekCountRange = (fullText as NSString).range(of: "\(weekCountText) 동안")
            let sessionCountRange = (fullText as NSString).range(of: "\(sessionCountText)회")
            
            [weekCountRange, sessionCountRange].forEach { range in
                attributedText.addAttribute(.foregroundColor, value: UIColor.beCta, range: range)
            }
            
            let challengeFont = UIFont(name: "NotoSansKR-Medium", size: 12)
            [weekCountRange, sessionCountRange].forEach { range in
                attributedText.addAttribute(.font, value: challengeFont!, range: range)
            }
            challengePeriodLabel.attributedText = attributedText
            
            let popFont = UIFont(name: "NotoSansKR-Medium", size: 14)
            [weekCountRange, sessionCountRange].forEach { range in
                attributedText.addAttribute(.font, value: popFont!, range: range)
            }
            popPeriodLabel.attributedText = attributedText
        }
    }
    
    func challengeRecommend() {
        ChallengeService.shared.challengeRecommend() { response in
            self.setRecommendData(response.data!.recommendChallengeDTOList)
        }
    }
    @MainActor
    private func setRecommendData(_ response: [ChallengeRecommendsData]) {
        self.challengeRecommendData = response
        self.recommendCollectionView.reloadData()
    }
}

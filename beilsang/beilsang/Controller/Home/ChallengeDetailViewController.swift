//
//  ChallengeDetailViewController.swift
//  beilsang
//
//  Created by Seyoung on 1/31/24.
//

import UIKit
import SnapKit

class ChallengeDetailViewController: UIViewController {
    
    //MARK: - Properties
    
    let verticalScrollView = UIScrollView()
    let verticalContentView = UIView()
    
    let recommendDataList = RecommendChallenge.data
    let cautionDataList = CautionChallenge.data
    
    let imageConfig = UIImage.SymbolConfiguration(pointSize: 22, weight: .medium)
    
    
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
        view.text = "D-1"
        view.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        view.numberOfLines = 0
        view.textColor = .beWnRed500
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var startDateLabel: UILabel = {
        let view = UILabel()
        view.text = "01. 11 (목)"
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
        view.text = "500P"
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
        view.text = "일주일에 한 번씩 길을 걸으며 플로깅을 해보는 건 어떨까요?\n 우리 가치 플로깅하자는 챌린저 분들이 함께 활동을 인증하며 플로깅 문화를 확장시키는 챌린지 입니다! 여러분의 많은 참여 부탁드립니다! 🤩"
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
        view.image = UIImage(named: "cautionImage")
        
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
        view.layer.shadowOpacity = 0.2
        view.backgroundColor = .beBgSub
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var bookMarkButton: UIButton = {
        let view = UIButton()
        let image = UIImage(systemName: "star", withConfiguration: imageConfig)
        let selectedImage = UIImage(systemName: "star.fill", withConfiguration: imageConfig)
        
        view.setImage(image, for: .normal)
        view.tintColor = .beScPurple600
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addTarget(self, action: #selector(bookMarkTapped), for: .touchDown)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        
        updateChallengeLabelText()
    }
    
    //MARK: - UI Setup
    
    private func setupUI() {
        
        view.backgroundColor = .beBgDef
        view.addSubview(verticalScrollView)
        view.addSubview(bottomView)
        
        verticalScrollView.addSubview(verticalContentView)
        verticalContentView.addSubview(representImageView)
        verticalContentView.addSubview(titleLabel)
        verticalContentView.addSubview(peopleNumLabel)
        verticalContentView.addSubview(writerLabel)
        verticalContentView.addSubview(writeDateLabel)
        verticalContentView.addSubview(lineView)
        verticalContentView.addSubview(categoryView)
        verticalContentView.addSubview(startDateTitleLabel)
        verticalContentView.addSubview(leftDayLabel)
        verticalContentView.addSubview(startDateLabel)
        verticalContentView.addSubview(joinPointTitleLabel)
        verticalContentView.addSubview(joinPointLabel)
        verticalContentView.addSubview(challengePeriodView)
        verticalContentView.addSubview(divider1)
        verticalContentView.addSubview(detailTitleLabel)
        verticalContentView.addSubview(detailView)
        verticalContentView.addSubview(cautionTitleLabel)
        verticalContentView.addSubview(cautionDetailLabel)
        verticalContentView.addSubview(cautionView)
        verticalContentView.addSubview(cautionImageView)
        verticalContentView.addSubview(divider2)
        verticalContentView.addSubview(pointExpTitleLabel)
        verticalContentView.addSubview(pointExpView)
        verticalContentView.addSubview(divider3)
        verticalContentView.addSubview(recommendTitleLabel)

        verticalContentView.addSubview(recommendCollectionView)
        
        categoryView.addSubview(categoryIcon)
        categoryView.addSubview(categoryLabel)
        
        challengePeriodView.addSubview(challengPeriodImageView)
        challengePeriodView.addSubview(challengePeriodTitleLabel)
        challengePeriodView.addSubview(challengePeriodLabel)
        
        detailView.addSubview(detailLabel)
        
        cautionView.addSubview(cautionCollectionView)
        
        pointExpView.addSubview(pointImageView)
        pointExpView.addSubview(pointExpLabel)
        pointExpView.addSubview(pointExpSmallLabel)
        
        bottomView.addSubview(bookMarkButton)
        bottomView.addSubview(joinButton)
        bottomView.addSubview(bookMarkLabel)
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
            make.leading.equalToSuperview().offset(16)
        }
        
        recommendCollectionView.snp.makeConstraints{ make in
            make.top.equalTo(recommendTitleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(verticalContentView.snp.bottom)
        }
        
        bottomView.snp.makeConstraints{ make in
            make.bottom.equalToSuperview()
            make.height.equalTo(96)
            make.leading.trailing.equalToSuperview()
        }
        
        bookMarkButton.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(16)
            make.height.width.equalTo(30)
        }
        
        bookMarkLabel.snp.makeConstraints{ make in
            make.top.equalTo(bookMarkButton.snp.bottom)
            make.centerX.equalTo(bookMarkButton)
        }
        
        joinButton.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-22)
            make.width.equalTo(140)
            make.height.equalTo(52)
        }

    }
    
    private func updateChallengeLabelText() {
        let weekCountText = "일주일"//"\(challengeModel.weekCount) weeks"
        let sessionCountText = "5"//"\(challengeModel.sessionCount) sessions"
        
        let fullText = "시작일로부터 \(weekCountText) 동안 \(sessionCountText)회 진행"
        
        let attributedText = NSMutableAttributedString(string: fullText)
        
        let weekCountRange = (fullText as NSString).range(of: "\(weekCountText) 동안")
        let sessionCountRange = (fullText as NSString).range(of: "\(sessionCountText)회")

        attributedText.addAttribute(.foregroundColor, value: UIColor.beCta, range: weekCountRange)
        attributedText.addAttribute(.foregroundColor, value: UIColor.beCta, range: sessionCountRange)
        
        let font = UIFont(name: "NotoSansKR-Medium", size: 12)
        attributedText.addAttribute(.font, value: font!, range: NSRange(location: 0, length: fullText.count))
        
        challengePeriodLabel.attributedText = attributedText
    }
    
    //MARK: - Cell Height
    
    private func calculateNewCollectionViewHeight() -> CGFloat {
        let cellHeight: CGFloat = 18
        let numberOfCells = cautionDataList.count
        let newHeight = (CGFloat(numberOfCells) * cellHeight) + (8 * CGFloat(numberOfCells))
        return newHeight
    }
    
    //MARK: - Actions
    
    @objc func joinButtonTapped(_ sender: UIButton) {
        print("바보바보")
    }
    
    @objc func bookMarkTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        
        let image = UIImage(systemName: "star", withConfiguration: imageConfig)
        let selectedImage = UIImage(systemName: "star.fill", withConfiguration: imageConfig)
        
        if sender.isSelected {
            bookMarkButton.setImage(image, for: .normal)
        } else {
            bookMarkButton.setImage(selectedImage, for: .normal)
        
        }
    }
}


// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

extension ChallengeDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == recommendCollectionView {
            return recommendDataList.count
        }
        else if collectionView == cautionCollectionView {
            return cautionDataList.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == recommendCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendCollectionViewCell.identifier, for: indexPath) as?
                    RecommendCollectionViewCell else {
                return UICollectionViewCell()
            }
            let target = recommendDataList[indexPath.row]
            
            cell.recommendImageView.image = UIImage(named: target.image)
            cell.categoryLabel.text = target.category
            cell.titleLabel.text = target.title
            
            return cell
        }
        
        else if collectionView == cautionCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CautionCollectionViewCell.identifier, for: indexPath) as?
                    CautionCollectionViewCell else {
                return UICollectionViewCell()
            }
            let target = cautionDataList[indexPath.row]
            
            cell.cautionLabel.text = target.label
            
            return cell
        }
        
        return UICollectionViewCell()
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

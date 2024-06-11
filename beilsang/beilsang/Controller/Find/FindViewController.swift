//
//  FindViewController.swift
//  beilsang
//
//  Created by Seyoung on 6/10/24.
//

import UIKit
import SnapKit
import SCLAlertView
import Kingfisher

class FindViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Properties
    // ScrollView
    let fullScrollView = UIScrollView()
    let fullContentView = UIView()
    
    // Data
    var hofCellList : [ChallengeModel] = []
    
    var feedCellList : [FeedModel] = []
    
    
    // PopUp
    var alertViewResponder: SCLAlertViewResponder?  = nil
    
    // Search Bar
    lazy var searchBar: UIButton = {
        let view = UIButton()
        view.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        view.setTitleColor(.beTextSub, for: .normal)
        view.setTitle("누구나 즐길 수 있는 대중교통 챌린지! 🚌", for: .normal)
        view.backgroundColor = .beBgSub
        view.layer.cornerRadius = 24
        view.addTarget(self, action: #selector(searchBarTapped), for: .touchUpInside)
        
        return view
    }()
    
    lazy var searchIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon-search")
        return view
    }()
    
    // 명예의 전당 챌린지 모음집 💾
    let hofChallengeCategoryList = CategoryKeyword.find
    
    lazy var hofChallengeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "명예의 전당 챌린지 모음집 💾"
        label.font = UIFont(name: "NotoSansKR-SemiBold", size: 18)
        label.textColor = .black
        return label
    }()
    
    lazy var hofChallengeCategoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    lazy var hofChallengeListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 12
        layout.itemSize = CGSize(width: 160, height: 160)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.decelerationRate = .fast
        return view
    }()
    
    lazy var hofChallengeListScrollIndicator: ScrollIndicatorView = {
        let view = ScrollIndicatorView()
        return view
    }()
    
    // 카테고리별 챌린지 피드
    let categoryDataList = CategoryKeyword.data
    
    lazy var categoryFeedTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "카테고리별 챌린지 피드"
        label.font = UIFont(name: "NotoSansKR-SemiBold", size: 18)
        label.textColor = .black
        return label
    }()
    
    lazy var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 72, height: 72)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return view
    }()
    
    lazy var categoryFeedBoxCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 173, height: 140)
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 12
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.isScrollEnabled = true
        return view
    }()
    
    // 피드 세부 정보
    let feedDetailView = FeedDetailView.shared
    
    // 카테고리에 피드가 없는 경우
    let noFeedView = UIView()
    
    lazy var noFeedLabel: UILabel = {
        let view = UILabel()
        
        view.text = "해당 카테고리에 표시할 피드가 없어요👀"
        view.textAlignment = .center
        view.textColor = .beTextInfo
        view.font = UIFont(name: "Noto Sans KR", size: 12)
        
        return view
    }()
    
    lazy var noFeedhomeButton: UIButton = {
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

    // 신고 팝업
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
        view.text = "해당 피드의 신고 사유가 무엇인가요?\n하단 링크를 통해 알려 주세요"
        view.font = UIFont(name: "NotoSansKR-Medium", size: 12)
        view.numberOfLines = 2
        view.textColor = .beTextInfo
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        
        return view
    }()
        
    lazy var reportUnderLabel: UILabel = {
        let view = UILabel()
        view.text = "신고하기를 누를시 외부 링크로 연결됩니다"
        view.font = UIFont(name: "NotoSansKR-Regular", size: 11)
        view.numberOfLines = 2
        view.textColor = .beTextEx
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
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        
    }
    
    // MARK: - Actions
    // Search
    @objc func searchBarTapped() {
        print("검색버튼")
        let searchVC = SearchViewController()
        searchVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(searchVC, animated: true)
    }
    
    @objc func homeButtonTapped(_ sender: UIButton) {
        let homeVC = HomeMainViewController()
        if let navigationController = self.navigationController {
            navigationController.setViewControllers([homeVC], animated: true)
        }
    }
}

// MARK: - Layout Setting
extension FindViewController {
    @MainActor
    func setupAttribute() {
        setFullScrollView()
        addSubView()
        setLayout()
    }
    
    func setFullScrollView() {
        fullScrollView.delegate = self
        fullScrollView.isScrollEnabled = true
        fullScrollView.showsVerticalScrollIndicator = false
    }
    
    func addSubView() {
        view.addSubview(fullScrollView)
        fullScrollView.addSubview(fullContentView)
        
        [searchBar, searchIcon, hofChallengeTitleLabel, hofChallengeCategoryCollectionView, hofChallengeListCollectionView, hofChallengeListScrollIndicator, categoryFeedTitleLabel, categoryCollectionView, categoryFeedBoxCollectionView, feedDetailView].forEach { view in
            fullContentView.addSubview(view)
        }
        
        reportAlert.customSubview = reportSubView
        [reportLabel, reportUnderLabel, reportCancelButton, reportButton].forEach { view in
            reportSubView.addSubview(view)
        }
    }
    
    func setLayout() {
        // 스크롤뷰
        fullScrollView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
        
        fullContentView.snp.makeConstraints{ make in
            make.edges.equalTo(fullScrollView.contentLayoutGuide)
            make.width.equalTo(fullScrollView.frameLayoutGuide)
            make.height.equalTo(1056)
        }
        
        // 검색
        searchBar.snp.makeConstraints{ make in
            make.height.equalTo(48)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(24)
        }
        
        searchIcon.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.centerY.equalTo(searchBar)
            make.leading.equalTo(searchBar).offset(20)
        }
        
        // 명예의 전당
        hofChallengeTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(searchBar)
            make.top.equalTo(searchBar.snp.bottom).offset(29)
        }
        
        hofChallengeCategoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(hofChallengeTitleLabel.snp.bottom).offset(12)
            make.leading.equalTo(searchBar)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(28)
        }
        
        hofChallengeListCollectionView.snp.makeConstraints { make in
            make.top.equalTo(hofChallengeCategoryCollectionView.snp.bottom).offset(16)
            make.leading.trailing.equalTo(hofChallengeCategoryCollectionView)
            make.height.equalTo(160)
        }
        
        hofChallengeListScrollIndicator.snp.makeConstraints { make in
            make.top.equalTo(hofChallengeListCollectionView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(78)
            make.trailing.equalToSuperview().offset(-78)
            make.height.equalTo(4)
        }
        
        // 카테고리별 피드
        categoryFeedTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(hofChallengeListCollectionView.snp.bottom).offset(60)
            make.leading.equalToSuperview().offset(16)
        }
        
        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(categoryFeedTitleLabel.snp.bottom).offset(12)
            make.height.equalTo(72)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        categoryFeedBoxCollectionView.snp.makeConstraints { make in
            make.top.equalTo(categoryCollectionView.snp.bottom).offset(16)
            make.leading.equalTo(categoryFeedTitleLabel)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        feedDetailView.snp.makeConstraints{ make in
            make.height.equalTo(800)
            make.bottom.leading.trailing.equalToSuperview()
        }
        
        // 신고 팝업
        reportSubView.snp.makeConstraints{ make in
            make.width.equalTo(318)
            make.height.equalTo(160)
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
            make.bottom.equalTo(reportCancelButton.snp.top).offset(-68)
            make.centerX.equalToSuperview()
        }
        
        reportUnderLabel.snp.makeConstraints { make in
            make.bottom.equalTo(reportCancelButton.snp.top).offset(-28)
            make.centerX.equalToSuperview()
        }
    }
}

//MARK: - CollectionView Setting
extension FindViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func setCollectionView() {
        [hofChallengeCategoryCollectionView, hofChallengeListCollectionView, categoryCollectionView, categoryFeedBoxCollectionView].forEach { view in
            view.delegate = self
            view.dataSource = self
        }
        
        // 셀 등록
        hofChallengeCategoryCollectionView.register(HofChallengeCategoryCollectionViewCell.self, forCellWithReuseIdentifier: HofChallengeCategoryCollectionViewCell.identifier)
        
        hofChallengeListCollectionView.register(HofChallengeCollectionViewCell.self, forCellWithReuseIdentifier: HofChallengeCollectionViewCell.identifier)
        
        categoryCollectionView.register(MyPageCategoryCollectionViewCell.self, forCellWithReuseIdentifier: MyPageCategoryCollectionViewCell.identifier)
        
        categoryFeedBoxCollectionView.register(MyChallengeFeedCollectionViewCell.self, forCellWithReuseIdentifier: MyChallengeFeedCollectionViewCell.identifier)
        
        [hofChallengeCategoryCollectionView, hofChallengeListCollectionView, categoryCollectionView].forEach{ view in
            view.showsHorizontalScrollIndicator = false
        }
        
        categoryFeedBoxCollectionView.showsVerticalScrollIndicator = false
        categoryFeedBoxCollectionView.isScrollEnabled = false
    }
    
    // Cell 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case hofChallengeCategoryCollectionView:
            return hofChallengeCategoryList.count
        case hofChallengeListCollectionView:
            return hofCellList.count
        case categoryCollectionView:
            return categoryDataList.count
        case categoryFeedBoxCollectionView:
            return 2/*feedCellList.count*/
        default:
            return 0
        }
    }
    
    // cell 사이즈( 옆 라인을 고려하여 설정 ) - 순서 1
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case hofChallengeCategoryCollectionView:
            return sizeForHofChallengeCategoryCell(at: indexPath)
        case hofChallengeListCollectionView:
            return CGSize(width: 160, height: 160)
        case categoryCollectionView:
            return CGSize(width: 72, height: 72)
        case categoryFeedBoxCollectionView:
            return CGSize(width: (self.view.frame.width - 44) / 2, height: 140)
        default:
            return .zero
        }
    }

    private func sizeForHofChallengeCategoryCell(at indexPath: IndexPath) -> CGSize {
        let target = hofChallengeCategoryList[indexPath.row]
        let text = "\(target.image) \(target.title)"
        let size = (text as NSString).size(withAttributes: [.font: UIFont.systemFont(ofSize: 17)])
        return CGSize(width: size.width + 20, height: 28)
    }

    // cell 설정 - 순서 2
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case hofChallengeCategoryCollectionView:
            return configureHofChallengeCategoryCell(at: indexPath)
        case hofChallengeListCollectionView:
            return configureHofChallengeCell(at: indexPath)
        case categoryCollectionView:
            return configureCategoryCell(at: indexPath)
        case categoryFeedBoxCollectionView:
            return configureChallengeFeedBoxCell(at: indexPath)
        default:
            return UICollectionViewCell()
        }
    }

    private func configureHofChallengeCategoryCell(at indexPath: IndexPath) -> HofChallengeCategoryCollectionViewCell {
        guard let cell = hofChallengeCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: HofChallengeCategoryCollectionViewCell.identifier, for: indexPath) as? HofChallengeCategoryCollectionViewCell else {
            return HofChallengeCategoryCollectionViewCell()
        }
        let target = hofChallengeCategoryList[indexPath.row]
        cell.categoryLabel.text = "\(target.image) \(target.title)"
        cell.categoryLabel.sizeToFit()
        return cell
    }

    private func configureHofChallengeCell(at indexPath: IndexPath) -> HofChallengeCollectionViewCell {
        guard let cell = HofChallengeCollectionView.dequeueReusableCell(withReuseIdentifier: HofChallengeCollectionViewCell.identifier, for: indexPath) as? HofChallengeCollectionViewCell else {
            return HofChallengeCollectionViewCell()
        }
        if HofCellList.count > indexPath.row {
            let target = HofCellList[indexPath.row]
            cell.challengeNameLabel.text = target.title
            if let url = URL(string: target.imageUrl) {
                cell.challengeImage.kf.setImage(with: url)
            }
            cell.numOfPeopleLabel.text = "참여인원 \(target.attendeeCount)명"
            cell.challengeId = target.challengeId
        }
        return cell
    }

    private func configureCategoryCell(at indexPath: IndexPath) -> MyPageCategoryCollectionViewCell {
        guard let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: MyPageCategoryCollectionViewCell.identifier, for: indexPath) as? MyPageCategoryCollectionViewCell else {
            return MyPageCategoryCollectionViewCell()
        }
        let target = categoryDataList[indexPath.row]
        if let img = UIImage(named: "\(target.image).svg") {
            cell.keywordImage.image = img
        }
        cell.keywordLabel.text = target.title
        return cell
    }

    private func configureChallengeFeedBoxCell(at indexPath: IndexPath) -> MyChallengeFeedCollectionViewCell {
        guard let cell = challengeFeedBoxCollectionView.dequeueReusableCell(withReuseIdentifier: MyChallengeFeedCollectionViewCell.identifier, for: indexPath) as? MyChallengeFeedCollectionViewCell else {
            return MyChallengeFeedCollectionViewCell()
        }
        let target = feedCellList[indexPath.row]
        cell.feedId = target.feedId
        if let url = URL(string: target.feedUrl) {
            cell.challengeFeed.kf.setImage(with: url)
        }
        return cell
    }

    
}
    
    
    
    // MARK: - Network
extension FindViewController {
    func networkRequest() {
        
    }
    
    func setHofChallengeListCollectionView()  {
        
    }
    
}

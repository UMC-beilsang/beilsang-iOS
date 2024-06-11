//
//  FindViewController.swift
//  beilsang
//
//  Created by 강희진 on 2/3/24.
//

import UIKit
import SafariServices
import SCLAlertView
import Kingfisher

class FindOldViewController: UIViewController, UIScrollViewDelegate {

    // MARK: - Properties
    
    // 전체 화면 scrollview
    let fullScrollView = UIScrollView()
    let fullContentView = UIView()
    var imageList = ["image 8", "image 9", "image 8", "image 9","image 8", "image 9",]
    var alertViewResponder: SCLAlertViewResponder? = nil
    
    // 명예의 전당
    var HofCellList : [ChallengeModel] = []
    var HofFeedList = [[ChallengeModel]](repeating: Array(), count: 9)
    var HofCategory : String = "다회용컵"
    
    // 피드
    var feedCellList : [FeedModel] = []
    var feedChallengeList = [[FeedModel]](repeating: Array(), count: 10)
    var feedCategory : String = "전체"
    
    // 더보기 버튼용
    var pageNumber = [Int](repeating: 0, count: 10)
    
    //검색창
    lazy var searchBar: UIButton = {
        let view = UIButton()
        view.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        view.setTitleColor(.beTextSub, for: .normal)
        view.setTitle("누구나 즐길 수 있는 대중교통 챌린지! 🚌", for: .normal)
//        view.textColor = .beTextSub
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
    
    // 명예의 전당 챌린지
    lazy var HofChallengeListLabel: UILabel = {
        let label = UILabel()
        label.text = "명예의 전당 챌린지 모음집 💾"
        label.font = UIFont(name: "NotoSansKR-SemiBold", size: 18)
        label.textColor = .black
        return label
    }()
    
    let HofChallengeCategoryList = CategoryKeyword.find
    
    lazy var HofChallengeCategoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    lazy var HofChallengeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 12
        layout.itemSize = CGSize(width: 160, height: 160)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.decelerationRate = .fast
        return view
    }()
    
    lazy var scrollIndicator: ScrollIndicatorView = {
        let view = ScrollIndicatorView()
        return view
    }()
    
    // 카테고리별 챌린지 피드
    lazy var challengeFeedLabel: UILabel = {
        let label = UILabel()
        label.text = "카테고리별 챌린지 피드"
        label.font = UIFont(name: "NotoSansKR-SemiBold", size: 18)
        label.textColor = .black
        return label
    }()
    
    // categoriesView - 셀
    let categoryDataList = CategoryKeyword.data
    
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
    
    lazy var challengeFeedBoxCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 173, height: 140)
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 12
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.isScrollEnabled = true
        return view
    }()
    
    lazy var feedDetailCollectionView: UICollectionView = {
        let layout = self.makeFlowLayout()
        layout.configuration.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.isHidden = true
        return view
    }()
    
    lazy var feedDetailBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.isHidden = true
        return view
    }()
    
    lazy var moreFeedButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.beBgDiv.cgColor
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(showMoreFeed), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    lazy var moreFeedButtonLabel: UILabel = {
        let label = UILabel()
        label.text = "전체 챌린지 더보기"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        label.textColor = .black
        return label
    }()
    
    lazy var moreFeedButtonImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Vector 10")
        return view
    }()
    
    // 맨 위 버튼
    lazy var scrollToTop: UIButton = {
        let status = false
        let button = UIButton()
        button.backgroundColor = .beScPurple300.withAlphaComponent(0.7)
        button.setImage(UIImage(named: "icon-navigation")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.transform = CGAffineTransform(rotationAngle: .pi * 0.5)
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(scrollToTopButton), for: .touchUpInside)
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
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        request()
        setupAttribute()
        setCollectionView()
        setNavigationBar()
        viewConstraint()
    }
}
extension FindOldViewController {
    @MainActor
    func request(){
        setList(collectionView: self.HofChallengeCategoryCollectionView)
        setList(collectionView: self.challengeFeedBoxCollectionView)//requestMoreFeedList()
    }
    
    // 명예의 전당 챌린지 리스트
    func requestHofChallengeList() -> [ChallengeModel]{
        var list : [ChallengeModel] = []
        MyPageService.shared.getChallengeList(baseEndPoint: .challenges, addPath: "/famous/\(HofCategory)") { response in
            list = response.data.challenges ?? []
            print(list)
            self.setHofList(response.data.challenges ?? [])
        }
        return list
    }
    
    private func setHofList(_ response: [ChallengeModel]){
        if response.isEmpty {
            self.HofFeedList[changeCategoryToInt(category: HofCategory) - 1].removeAll()
            HofChallengeCollectionView.reloadData()
        } else {
            self.HofFeedList[changeCategoryToInt(category: HofCategory) - 1] = response
            HofChallengeCollectionView.reloadData()
        }
        self.HofCellList = response
    }
    
    // 카테고리 별 챌린지 피드 리스트
    func requestCategoryChallengeFeedList() -> [FeedModel] {
        let categoryIndex = changeCategoryToInt(category: feedCategory)
        var list : [FeedModel] = []
        MyPageService.shared.getFeedList(baseEndPoint: .feeds, addPath: "/category/\(feedCategory)?page=\(pageNumber[categoryIndex])") { response in
            list = response.data.feeds ?? []
            if !list.isEmpty {
                self.pageNumber[categoryIndex] += 1
            }
            self.setFeedList(list)
        }
        return list
    }
    // 카테고리 별 챌린지 피드 리스트
    func requestMoreFeedList() {
        let categoryIndex = changeCategoryToInt(category: feedCategory)
        var list : [FeedModel] = []
        MyPageService.shared.getFeedList(baseEndPoint: .feeds, addPath: "/category/\(feedCategory)?page=\(pageNumber[categoryIndex])") { response in
            list = response.data.feeds ?? []
            if !list.isEmpty {
                self.pageNumber[categoryIndex] += 1
            }
            self.setFeedList(list)
        }
    }
    private func setFeedList(_ response: [FeedModel]){
        self.feedChallengeList[changeCategoryToInt(category: feedCategory)] += response
        self.feedCellList += response
        challengeFeedBoxCollectionView.reloadData()
    }
    
    func setupAttribute() {
        setFullScrollView()
        setLayout()
        setScrollViewLayout()
    }
    
    func setFullScrollView() {
        fullScrollView.delegate = self
        //스크롤 안움직이게 설정
        fullScrollView.isScrollEnabled = true
        //스크롤 안보이게 설정
        fullScrollView.showsVerticalScrollIndicator = false
    }
    
    func setLayout() {
        view.addSubview(fullScrollView)
        fullScrollView.addSubview(fullContentView)
        addView()
    }
    func setScrollViewLayout(){
        fullScrollView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        fullContentView.snp.makeConstraints { make in
            make.edges.equalTo(fullScrollView.contentLayoutGuide)
            make.width.equalTo(fullScrollView.frameLayoutGuide)
            make.height.equalTo(1056)
        }
    }
    
    // addSubview() 메서드 모음
    func addView() {
        // foreach문을 사용해서 클로저 형태로 작성
        self.view.addSubview(scrollToTop)
        self.view.addSubview(moreFeedButton)
        [searchBar, searchIcon, HofChallengeListLabel, HofChallengeCategoryCollectionView, HofChallengeCollectionView, scrollIndicator, challengeFeedLabel, categoryCollectionView, challengeFeedBoxCollectionView, feedDetailBackground, feedDetailCollectionView, reportButton].forEach{ view in fullContentView.addSubview(view)}
        
        [moreFeedButtonLabel, moreFeedButtonImage].forEach { view in
            moreFeedButton.addSubview(view)
        }
        
        reportAlert.customSubview = reportSubView
        reportSubView.addSubview(reportLabel)
        reportSubView.addSubview(reportUnderLabel)
        reportSubView.addSubview(reportCancelButton)
        reportSubView.addSubview(reportButton)
    }
    
    //snp 설정
    func viewConstraint(){
        searchBar.snp.makeConstraints { make in
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
        HofChallengeListLabel.snp.makeConstraints { make in
            make.leading.equalTo(searchBar)
            make.top.equalTo(searchBar.snp.bottom).offset(29)
        }
        HofChallengeCategoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(HofChallengeListLabel.snp.bottom).offset(12)
            make.leading.equalTo(searchBar)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(28)
        }
        HofChallengeCollectionView.snp.makeConstraints { make in
            make.top.equalTo(HofChallengeCategoryCollectionView.snp.bottom).offset(16)
            make.leading.trailing.equalTo(HofChallengeCategoryCollectionView)
            make.height.equalTo(160)
        }
        scrollIndicator.snp.makeConstraints { make in
            make.top.equalTo(HofChallengeCollectionView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(78)
            make.trailing.equalToSuperview().offset(-78)
            make.height.equalTo(4)
        }
        challengeFeedLabel.snp.makeConstraints { make in
            make.top.equalTo(HofChallengeCollectionView.snp.bottom).offset(60)
            make.leading.equalToSuperview().offset(16)
        }
        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(challengeFeedLabel.snp.bottom).offset(12)
            make.height.equalTo(72)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        challengeFeedBoxCollectionView.snp.makeConstraints { make in
            make.top.equalTo(categoryCollectionView.snp.bottom).offset(16)
            make.leading.equalTo(challengeFeedLabel)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        feedDetailCollectionView.snp.makeConstraints { make in
            make.height.equalTo(800)
            make.bottom.leading.trailing.equalToSuperview()
        }
        feedDetailBackground.snp.makeConstraints { make in
            make.size.edges.equalToSuperview()
        }
        moreFeedButton.snp.makeConstraints { make in
            make.width.equalTo(240)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-128)
        }
        moreFeedButtonLabel.snp.makeConstraints { make in
            make.centerX.equalTo(moreFeedButton).offset(-12)
            make.centerY.equalTo(moreFeedButton)
        }
        moreFeedButtonImage.snp.makeConstraints { make in
            make.leading.equalTo(moreFeedButtonLabel.snp.trailing).offset(12)
            make.centerY.equalTo(moreFeedButtonLabel)
            make.width.equalTo(12)
            make.height.equalTo(6)
        }
        scrollToTop.snp.makeConstraints { make in
            make.width.height.equalTo(66)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-96)
        }
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
// MARK: - 네비게이션 바 커스텀
extension FindOldViewController{
    private func setNavigationBar() {
        self.navigationItem.titleView = attributeTitleView()
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor.white // 원하는 배경색 설정
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        setBackButton()
    }
    private func attributeTitleView() -> UIView {
        // 네비게이션 바에 타이틀을 왼쪽으로 옮기기 위해 커스텀 뷰 생성
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        // 커스텀 뷰 내에 타이틀 레이블 추가
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        titleLabel.text = "발견"
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont(name: "NotoSansKR-SemiBold", size: 22)
        view.addSubview(titleLabel)
          
        return view
    }
    // 백버튼 커스텀
    func setBackButton() {
        let notiButton = UIBarButtonItem(image: UIImage(named: "iconamoon_notification-bold")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(tabBarButtonTapped))
        notiButton.tintColor = .black
        self.navigationItem.rightBarButtonItem = notiButton
    }
    // 사이드 버튼 액션
    @objc func tabBarButtonTapped() {
        print("알림버튼")
        let notificationVC = NotificationViewController()
        notificationVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(notificationVC, animated: true)
    }
}

// MARK: - collectionView setting(카테고리)
extension FindOldViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    // collectionView, delegate, datasorce 설정
    func setCollectionView() {
        [HofChallengeCategoryCollectionView, HofChallengeCollectionView, categoryCollectionView, challengeFeedBoxCollectionView, feedDetailCollectionView].forEach { view in
            view.delegate = self
            view.dataSource = self
        }
        //Cell 등록
        HofChallengeCategoryCollectionView.register(HofChallengeCategoryCollectionViewCell.self, forCellWithReuseIdentifier: HofChallengeCategoryCollectionViewCell.identifier)            
        HofChallengeCollectionView.register(HofChallengeCollectionViewCell.self, forCellWithReuseIdentifier: HofChallengeCollectionViewCell.identifier)
        categoryCollectionView.register(MyPageCategoryCollectionViewCell.self, forCellWithReuseIdentifier: MyPageCategoryCollectionViewCell.identifier)
        challengeFeedBoxCollectionView.register(MyChallengeFeedCollectionViewCell.self, forCellWithReuseIdentifier: MyChallengeFeedCollectionViewCell.identifier)
        feedDetailCollectionView.register(FindFeedDetailCollectionViewCell.self, forCellWithReuseIdentifier: FindFeedDetailCollectionViewCell.identifier)
        
        [HofChallengeCategoryCollectionView, HofChallengeCollectionView, categoryCollectionView].forEach { view in
            view.showsHorizontalScrollIndicator = false
        }
        [challengeFeedBoxCollectionView].forEach { view in
            view.showsVerticalScrollIndicator = false
        }
        challengeFeedBoxCollectionView.isScrollEnabled = false
        setFirstIndexIsSelected()
    }
    // section 개수 설정
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    // cell 개수 설정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case HofChallengeCategoryCollectionView:
            return HofChallengeCategoryList.count
        case HofChallengeCollectionView:
            return 5
        case categoryCollectionView:
            return categoryDataList.count
        case challengeFeedBoxCollectionView:
            return feedCellList.count
        case feedDetailCollectionView:
            return 1
        default:
            return 0
        }
    }
    // cell 사이즈( 옆 라인을 고려하여 설정 ) - 순서 1
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case HofChallengeCategoryCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HofChallengeCategoryCollectionViewCell.identifier, for: indexPath) as?
                    HofChallengeCategoryCollectionViewCell else {
                return .zero
            }
            let target = HofChallengeCategoryList[indexPath.row]
            cell.categoryLabel.text = "\(target.image) \(target.title)"
            cell.categoryLabel.sizeToFit()
            return CGSize(width: cell.categoryLabel.frame.width + 20, height: 28)
        case HofChallengeCollectionView:
            return  CGSize(width: 160, height: 160)
        case categoryCollectionView:
            return  CGSize(width: 72, height: 72)
        case challengeFeedBoxCollectionView:
            return  CGSize(width: (self.view.frame.width-44)/2, height: 140)
        case feedDetailCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FindFeedDetailCollectionViewCell.identifier, for: indexPath) as?
                    FindFeedDetailCollectionViewCell else {
                return .zero
            }
            return  cell.frame.size
        default:
            return CGSizeZero
        }
    }
    
    // cell 설정 - 순서 2
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView{
        case HofChallengeCategoryCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HofChallengeCategoryCollectionViewCell.identifier, for: indexPath) as?
                    HofChallengeCategoryCollectionViewCell else {
                return UICollectionViewCell()
            }
            let target = HofChallengeCategoryList[indexPath.row]
            cell.categoryLabel.text = "\(target.image) \(target.title)"
            cell.categoryLabel.sizeToFit()
            return cell
        case HofChallengeCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HofChallengeCollectionViewCell.identifier, for: indexPath) as?
                    HofChallengeCollectionViewCell else {
                return UICollectionViewCell()
            }
            if HofCellList.count > indexPath.row{
                let target = HofCellList[indexPath.row]
                cell.challengeNameLabel.text = target.title
                let url = URL(string: target.imageUrl)
                cell.challengeImage.kf.setImage(with: url)
                cell.numOfPeopleLabel.text = "참여인원 \(target.attendeeCount)명"
                cell.challengeId = target.challengeId
            }
            return cell
        case categoryCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPageCategoryCollectionViewCell.identifier, for: indexPath) as?
                    MyPageCategoryCollectionViewCell else {
                return UICollectionViewCell()
            }
            let target = categoryDataList[indexPath.row]
            let img = UIImage(named: "\(target.image).svg")
            cell.keywordImage.image = img
            cell.keywordLabel.text = target.title
            
            return cell
        case challengeFeedBoxCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyChallengeFeedCollectionViewCell.identifier, for: indexPath) as?
                    MyChallengeFeedCollectionViewCell else {
                return UICollectionViewCell()
            }
            let target = feedCellList[indexPath.row]
            cell.feedId = target.feedId
            let url = URL(string: target.feedUrl)
            cell.challengeFeed.kf.setImage(with: url)
            return cell
        case feedDetailCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FindFeedDetailCollectionViewCell.identifier, for: indexPath) as?
                    FindFeedDetailCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.delegate = self
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    // cell 선택시 액션
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView{
        case HofChallengeCategoryCollectionView:
            let cell = collectionView.cellForItem(at: indexPath) as! HofChallengeCategoryCollectionViewCell
            let str = cell.categoryLabel.text!
            let startIndex = str.index(str.startIndex, offsetBy: 2) // 문자열의 세 번째 문자의 인덱스
            let substring = str[startIndex...]
            HofCategory = String(substring)
            setList(collectionView: collectionView) // request 요청
        case categoryCollectionView:
            let cell = collectionView.cellForItem(at: indexPath) as! MyPageCategoryCollectionViewCell
            feedCategory = cell.keywordLabel.text!
            moreFeedButtonLabel.text = "\(feedCategory) 챌린지 더보기"
            didTapButton()
            feedCellList.removeAll() // 다른 카테고리에서 받은 데이터 없애기
            setList(collectionView: collectionView) // request 요청
            fullScrollView.resetContentSize() // 늘어난 스크롤 뷰 줄이기
        case HofChallengeCollectionView:
            let cell = collectionView.cellForItem(at: indexPath) as! HofChallengeCollectionViewCell
            
            let challengeDetailVC = ChallengeDetailViewController()
            challengeDetailVC.detailChallengeId = cell.challengeId
            challengeDetailVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(challengeDetailVC, animated: true)
        case challengeFeedBoxCollectionView:
            // 챌린지 피드 선택
            // 세부 정보 출력
            let cell = collectionView.cellForItem(at: indexPath) as! MyChallengeFeedCollectionViewCell
            feedDetailCollectionView.isHidden = false
            feedDetailBackground.isHidden = false
            fullScrollView.isScrollEnabled = false
            moreFeedButton.isHidden = true
            // 피드 이미지 전달
            let feedCell = feedDetailCollectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as! FindFeedDetailCollectionViewCell
            feedCell.feedImage.image = cell.challengeFeed.image
            feedCell.feedId = cell.feedId!
            self.showFeedDetail(feedId: cell.feedId!, feedImage: cell.challengeFeed.image!)

            // 추천 챌린지 data
            requestRecommendChallenge()
            // 피드 위치 UIScreen 위치에 맞게 수정
            feedDetailCollectionView.snp.remakeConstraints { make in
                make.height.equalTo(700)
                make.top.equalToSuperview().offset(fullScrollView.contentOffset.y+130) //약간 야매...
                make.leading.trailing.equalToSuperview()
            }
        default:
            return
        }
    }
    // collectionCell 첫 화면 설정
    func setFirstIndexIsSelected() {
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        HofChallengeCategoryCollectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .bottom) // 0번째 Index로
        categoryCollectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .bottom) // 0번째 Index로
    }
    // 스크롤 설정 - horizontal 스크롤
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if HofChallengeCollectionView == scrollView { // 스크롤을 움직이면 위치에 따라 leftOffsetRatio를 설정해준다.(처음 view는 false)
            let scroll = scrollView.contentOffset.x + scrollView.contentInset.left
            let width = scrollView.contentSize.width + scrollView.contentInset.left + scrollView.contentInset.right
            let scrollRatio = scroll / width
            self.scrollIndicator.leftOffsetRatio = scrollRatio
        }
    }
    
    // 스크롤 맨 밑 도착시 감지
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == fullScrollView{
            if (scrollView.contentOffset.y + 1) >= (scrollView.contentSize.height - scrollView.frame.size.height) {
                moreFeedButton.isHidden = false
            }
        }
    }
    
    func scrollToTop(_ scrollView: UIScrollView) {
        scrollView.setContentOffset(CGPoint(x: 0, y: -97), animated: true)
    }
    // 섹션 별 크기 설정을 위한 함수
    // challengeBoxCollectionView layout 커스텀
    private func makeFlowLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { section, ev -> NSCollectionLayoutSection? in
            
            return makeChallengeFeedDetailSectionLayout()
        }
        // 전체가 아닐 때의 medal 섹션
        func makeChallengeFeedDetailSectionLayout() -> NSCollectionLayoutSection? {
            // item
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            /// 아이템들이 들어갈 Group 설정
            /// groupSize 설정
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            // section
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(
                top: 0,
                leading: 16,
                bottom: 0,
                trailing: 16)
            
            return section
        }
    }
}
// MARK: - function
extension FindOldViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // horizontal 스크롤 - collection view 스크롤 시 하단의 커스텀 스크롤도 이동하기 위함
        let allWidth = self.HofChallengeCollectionView.contentSize.width + self.HofChallengeCollectionView.contentInset.left + self.HofChallengeCollectionView.contentInset.right
        let showingWidth = self.HofChallengeCollectionView.bounds.width
        // 움직일 scroll 길이 설정
        self.scrollIndicator.widthRatio = showingWidth / allWidth
        self.scrollIndicator.layoutIfNeeded()
    }
    
    // 피드 더보기 버튼
    // 문제: 피드가 없어도 로드가 됨 이럴거면 차라리 VC 하나 만드는게 나음
    @objc func showMoreFeed() {
        requestMoreFeedList()
        challengeFeedBoxCollectionView.reloadData()
        moreFeedButton.isHidden = true
        fullScrollView.updateContentSize()
        fullContentView.snp.remakeConstraints { make in
            make.edges.equalTo(fullScrollView.contentLayoutGuide)
            make.width.equalTo(fullScrollView.frameLayoutGuide)
            make.height.equalTo(fullScrollView.contentSize.height + 10)
        }
    }
    @objc func scrollToTopButton(){
        scrollToTop(fullScrollView)
    }
    @objc func reportButtonTapped() {
        let reportUrl = NSURL(string: "https://moaform.com/q/DJ7VuN")
        let reportSafariView: SFSafariViewController = SFSafariViewController(url: reportUrl! as URL)
        self.present(reportSafariView, animated: true, completion: nil)
        alertViewResponder?.close()
    }
    @objc func close(){
        alertViewResponder?.close()
    }
    
    private func requestRecommendChallenge(){
        FindService.shared.getRecommendChallenge(baseEndPoint: .challenges, addPath: "/recommends") { response in
            self.setRecommendChallenge(response.data.recommendChallengeDTOList ?? [])
        }
    }
    
    @MainActor
    private func setRecommendChallenge(_ response: [RecommendChallengeModel]) {
        let feedCell = feedDetailCollectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as! FindFeedDetailCollectionViewCell
        
        feedCell.categoryLabel.text = response[0].category
        feedCell.titleLabel.text = response[0].title
        let url = URL(string: response[0].imageUrl)
        feedCell.recommendImageView.kf.setImage(with: url)
        feedCell.recommendChallengeId = response[0].challengeId
        feedDetailCollectionView.reloadData()
    }
}

// 텍스트필드 placeholder 왼쪽에 padding 추가
extension UITextField{
    func leftSearchPadding() {
        // 1
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 52, height: self.frame.height))        
        // 2
        self.leftView = leftView
        // 3
        self.leftViewMode = ViewMode.always
    }
}
// MARK: - function
extension FindOldViewController: CustomFeedCellDelegate {
    func didTapButton() {
        feedDetailCollectionView.isHidden = true
        feedDetailBackground.isHidden = true
        fullScrollView.isScrollEnabled = true
        moreFeedButton.isHidden = false
    }
    func didTapReportButton() {
        alertViewResponder = reportAlert.showInfo("신고하기")
    }
    func didTapRecommendButton(id: Int) {
        let challengeDetailVC = ChallengeDetailViewController()
        challengeDetailVC.detailChallengeId = id
        challengeDetailVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(challengeDetailVC, animated: true)
    }
    // 피드 상세정보 보기 request
    private func showFeedDetail(feedId: Int, feedImage: UIImage){
        let feedCell = feedDetailCollectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as! FindFeedDetailCollectionViewCell
        
        MyPageService.shared.getMyPageFeedDetail(baseEndPoint: .feeds, addPath: "/\(String(describing: feedId))"){response in
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
                let url = URL(string: imageUrl)
                feedCell.profileImage.kf.setImage(with: url)
            }
            if response.data.like {
                feedCell.heartButton.setImage(UIImage(named: "iconamoon_fullheart-bold"), for: .normal)
            }
        }
    }
    
    //카테고리 선택 시 request 요청
    private func setList(collectionView: UICollectionView){
        if collectionView == HofChallengeCategoryCollectionView {
            let categoryIndex = changeCategoryToInt(category: HofCategory) - 1
            //api에서 data를 받아오지 않았다면
            if HofFeedList[categoryIndex].isEmpty{
                HofFeedList[categoryIndex] = requestHofChallengeList()
            } else {
                self.HofCellList = HofFeedList[categoryIndex]
                HofChallengeCollectionView.reloadData()
            }
        } else if collectionView == feedDetailCollectionView {
            let categoryIndex = changeCategoryToInt(category: feedCategory)
            if feedChallengeList[categoryIndex].isEmpty{
                feedChallengeList[categoryIndex] = requestCategoryChallengeFeedList()
            } else{
                self.feedCellList = feedChallengeList[categoryIndex]
                challengeFeedBoxCollectionView.reloadData()
            }
        }
        else {
            print("No CollectionView, Error!")
        }
    }
    
    func changeCategoryToInt(category: String) -> Int{
        switch category{
        case CategoryKeyword.data[0].title: return 0
        case CategoryKeyword.data[1].title: return 1
        case CategoryKeyword.data[2].title: return 2
        case CategoryKeyword.data[3].title: return 3
        case CategoryKeyword.data[4].title: return 4
        case CategoryKeyword.data[5].title: return 5
        case CategoryKeyword.data[6].title: return 6
        case CategoryKeyword.data[7].title: return 7
        case CategoryKeyword.data[8].title: return 8
        case CategoryKeyword.data[9].title: return 9
        default:
            return 0
        }
    }
    // 사이드 버튼 액션 - 검색
    @objc func searchBarTapped() {
        print("검색버튼")
        let searchVC = SearchViewController()
        searchVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(searchVC, animated: true)
    }
}

// 동적으로 scroll view 크기 설정
extension UIScrollView {
    func updateContentSize() {
        let unionCalculatedTotalRect = recursiveUnionInDepthFor(view: self)
        
        // 계산된 크기로 컨텐츠 사이즈 설정
        self.contentSize = CGSize(width: self.frame.width, height: unionCalculatedTotalRect.height + 400)
    }
    func resetContentSize() {
        let unionCalculatedTotalRect = recursiveUnionInDepthFor(view: self)
        // 계산된 크기로 컨텐츠 사이즈 설정
        self.contentSize = CGSize(width: self.frame.width, height: unionCalculatedTotalRect.height - 400)
    }
    private func recursiveUnionInDepthFor(view: UIView) -> CGRect {
        var totalRect: CGRect = .zero
        
        // 모든 자식 View의 컨트롤의 크기를 재귀적으로 호출하며 최종 영역의 크기를 설정
        for subView in view.subviews {
            totalRect = totalRect.union(recursiveUnionInDepthFor(view: subView))
        }
        
        // 최종 계산 영역의 크기를 반환
        return totalRect.union(view.frame)
    }
}

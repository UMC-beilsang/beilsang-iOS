//
//  FindViewController.swift
//  beilsang
//
//  Created by 강희진 on 2/3/24.
//

import UIKit

class FindViewController: UIViewController, UIScrollViewDelegate {

    // MARK: - Properties
    
    // 전체 화면 scrollview
    let fullScrollView = UIScrollView()
    let fullContentView = UIView()
    var imageList = ["image 8", "image 9", "image 8", "image 9","image 8", "image 9",]
    //검색창
    lazy var searchBar: UITextField = {
        let view = UITextField()
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "NotoSansKR-Medium", size: 14) as Any,
            .foregroundColor : UIColor.beTextSub
        ]
        view.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        view.textColor = .beTextSub
        view.backgroundColor = .beBgSub
        view.layer.cornerRadius = 24
        view.attributedPlaceholder = NSAttributedString(string: "누구나 즐길 수 있는 대중교통 챌린지! 🚌", attributes: attributes)
        view.leftSearchPadding()
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
    let categoryDataList = CategoryKeyword.data[1...]
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
    lazy var buttonLabel: UILabel = {
        let label = UILabel()
        label.text = "다회용컵 챌린지 더보기"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        label.textColor = .black
        return label
    }()
    lazy var buttonImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Vector 10")
        return view
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupAttribute()
        setCollectionView()
        setNavigationBar()
        viewConstraint()
    }
}
extension FindViewController {
    
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
        [searchBar, searchIcon, HofChallengeListLabel, HofChallengeCategoryCollectionView, HofChallengeCollectionView, scrollIndicator, challengeFeedLabel, categoryCollectionView, challengeFeedBoxCollectionView, moreFeedButton, feedDetailBackground, feedDetailCollectionView,].forEach{ view in fullContentView.addSubview(view)}
        
        [buttonLabel, buttonImage].forEach { view in
            moreFeedButton.addSubview(view)
        }
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
//            make.bottom.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        feedDetailCollectionView.snp.makeConstraints { make in
//            make.top.equalTo(challengeFeedBoxCollectionView)
            make.height.equalTo(700)
            make.bottom.leading.trailing.equalToSuperview()
        }
        feedDetailBackground.snp.makeConstraints { make in
            make.size.edges.equalToSuperview()
        }
        moreFeedButton.snp.makeConstraints { make in
            make.width.equalTo(240)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-24)
        }
        buttonLabel.snp.makeConstraints { make in
            make.leading.equalTo(moreFeedButton).offset(42)
            make.centerY.equalTo(moreFeedButton)
        }
        buttonImage.snp.makeConstraints { make in
            make.trailing.equalTo(moreFeedButton).offset(-42)
            make.centerY.equalTo(moreFeedButton)
            make.width.equalTo(12)
            make.height.equalTo(6)
        }
    }
}
// MARK: - 네비게이션 바 커스텀
extension FindViewController{
    private func setNavigationBar() {
        self.navigationItem.titleView = attributeTitleView()
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
        let notiButton = UIBarButtonItem(image: UIImage(named: "iconamoon_notification-bold"), style: .plain, target: self, action: #selector(tabBarButtonTapped))
        notiButton.tintColor = .black
        self.navigationItem.rightBarButtonItem = notiButton
    }
    // 백버튼 액션
    @objc func tabBarButtonTapped() {
            print("알림")
    }
}
// MARK: - collectionView setting(카테고리)
extension FindViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
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
        feedDetailCollectionView.register(FeedDetailCollectionViewCell.self, forCellWithReuseIdentifier: FeedDetailCollectionViewCell.identifier)
        
        [HofChallengeCategoryCollectionView, HofChallengeCollectionView, categoryCollectionView].forEach { view in
            view.showsHorizontalScrollIndicator = false
        }
        [challengeFeedBoxCollectionView, ].forEach { view in
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
            return imageList.count
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
            cell.categoryLabel.text = "\(target.image)\(target.title)"
            cell.categoryLabel.sizeToFit()
            return CGSize(width: cell.categoryLabel.frame.width + 20, height: 28)
        case HofChallengeCollectionView:
            return  CGSize(width: 160, height: 160)
        case categoryCollectionView:
            return  CGSize(width: 72, height: 72)
        case challengeFeedBoxCollectionView:
            return  CGSize(width: 173, height: 140)
        case feedDetailCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedDetailCollectionViewCell.identifier, for: indexPath) as?
                    FeedDetailCollectionViewCell else {
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
            cell.categoryLabel.text = "\(target.image)\(target.title)"
            cell.categoryLabel.sizeToFit()
            return cell
        case HofChallengeCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HofChallengeCollectionViewCell.identifier, for: indexPath) as?
                    HofChallengeCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            return cell
        case categoryCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPageCategoryCollectionViewCell.identifier, for: indexPath) as?
                    MyPageCategoryCollectionViewCell else {
                return UICollectionViewCell()
            }
            let target = categoryDataList[indexPath.row+1]
            let img = UIImage(named: "\(target.image).svg")
            cell.keywordImage.image = img
            cell.keywordLabel.text = target.title
            
            return cell
        case challengeFeedBoxCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyChallengeFeedCollectionViewCell.identifier, for: indexPath) as?
                    MyChallengeFeedCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.challengeFeed.image = UIImage(named: imageList[indexPath.row])
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
    // cell 선택시 액션
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView{
        case categoryCollectionView:
            didTapButton()
        case challengeFeedBoxCollectionView:
            let cell = collectionView.cellForItem(at: indexPath) as! MyChallengeFeedCollectionViewCell
            feedDetailCollectionView.isHidden = false
            feedDetailBackground.isHidden = false
            fullScrollView.isScrollEnabled = false
            let feedCell = feedDetailCollectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as! FeedDetailCollectionViewCell
            feedCell.feedImage.image = cell.challengeFeed.image
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
        if (scrollView.contentOffset.y + 1) >= (scrollView.contentSize.height - scrollView.frame.size.height) {
            moreFeedButton.isHidden = false
        }
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
extension FindViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let allWidth = self.HofChallengeCollectionView.contentSize.width + self.HofChallengeCollectionView.contentInset.left + self.HofChallengeCollectionView.contentInset.right
        let showingWidth = self.HofChallengeCollectionView.bounds.width
        // 움직일 scroll 길이 설정
        self.scrollIndicator.widthRatio = showingWidth / allWidth
        self.scrollIndicator.layoutIfNeeded()
    }
    
    @objc func showMoreFeed() {
        imageList = imageList + ["image 8", "image 9"]
        challengeFeedBoxCollectionView.reloadData()
        moreFeedButton.isHidden = true
        fullScrollView.updateContentSize()
        fullContentView.snp.remakeConstraints { make in
            make.edges.equalTo(fullScrollView.contentLayoutGuide)
            make.width.equalTo(fullScrollView.frameLayoutGuide)
            make.height.equalTo(fullScrollView.contentSize.height + 10)
        }
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
extension FindViewController: CustomFeedCellDelegate {
    func didTapButton() {
        feedDetailCollectionView.isHidden = true
        feedDetailBackground.isHidden = true
        fullScrollView.isScrollEnabled = true
    }
}

// 동적으로 scroll view 크기 설정
extension UIScrollView {
    func updateContentSize() {
        let unionCalculatedTotalRect = recursiveUnionInDepthFor(view: self)
        
        // 계산된 크기로 컨텐츠 사이즈 설정
        self.contentSize = CGSize(width: self.frame.width, height: unionCalculatedTotalRect.height+50)
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

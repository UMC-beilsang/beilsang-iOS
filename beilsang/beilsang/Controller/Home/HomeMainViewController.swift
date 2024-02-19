//
//  HomeMainViewController.swift
//  beilsang
//
//  Created by 곽은채 on 1/26/24.
//

import SnapKit
import UIKit

// [홈] 메인화면 전체
class HomeMainViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Properties
    
    // 전체 화면 scrollview
    let fullScrollView = UIScrollView()
    let fullContentView = UIView()
    
    // topview
    lazy var topView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    // topview - logo
    lazy var logoImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "logo_symbol")
        view.sizeToFit()
        
        return view
    }()
    
    // topview - logo text
    lazy var logoTextImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "logo_typo")
        view.sizeToFit()
        
        return view
    }()
    
    // pageView - title, image setting
    let pageTitles = ["나만의 챌린지\n바로 만들어 보기!", "챌린저들과\n친환경 챌린지 참여하기!", "비일상 챌린지\n참여방법 알아보기!"]
    let pageImages = [UIImage(named: "Thumbnail Banner-1"), UIImage(named: "Thumbnail Banner-2"), UIImage(named: "Thumbnail Banner-3")]
    var pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
    // pageView - sliding button
    lazy var pageControl: UIPageControl = {
        let view = UIPageControl()
        
        view.numberOfPages = pageTitles.count
        view.currentPageIndicatorTintColor = .beScPurple600
        view.pageIndicatorTintColor = .beBgDef
        
        return view
    }()
    
    // categoriesView - 셀
    let categoryDataList = CategoryKeyword.data
    lazy var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 80, height: 80)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return view
    }()
    
    // borderView
    lazy var borderline: UIView = {
        let view = UIView()
        
        view.backgroundColor = .beBgSub
        
        return view
    }()
    
    // participatingChallengeView - before
    let mainBeforeVC = MainBeforeViewController()
    
    // participatingChallengeView - after
    let mainAfterVC = MainAfterViewController()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupAttribute()
        setNavigationBar()
        setChallengeStatus()
        setCollectionView()
    }
}

// MARK: - Layout
extension HomeMainViewController {
    
    func setupAttribute() {
        setFullScrollView()
        setAddViews()
        setLayout()
        setUI()
        
        setupPageView()
        setAddChild()
    }
    
    func setupPageView() {
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        // 첫번째로 보여지는 뷰컨트롤러 설정
        let firstVC = PageViewController(pageTitle: pageTitles[0], pageImage: pageImages[0]!)
        pageViewController.setViewControllers([firstVC], direction: .forward, animated: false, completion: nil)
    }
    
    func setAddChild() {
        addChild(pageViewController)
        addChild(mainBeforeVC)
        addChild(mainAfterVC)
        
        pageViewController.didMove(toParent: self)
        mainBeforeVC.didMove(toParent: self)
        mainAfterVC.didMove(toParent: self)
    }
    
    func setUI() {
        mainBeforeVC.view.isHidden = true
        mainAfterVC.view.isHidden = true
    }
    
    func setFullScrollView() {
        fullScrollView.showsVerticalScrollIndicator = true
        fullScrollView.delegate = self
    }
    
    func setAddViews() {
        view.addSubview(fullScrollView)
//        view.addSubview(topView)
        
        fullScrollView.addSubview(fullContentView)
        
        [pageViewController.view, pageControl, categoryCollectionView, borderline, mainBeforeVC.view, mainAfterVC.view].forEach { view in
            fullContentView.addSubview(view)
        }
        
        [logoImage, logoTextImage].forEach { view in
            topView.addSubview(view)
        }
    }
    
    func setLayout() {
        fullScrollView.snp.makeConstraints { make in
//            make.top.equalTo(topView.snp.bottom)
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        fullContentView.snp.makeConstraints { make in
            make.edges.equalTo(fullScrollView.contentLayoutGuide)
            make.width.equalTo(fullScrollView.frameLayoutGuide)
            make.bottom.equalTo(fullScrollView.snp.bottom)
        }
        
        logoImage.snp.makeConstraints { make in
            make.leading.equalTo(topView.snp.leading).offset(16)
            make.centerY.equalTo(topView.snp.centerY)
            make.height.width.equalTo(28)
        }
        
        logoTextImage.snp.makeConstraints { make in
            make.leading.equalTo(logoImage.snp.trailing).offset(6)
            make.centerY.equalTo(logoImage.snp.centerY)
            make.height.equalTo(17)
            make.width.equalTo(45)
        }
        
        pageViewController.view.snp.makeConstraints { make in
            make.top.equalTo(fullContentView.snp.top)
            make.width.equalTo(fullScrollView.snp.width)
            make.height.equalTo(240)
        }
        
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(pageViewController.view.snp.bottom).offset(-16)
            make.centerX.equalTo(pageViewController.view)
        }
        
        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(pageViewController.view.snp.bottom).offset(20)
            make.leading.equalTo(fullScrollView.snp.leading).offset(16)
            make.trailing.equalTo(fullScrollView.snp.trailing).offset(-16)
            make.height.equalTo(168)
        }
        
        borderline.snp.makeConstraints { make in
            make.top.equalTo(categoryCollectionView.snp.bottom).offset(32)
            make.width.equalTo(fullScrollView.snp.width)
            make.height.equalTo(8)
        }
        
        mainBeforeVC.view.snp.makeConstraints { make in
            make.top.equalTo(borderline.snp.bottom)
            make.width.equalTo(fullScrollView.snp.width)
            make.height.equalTo(235)
        }
        
        mainAfterVC.view.snp.makeConstraints { make in
            make.top.equalTo(borderline.snp.bottom)
            make.width.equalTo(fullScrollView.snp.width)
            make.height.equalTo(456)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - 네비게이션 바 커스텀
extension HomeMainViewController{
    private func setNavigationBar() {
        self.navigationItem.titleView = attributeTitleView()
        setBackButton()
    }
    private func attributeTitleView() -> UIView {
        // 네비게이션 바에 타이틀을 왼쪽으로 옮기기 위해 커스텀 뷰 생성
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        // 네비게이션 바에 타이틀을 왼쪽으로 옮기기 위해 커스텀 뷰 생성
        topView.frame = CGRect(x: 0, y: 0, width: 80, height: 44)
        view.addSubview(topView)
        return view
    }
    // 백버튼 커스텀
    func setBackButton() {
        let notiButton = UIBarButtonItem(image: UIImage(named: "iconamoon_notification-bold")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(tabBarNotiButtonTapped))
        notiButton.tintColor = .black
        let searchButton = UIBarButtonItem(image: UIImage(named: "icon-search")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(tabBarSearchButtonTapped))
        searchButton.tintColor = .black
        self.navigationItem.rightBarButtonItems = [searchButton, notiButton]
    }
    // 사이드 버튼 액션 - 알림
    @objc func tabBarNotiButtonTapped() {
        print("알림버튼")
        let notificationVC = NotificationViewController()
        navigationController?.pushViewController(notificationVC, animated: true)
    }
    // 사이드 버튼 액션 - 검색
    @objc func tabBarSearchButtonTapped() {
        print("검색버튼")
        let searchVC = SearchViewController()
        searchVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(searchVC, animated: true)
    }
}

// MARK: - network
extension HomeMainViewController {
    func setChallengeStatus() {
        ChallengeService.shared.challengeCategoriesEnrolled { response in
            let isEnrolled = !(response.data?.challenges.challenges.isEmpty ?? true)
            print(isEnrolled)
            self.setChallengeParticipate(isEnrolled: isEnrolled)
        }
    }
    
    func setChallengeParticipate(isEnrolled: Bool) {
        if isEnrolled {
            mainAfterVC.view.isHidden = false
        } else {
            mainBeforeVC.view.isHidden = false
        }
    }
}

// MARK: - collectionView setting(카테고리)
extension HomeMainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    // collectionView, delegate, datasorce 설정
    func setCollectionView() {
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
    }
    
    // cell 개수 설정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryDataList.count
    }
    
    // cell 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as?
                CategoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        let target = categoryDataList[indexPath.row]
        let img = UIImage(named: "\(target.image).svg")
        cell.keywordImage.image = img
        cell.keywordLabel.text = target.title
        
        return cell
    }
    
    // cell 선택시 액션
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CategoryCollectionViewCell
        
        let labelText = cell.keywordLabel.text
        let challengeListVC = ChallengeListViewController()
        challengeListVC.categoryLabelText = labelText
        challengeListVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(challengeListVC, animated: true)
    }
}

// MARK: - PageViewController
extension HomeMainViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    // 이전 뷰컨트롤러를 리턴 (우측 -> 좌측 슬라이드 제스쳐)
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let lastVC = viewController as? PageViewController,
           let index = pageTitles.firstIndex(of: lastVC.pageTitle),
           index > 0 {
            return PageViewController(pageTitle: pageTitles[index - 1], pageImage: pageImages[index - 1]!)
        } else {
            return PageViewController(pageTitle: pageTitles[2], pageImage: pageImages[2]!)
        }
    }
    
    // 다음 보여질 뷰컨트롤러를 리턴 (좌측 -> 우측 슬라이드 제스쳐)
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let nextVC = viewController as? PageViewController,
           let index = pageTitles.firstIndex(of: nextVC.pageTitle),
           index < pageTitles.count - 1 {
            return PageViewController(pageTitle: pageTitles[index + 1], pageImage: pageImages[index + 1]!)
        } else {
            return PageViewController(pageTitle: pageTitles[0], pageImage: pageImages[0]!)
        }
    }
    
    // UIPageViewControllerDelegate의 메서드를 사용하여 UIPageControl의 현재 페이지를 업데이트합니다.
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed,
           let viewController = pageViewController.viewControllers?.first as? PageViewController,
           let index = pageTitles.firstIndex(of: viewController.pageTitle) {
            pageControl.currentPage = index
        }
    }
}

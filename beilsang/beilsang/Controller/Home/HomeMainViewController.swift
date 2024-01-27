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
    
    // topview - alarm
    lazy var alarmButton: UIButton = {
        let view = UIButton()
        
        view.setImage(UIImage(named: "icon-notification"), for: .normal)
        view.tintColor = .beIconDef
        
        return view
    }()
    
    // topview - search
    lazy var searchButton: UIButton = {
        let view = UIButton()
        
        view.setImage(UIImage(named: "icon-search"), for: .normal)
        view.tintColor = .beIconDef
        
        return view
    }()
    
    // pageView - title, color setting
    let pageTitles = ["나만의 챌린지\n바로 만들어 보기!", "챌린저들과\n친환경 챌린지 참여하기!", "내 주변 친환경 스팟\n어디 있을까?"]
    let pageColor = [UIColor.beScPurple400, UIColor.beBgDef, UIColor.beMint500]
    var pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
    // pageView - sliding button
    lazy var pageControl: UIPageControl = {
        let view = UIPageControl()
        
        view.numberOfPages = pageTitles.count
        view.currentPageIndicatorTintColor = .beScPurple600
        view.pageIndicatorTintColor = .beBgDef
        
        return view
    }()
    
    // categoriesView
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
        setCollectionView()
    }
}

// MARK: - Layout
extension HomeMainViewController {
    
    func setupAttribute() {
        setFullScrollView()
        setLayout()
        
        setupPageView()
        setAddChild()
    }
    
    func setupPageView() {
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        // 첫번째로 보여지는 뷰컨트롤러 설정
        let firstVC = PageViewController(pageTitle: pageTitles[0], pageColor: pageColor[0])
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
    
    func setFullScrollView() {
        fullScrollView.showsVerticalScrollIndicator = true
        fullScrollView.delegate = self
    }
    
    func setLayout() {
        view.addSubview(fullScrollView)
        view.addSubview(topView)
        
        fullScrollView.addSubview(fullContentView)
        
        fullScrollView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.bottom.leading.trailing.equalToSuperview()
        }
        
        fullContentView.addSubview(pageViewController.view)
        fullContentView.addSubview(pageControl)
        fullContentView.addSubview(categoryCollectionView)
        fullContentView.addSubview(borderline)
        fullContentView.addSubview(mainBeforeVC.view)
        fullContentView.addSubview(mainAfterVC.view)
        
        fullContentView.snp.makeConstraints { make in
            make.edges.equalTo(fullScrollView.contentLayoutGuide)
            make.width.equalTo(fullScrollView.frameLayoutGuide)
            make.height.equalTo(1140)
        }
        
        topView.addSubview(logoImage)
        topView.addSubview(logoTextImage)
        topView.addSubview(alarmButton)
        topView.addSubview(searchButton)
        
        topView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(46)
            make.width.equalTo(fullScrollView.snp.width)
            make.height.equalTo(48)
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
        
        alarmButton.snp.makeConstraints { make in
            make.trailing.equalTo(topView.snp.trailing).offset(-68)
            make.centerY.equalTo(logoImage.snp.centerY)
            make.height.width.equalTo(24)
        }
        
        searchButton.snp.makeConstraints { make in
            make.trailing.equalTo(topView.snp.trailing).offset(-20)
            make.centerY.equalTo(logoImage.snp.centerY)
            make.height.width.equalTo(24)
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
            make.top.equalTo(pageViewController.view.snp.bottom).offset(24)
            make.leading.equalTo(fullScrollView.snp.leading).offset(16)
            make.height.equalTo(168)
            make.width.equalTo(fullScrollView.snp.width)
        }
        
        borderline.snp.makeConstraints { make in
            make.top.equalTo(categoryCollectionView.snp.bottom).offset(24)
            make.width.equalTo(fullScrollView.snp.width)
            make.height.equalTo(8)
        }
        
        mainBeforeVC.view.snp.makeConstraints { make in
            make.top.equalTo(borderline.snp.bottom)
            make.width.equalTo(fullScrollView.snp.width)
            make.height.equalTo(235)
        }
        
        mainAfterVC.view.snp.makeConstraints { make in
            make.top.equalTo(mainBeforeVC.view.snp.bottom)
            make.width.equalTo(fullScrollView.snp.width)
            make.height.equalTo(456)
            make.bottom.equalToSuperview()
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
        
        // ChallengeListViewController를 푸시합니다.
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
            return PageViewController(pageTitle: pageTitles[index - 1], pageColor: pageColor[index - 1])
        } else {
            return PageViewController(pageTitle: pageTitles[2], pageColor: pageColor[2])
        }
    }
    
    // 다음 보여질 뷰컨트롤러를 리턴 (좌측 -> 우측 슬라이드 제스쳐)
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let nextVC = viewController as? PageViewController,
           let index = pageTitles.firstIndex(of: nextVC.pageTitle),
           index < pageTitles.count - 1 {
            return PageViewController(pageTitle: pageTitles[index + 1], pageColor: pageColor[index + 1])
        } else {
            return PageViewController(pageTitle: pageTitles[0], pageColor: pageColor[0])
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

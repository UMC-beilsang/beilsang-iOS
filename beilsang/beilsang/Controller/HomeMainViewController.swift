//
//  ViewController.swift
//  beilsang
//
//  Created by Seyoung on 1/16/24.
//

import SnapKit
import UIKit

class HomeMainViewController: UIViewController, UIScrollViewDelegate, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    // MARK: - Properties
    
    // 전체 화면 scrollview
    let fullScrollView = UIScrollView()
    let fullContentView = UIView()
    
    // topview
    lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        
        return view
    }()
    
    // topview - logo
    lazy var logoImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Logo")
        view.sizeToFit()
        
        return view
    }()
    
    // topview - logo text
    lazy var logoTextImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Logo_text")
        view.sizeToFit()
        
        return view
    }()
    
    // topview - alarm
    lazy var alarmButton: UIButton = {
        let view = UIButton()
        
        view.setImage(UIImage(named: "alarm"), for: .normal)
        view.tintColor = .black
        
        return view
    }()
    
    // topview - search
    lazy var searchButton: UIButton = {
        let view = UIButton()
        
        view.setImage(UIImage(named: "search"), for: .normal)
        view.tintColor = .black
        
        return view
    }()
    
    // pageView - sliding button
    lazy var pageControl: UIPageControl = {
        let view = UIPageControl()
        
        view.numberOfPages = pageTitles.count
        view.currentPageIndicatorTintColor = UIColor(red: 123/255, green: 135/255, blue: 219/255, alpha: 1)
        view.pageIndicatorTintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        
        return view
    }()
    
    // categoriesView
    
    // borderView
    lazy var borderline: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
        
        return view
    }()
    
    // participatingChallengeView - label
    
    // participatingChallengeView - button
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupAttribute()
    }
    
    // MARK: - pageviewcontroller
    let pageTitles = ["나만의 챌린지\n바로 만들어 보기!", "챌린저들과\n친환경 챌린지 참여하기!", "내 주변 친환경 스팟\n어디 있을까?"]
    let pageColor = [UIColor(red: 190/255, green: 200/255, blue: 255/255, alpha: 1), UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1), UIColor(red: 169/255, green: 222/255, blue: 226/255, alpha: 1)]
    
    var pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
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

// MARK: - Layout
extension HomeMainViewController {
    
    func setupAttribute() {
        setFullScrollView()
        setLayout()
        setupPageView()
    }
    
    func setupPageView() {
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        addChild(pageViewController)
        
        // 첫번째로 보여지는 뷰컨트롤러 설정
        let firstVC = PageViewController(pageTitle: pageTitles[0], pageColor: pageColor[0])
        pageViewController.setViewControllers([firstVC], direction: .forward, animated: false, completion: nil)
    }
    
    func setFullScrollView() {
        fullScrollView.showsVerticalScrollIndicator = true
        fullScrollView.delegate = self
    }
    
    func setLayout() {
        view.addSubview(fullScrollView)
        
        fullScrollView.addSubview(fullContentView)
        
        fullScrollView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        fullContentView.addSubview(topView)
        fullContentView.addSubview(pageViewController.view)
        fullContentView.addSubview(pageControl)
        fullContentView.addSubview(borderline)
        
        fullContentView.snp.makeConstraints { make in
            make.edges.equalTo(fullScrollView.contentLayoutGuide)
            make.width.equalTo(fullScrollView.frameLayoutGuide)
            make.height.equalTo(1065)
        }
        
        topView.addSubview(logoImage)
        topView.addSubview(logoTextImage)
        topView.addSubview(alarmButton)
        topView.addSubview(searchButton)
        
        topView.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.width.equalTo(fullScrollView.snp.width)
            make.height.equalTo(48)
        }
        
        logoImage.snp.makeConstraints { make in
            make.leading.equalTo(topView.snp.leading).offset(16)
            make.centerY.equalTo(topView.snp.centerY)
        }
        
        logoTextImage.snp.makeConstraints { make in
            make.leading.equalTo(logoImage.snp.trailing).offset(6)
            make.centerY.equalTo(logoImage.snp.centerY)
        }
        
        alarmButton.snp.makeConstraints { make in
            make.trailing.equalTo(topView.snp.trailing).offset(-68)
            make.centerY.equalTo(logoImage.snp.centerY)
        }
        
        searchButton.snp.makeConstraints { make in
            make.trailing.equalTo(topView.snp.trailing).offset(-20)
            make.centerY.equalTo(logoImage.snp.centerY)
        }
        
        pageViewController.view.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.width.equalTo(fullScrollView.snp.width)
            make.height.equalTo(240)
        }
        
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(pageViewController.view.snp.bottom).offset(-16)
            make.centerX.equalTo(pageViewController.view)
        }
        
        borderline.snp.makeConstraints { make in
            make.top.equalTo(pageViewController.view.snp.bottom).offset(24)
            make.width.equalTo(fullScrollView.snp.width)
            make.height.equalTo(8)
        }
    }
}

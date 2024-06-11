//
//  TabBarViewController.swift
//  beilsang
//
//  Created by 강희진 on 2/8/24.
//

import UIKit
import SnapKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = .beScPurple600
        self.tabBar.backgroundColor = .white
        self.tabBar.unselectedItemTintColor = .beIconDis
        self.tabBar.scrollEdgeAppearance = UITabBarAppearance()
        
        let homeTab = UINavigationController(rootViewController: HomeMainViewController())
        homeAttribute(homeTab)
        homeTab.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        homeTab.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 20)
        
        let findTab = UINavigationController(rootViewController: FindViewController())
        findAttribute(findTab)
        findTab.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        findTab.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 20)
        
//        let moreTab = UINavigationController(rootViewController: LearnMoreViewController())
//        moreAttribute(moreTab)
//        moreTab.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
//        moreTab.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 5)
//
        let mypageTab = UINavigationController(rootViewController: MyPageViewController())
        mypageAttribute(mypageTab)
        mypageTab.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        mypageTab.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 20)

        viewControllers = [findTab, homeTab, mypageTab]
        
        selectedIndex = 1 // '홈' 탭을 기본적으로 선택
        
        self.delegate = self
    }
}

extension TabBarViewController {
    
    func findAttribute(_ tab : UINavigationController) {
        let findTabItem = UITabBarItem(title: "발견", image: UIImage(named: "icon-discover"), tag: 0)
        tab.tabBarItem = findTabItem
    }
    func homeAttribute(_ tab : UINavigationController) {
        let homeTabItem = UITabBarItem(title: "홈", image: UIImage(named: "icon-home"), tag: 1)
        tab.tabBarItem = homeTabItem
    }
//    func moreAttribute(_ tab : UINavigationController) {
//        let moreTabItem = UITabBarItem(title: "더 알아보기", image: UIImage(named: "icon-learn-more-1"), tag: 2)
//        tab.tabBarItem = moreTabItem
//    }
    func mypageAttribute(_ tab : UINavigationController) {
        let mypageTabItem = UITabBarItem(title: "마이페이지", image: UIImage(named: "icon-my-page"), tag: 2)
        tab.tabBarItem = mypageTabItem
    }
}

extension TabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController is ChallengeDetailViewController {
            self.tabBar.isHidden = true
        } else {
            self.tabBar.isHidden = false
        }
        return true
    }
}

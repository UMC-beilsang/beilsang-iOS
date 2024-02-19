//
//  TabManViewController.swift
//  beilsang
//
//  Created by Seyoung on 2/18/24.
//

import UIKit
import SnapKit
import Tabman
import Pageboy

class TabManViewController: TabmanViewController {
    
    lazy var viewControllers: [UIViewController] = []
    let bar = TMBar.ButtonBar()
    
    let firstVC = SearchChallengeViewController()
    let secondVC = SearchFeedViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setUI()
        setLayout()
       
    }
    
    // MARK: - UI Setup
    
    private func setUI() {
      
    }
    
    private func setLayout() {
        viewControllers.append(firstVC)
        viewControllers.append(secondVC)
        
        self.dataSource = self

        //탭바 레이아웃 설정
        bar.layout.transitionStyle = .none
        //        .fit : indicator가 버튼크기로 설정됨
        bar.layout.contentMode = .fit
        bar.layout.interButtonSpacing = 20 // 버튼 사이 간격 (화면 보면서 필요시 조절)
        //간격설정
        bar.layout.contentInset = UIEdgeInsets(top: 0, left: 53, bottom: 0, right: 53)
        bar.backgroundView.style = .clear
        bar.backgroundColor = .white
        
        
        bar.buttons.customize{
            (button)
            in
            button.tintColor = .gray
            button.selectedTintColor = .black
            button.font = UIFont(name: "NotoSansKR-Medium", size: 16)!
        }
        //indicator
        bar.indicator.weight = .custom(value: 1)
        bar.indicator.overscrollBehavior = .bounce
        bar.indicator.tintColor = .beBorderAct
        
        addBar(bar, dataSource: self, at:.top)
        
        view.addSubview(bar)
        
        let width = UIScreen.main.bounds.width
        
        bar.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.width.equalTo(width)
        }
        
    }
}

//MARK: - TabManSetting
extension TabManViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: "챌린지")
        case 1:
            return TMBarItem(title: "피드")
        default:
            let title = "Page \(index)"
            return TMBarItem(title: title)
        }
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
    
}

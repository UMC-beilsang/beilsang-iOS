//
//  SearchResultViewController.swift
//  beilsang
//
//  Created by Seyoung on 2/8/24.
//

import UIKit
import SnapKit

class SearchResultViewController: UIViewController, UIScrollViewDelegate {
    
    let fullScrollView = UIScrollView()
    let fullContentView = UIView()
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goToChildView()
        setupUI()
        
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        fullScrollView.showsVerticalScrollIndicator = true
        fullScrollView.delegate = self
        fullScrollView.isScrollEnabled = true
        view.backgroundColor = .white
        view.addSubview(fullScrollView)
        fullScrollView.addSubview(fullContentView)
        
        fullScrollView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.bottom.leading.trailing.equalToSuperview()
        }
         
        
        let searchChallengeVC = SearchChallengeViewController()
        let collectionViewHeight = searchChallengeVC.dataCount * 140 + (searchChallengeVC.dataCount - 1) * 8
        let viewHeight = collectionViewHeight + 200
        
        fullContentView.snp.makeConstraints { make in
            make.edges.equalTo(fullScrollView.contentLayoutGuide)
            make.width.equalTo(fullScrollView.frameLayoutGuide)
            // 컨텐츠 높이에 맞게 동적으로 변경되도록 설정
            make.height.equalTo(viewHeight)
        }
    }
    
    private func goToChildView() {
        // .init()은 코드로 직접 초기화하는 커스텀 함수
        let childVC = TabManViewController()
        // frame 설정
        childVC.view.frame = self.view.bounds
        
        self.addChild(childVC)
        
        // 단순한 addSubView는 부모-자식 관계 성립 안함
        self.fullContentView.addSubview(childVC.view)
        // code 로 작업하면 didMove 직접 호출해 줘야, childVC 에 있을 didMove override 함수가 동작할 수 있음
        childVC.didMove(toParent: self)
    }
    
}

//MARK: - addChild




extension SearchResultViewController: UISearchBarDelegate {
    // 서버한테 결과 받아서
}

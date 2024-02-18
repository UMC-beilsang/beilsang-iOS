//
//  SearchResultViewController.swift
//  beilsang
//
//  Created by Seyoung on 2/18/24.
//

import UIKit
import SnapKit

class SearchResultViewController: UIViewController, UIScrollViewDelegate {
    
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
        view.backgroundColor = .white
        view.addSubview(fullContentView)

        let searchChallengeVC = SearchChallengeViewController()
        let collectionViewHeight = searchChallengeVC.challengeList.count * 140 + searchChallengeVC.challengeList.count * 8 + 30
        let tipViewHeight = 100
        let contentHeight = collectionViewHeight + tipViewHeight + 8 + 64
        
        fullContentView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview()
            make.width.equalTo(width)
            make.height.equalTo(contentHeight)
        }
    }
    
    private func goToChildView() {
        let childVC = TabManViewController()

        self.addChild(childVC)
        self.fullContentView.addSubview(childVC.view)
        childVC.didMove(toParent: self)
        
        childVC.view.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
    }
    
}

extension SearchResultViewController: UISearchBarDelegate {
    // 서버한테 결과 받아서
}


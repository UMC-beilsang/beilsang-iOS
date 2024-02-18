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
    
    var challengeList : [Challenge] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        request()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { // 1초 딜레이
            self.goToChildView()
            
            if self.challengeList.isEmpty {
                self.setupNewUI()
            }
            else{
                self.setupUI()
            }
        }
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(fullContentView)

        let collectionViewHeight = challengeList.count * 140 + challengeList.count * 8 + 30
        let tipViewHeight = 100
        let contentHeight = collectionViewHeight + tipViewHeight + 8 + 160
        
        fullContentView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview()
            make.width.equalTo(width)
            make.height.equalTo(contentHeight)
        }
    }
    
    private func setupNewUI() {
        view.backgroundColor = .white
        view.addSubview(fullContentView)
        
        fullContentView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview()
            make.width.equalTo(width)
            make.height.equalTo(1000)
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

extension SearchResultViewController {
    func request() {
        let searchText = SearchGlobalData.shared.searchText
        SearchService.shared.SearchResult(name: "\(searchText ?? "")") { response in
            self.setChallenge(response.data.challenges)
        }
    }
    
    @MainActor
    func setChallenge(_ response: [Challenge]) {
        self.challengeList = response
        
    }
}

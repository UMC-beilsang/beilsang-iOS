//
//  SearchViewController.swift
//  beilsang
//
//  Created by Seyoung on 2/7/24.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
    
    let navigationBarView = UIView()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "게시물 검색"
        view.font = UIFont(name: "NotoSansKR-SemiBold", size: 20)
        view.numberOfLines = 0
        view.textColor = .beTextDef
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var closeButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "xiconblack"), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.tintColor = UIColor.beTextDef
        view.addTarget(self, action: #selector(closeButtonTapped), for: .touchDown)
        
        return view
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .beBorderDis
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        setNavigationBar()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        //navigationBarHidden()
        view.backgroundColor = .beBgDef
        view.addSubview(lineView)
    }
    
    private func setupLayout() {
        
        lineView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(100)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)}
    }
    
    // MARK: - Actions
    
    @objc func closeButtonTapped() {
        print("closeButton")
    }
}

// MARK: - setNavigationBar

extension SearchViewController {
    func setNavigationBar() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController

        let width = UIScreen.main.bounds.width
        let navigationBarHeight = navigationController?.navigationBar.frame.height ?? 0
        
        //navigationItem.leftBarButtonItem = nil
        navigationItem.rightBarButtonItem = nil

        navigationBarView.addSubview(closeButton)
        navigationBarView.addSubview(titleLabel)
        
        navigationBarView.snp.makeConstraints{ make in
            make.width.equalTo(width)
            make.height.equalTo(navigationBarHeight)
        }
        titleLabel.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(4)
            make.centerY.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints{ make in
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(24)
        }
        
        //navigationItem.titleView = navigationBarView
        
        let leftBarButton = UIBarButtonItem(customView: navigationBarView)
        navigationItem.leftBarButtonItem = leftBarButton
        
    }
}

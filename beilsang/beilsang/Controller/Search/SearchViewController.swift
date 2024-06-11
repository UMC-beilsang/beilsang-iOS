//
//  SearchViewController.swift
//  beilsang
//
//  Created by Seyoung on 2/18/24.
//

import UIKit
import SnapKit
import Kingfisher

class SearchViewController: UIViewController {
    
    var searchBar: UISearchBar!
    var dataList = UserDefaults.standard.array(forKey: Const.UserDefaultsKey.recentSearchTerms) as? [String] ?? []
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backbutton"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchDown)
        
        return button
    }()
    
    lazy var recentSearchTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "최근 검색어"
        view.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        view.numberOfLines = 0
        view.textColor = .beTextSub
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var allClearButton: UIButton = {
        let view = UIButton()
        view.setTitle("모두 삭제", for: .normal)
        view.setTitleColor(.beTextDef, for: .normal)
        view.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(allClear), for: .touchDown)
        
        return view
    }()
    
    lazy var recentTermCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(RecentSearchCollectionViewCell.self, forCellWithReuseIdentifier: RecentSearchCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSearchBar()
        setupUI()
        setupLayout()
        setNavigationBar()
    }
    
    // MARK: - Actions
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func allClear() {
        UserDefaults.standard.set([], forKey: Const.UserDefaultsKey.recentSearchTerms)
        dataList.removeAll()
        recentTermCollectionView.reloadData()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(recentSearchTitleLabel)
        view.addSubview(allClearButton)
        view.addSubview(recentTermCollectionView)
        
    }
    
    private func setupLayout() {
        recentSearchTitleLabel.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(28)
            make.leading.equalToSuperview().offset(16)
        }
        
        allClearButton.snp.makeConstraints{ make in
            make.centerY.equalTo(recentSearchTitleLabel)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        recentTermCollectionView.snp.makeConstraints{ make in
            make.top.equalTo(recentSearchTitleLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - setNavigationBar, search Bar

extension SearchViewController {
    func setNavigationBar() {
        navigationController?.navigationBar.barTintColor = .white
        let barButton = UIBarButtonItem(customView: backButton)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBar)
        navigationItem.leftBarButtonItem = barButton
        
        if let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField {
            textFieldInsideSearchBar.layer.cornerRadius = 20
            textFieldInsideSearchBar.clipsToBounds = true
        }
    }
    
    func setSearchBar() {
        let bounds = UIScreen.main.bounds
        let width = bounds.size.width
        
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: width - 80, height: 48))
        searchBar.delegate = self
        searchBar.placeholder = "누구나 즐길 수 있는 친환경 챌린지!🌱"
        searchBar.searchTextField.font = UIFont(name: "NotoSansKR-Medium", size: 14)
    }
}

// MARK: - collectionView setting
extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentSearchCollectionViewCell.identifier, for: indexPath) as?
                RecentSearchCollectionViewCell else {
            return UICollectionViewCell()
        }
        let target = dataList[indexPath.row]
        cell.termLabel.text = target
        cell.deleteHandler = { [weak self] in
            guard let self = self else { return }
            guard let indexPath = self.recentTermCollectionView.indexPath(for: cell) else { return }
            
            self.dataList.remove(at: indexPath.item)
            self.recentTermCollectionView.deleteItems(at: [indexPath])
        }
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard collectionView.dequeueReusableCell(withReuseIdentifier: RecentSearchCollectionViewCell.identifier, for: indexPath) is RecentSearchCollectionViewCell else {
            return CGSize.zero
        }
        
        let text = dataList[indexPath.item]
        
        let estimatedWidth = text.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]).width
        
        return CGSize(width: estimatedWidth + 48, height: 28)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 4  // 원하는 간격으로 설정
        }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            var recentSearchTerms = UserDefaults.standard.array(forKey: Const.UserDefaultsKey.recentSearchTerms) as? [String] ?? []
            recentSearchTerms.append(searchText)
            UserDefaults.standard.set(recentSearchTerms, forKey: Const.UserDefaultsKey.recentSearchTerms)
        }

        searchBar.resignFirstResponder()
        
        let searchResultViewController = SearchResultViewController()
        SearchGlobalData.shared.searchText = searchBar.text
        
        // 현재 자식 뷰 컨트롤러 제거
        self.children.forEach { $0.removeFromParent()}
        
        // 새로운 뷰 컨트롤러 추가
        self.addChild(searchResultViewController)
        self.view.addSubview(searchResultViewController.view)
        searchResultViewController.didMove(toParent: self)
    }
}

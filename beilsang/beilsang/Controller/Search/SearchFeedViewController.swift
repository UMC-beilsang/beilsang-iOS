//
//  SearchFeedViewController.swift
//  beilsang
//
//  Created by Seyoung on 2/18/24.
//

import UIKit
import SnapKit
import Kingfisher

class SearchFeedViewController: UIViewController, UIScrollViewDelegate {
    
    //MARK: - Properties
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    var feedList : [Feed] = []
    
    lazy var fullScrollView: UIScrollView = {
            let scrollView = UIScrollView()
            scrollView.delegate = self
            return scrollView
        }()
    
    lazy var fullContentView: UIView = {
            let view = UIView()
            return view
        }()

    lazy var feedCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    
    //MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        request()
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { // 1초 딜레이
            self.setupUI()
            self.setupLayout()
            
        }
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        feedCollectionView.isScrollEnabled = false
        self.feedCollectionView.delegate = self
        self.feedCollectionView.dataSource = self
        self.feedCollectionView.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.identifier)
        
        view.addSubview(fullScrollView)
    
        fullScrollView.addSubview(fullContentView)
        fullContentView.addSubview(feedCollectionView)
    }
    
    private func setupLayout() {
        
        let collectionViewHeight = (Int(ceil(Double(feedList.count) / 2.0))) * 140 + (Int(ceil(Double(feedList.count) / 2.0))) * 12 + 30
        let contentHeight = collectionViewHeight + 120 // 8은 간격, 64는 top safe area
        
        fullScrollView.snp.makeConstraints{ make in
            make.top.leading.equalToSuperview()
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
        
        fullContentView.snp.makeConstraints{ make in
            make.edges.equalTo(fullScrollView.contentLayoutGuide)
            make.height.equalTo(contentHeight)
            make.width.equalTo(fullScrollView.frameLayoutGuide)
        }
        
        feedCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(64)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(collectionViewHeight)
        }
    }
    
    //MARK: - Actions
    
    @objc func tipViewTapped(_ sender: UIButton) {
        print("tipViewTapped")
    }

}

// MARK: - collectionView setting(챌린지 리스트)
extension SearchFeedViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // 셀 개수 설정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feedList.count
    }
    
    // 셀 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.identifier, for: indexPath) as?
                GalleryCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let target = feedList[indexPath.row]
        
        if let url = URL(string: target.feedUrl) {
            cell.galleryImage.kf.setImage(with: url)
        }
        cell.FeedId = target.feedId
        
        return cell
    }
    
    // 셀 크기 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width)/2 - 16 - 6
        
        return CGSize(width: width , height: 140)
    }
}

extension SearchFeedViewController {
    func request() {
        let searchText = SearchGlobalData.shared.searchText
        SearchService.shared.SearchResult(name: "\(searchText ?? "")") { response in
            self.setChallenge(response.data.feeds)
        }
    }
    
    @MainActor
    func setChallenge(_ response: [Feed]) {
        self.feedList = response
        self.feedCollectionView.reloadData()
        
    }
}

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
    var challengeRecommendData : [ChallengeRecommendsData] = []
    
    var feedList : [Feed] = []
    
    lazy var changedContentView : UIView = {
        let view = UIView()
        
        return view
    }()
    
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
    
    //ChangedView
    lazy var noResultLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        view.numberOfLines = 0
        view.textColor = .beTextSub
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var noResultSmallLabel: UILabel = {
        let view = UILabel()
        view.text = "다른 키워드로 검색해 볼까요?"
        view.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        view.numberOfLines = 0
        view.textColor = .beTextInfo
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var noResultImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "noresult")
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        
        return view
    }()
    
    lazy var tipTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "💡 Tip"
        view.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        view.numberOfLines = 0
        view.textColor = .beTextSub
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var tip1Label: UILabel = {
        let view = UILabel()
        view.text = "더 간결한 단어를 사용해 보세요"
        view.font = UIFont(name: "NotoSansKR-Regular", size: 12)
        view.numberOfLines = 0
        view.textColor = .beTextInfo
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var tip2Label: UILabel = {
        let view = UILabel()
        view.text = "단어마다 띄어쓰기를 사용해 보세요"
        view.font = UIFont(name: "NotoSansKR-Regular", size: 12)
        view.numberOfLines = 0
        view.textColor = .beTextInfo
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var tip3Label: UILabel = {
        let view = UILabel()
        view.text = "검색어의 맞춤법을 확인해 보세요"
        view.font = UIFont(name: "NotoSansKR-Regular", size: 12)
        view.numberOfLines = 0
        view.textColor = .beTextInfo
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var divider: UIView = {
        let view = UIView()
        view.backgroundColor = .beBgSub
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var recommendTitleLabel: UILabel = {
        let view = UILabel()
        //수정 예정
        view.text = "앤님이 좋아할 챌린지를 추천드려요! 🙌"
        view.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        view.numberOfLines = 0
        view.textColor = .beTextSub
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var recommendCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(RecommendCollectionViewCell.self, forCellWithReuseIdentifier: RecommendCollectionViewCell.identifier)
        return collectionView
    }()
    
    
    //MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        request()
        challengeRecommend()
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { // 1초 딜레이
            self.changeVC()
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
    
    func changeVC() {
        if feedList.isEmpty {
            // 기존 뷰 제거
            for subview in self.view.subviews {
                subview.removeFromSuperview()
            }
            // 새로운 뷰 추가
            self.view.addSubview(fullScrollView)
            self.fullScrollView.addSubview(changedContentView)
            setupNewUI()
            setupNewLayout()
        }
        else{
            print("FeedList is not empty")
            for subview in self.view.subviews {
                subview.removeFromSuperview()
            }
            self.setupUI()
            self.setupLayout()
        }
    }
    
    private func setupNewUI() {
        changedContentView.addSubview(noResultLabel)
        changedContentView.addSubview(noResultSmallLabel)
        changedContentView.addSubview(noResultImage)
        changedContentView.addSubview(tipTitleLabel)
        changedContentView.addSubview(tip1Label)
        changedContentView.addSubview(tip2Label)
        changedContentView.addSubview(tip3Label)
        changedContentView.addSubview(divider)
        changedContentView.addSubview(recommendTitleLabel)
        changedContentView.addSubview(recommendCollectionView)
    }
    
    private func setupNewLayout() {
        fullScrollView.snp.makeConstraints{ make in
            make.top.leading.equalToSuperview()
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
        
        changedContentView.snp.makeConstraints{ make in
            make.edges.equalTo(fullScrollView.contentLayoutGuide)
            make.height.equalTo(1000)
            make.width.equalTo(fullScrollView.frameLayoutGuide)
        }
        
        noResultLabel.snp.makeConstraints{make in
            make.top.equalToSuperview().offset(72)
            make.leading.equalToSuperview().offset(16)
        }
        
        noResultSmallLabel.snp.makeConstraints{make in
            make.top.equalTo(noResultLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(16)
        }
        
        noResultImage.snp.makeConstraints{make in
            make.centerX.equalToSuperview()
            make.top.equalTo(noResultSmallLabel.snp.bottom).offset(68)
            make.height.equalTo(128)
            make.width.equalTo(104)
        }
        
        tip2Label.snp.makeConstraints{make in
            make.top.equalTo(noResultImage.snp.bottom).offset(108)
            make.centerX.equalToSuperview()
        }
        
        tip1Label.snp.makeConstraints{make in
            make.bottom.equalTo(tip2Label.snp.top).offset(-4)
            make.leading.equalTo(tip2Label.snp.leading)
        }
        
        tipTitleLabel.snp.makeConstraints{make in
            make.bottom.equalTo(tip1Label.snp.top).offset(-8)
            make.leading.equalTo(tip2Label.snp.leading)
        }
        
        tip3Label.snp.makeConstraints{make in
            make.top.equalTo(tip2Label.snp.bottom).offset(4)
            make.leading.equalTo(tip2Label.snp.leading)
        }
        
        divider.snp.makeConstraints{make in
            make.top.equalTo(tip3Label.snp.bottom).offset(56)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(8)
        }
        
        recommendTitleLabel.snp.makeConstraints{make in
            make.top.equalTo(divider.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
        }
        
        let collectionViewHeight = challengeRecommendData.count * 90 + (challengeRecommendData.count - 1) * 12 + 30
        
        recommendCollectionView.snp.makeConstraints{ make in
            make.top.equalTo(recommendTitleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
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
        if collectionView == feedCollectionView {
            return feedList.count
        }
        else if collectionView == recommendCollectionView {
            return challengeRecommendData.count
        }
        return 0
    }
    
    // 셀 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == feedCollectionView {
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
        else if collectionView == recommendCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendCollectionViewCell.identifier, for: indexPath) as?
            RecommendCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.recommendChallengeId = challengeRecommendData[indexPath.row].challengeId
            
            let url = URL(string: challengeRecommendData[indexPath.row].imageUrl!)
            cell.recommendImageView.kf.setImage(with: url)
            let category = CategoryConverter.shared.convertToKorean(challengeRecommendData[indexPath.row].category)
            cell.categoryLabel.text = category
            cell.titleLabel.text = challengeRecommendData[indexPath.row].title
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    // 셀 크기 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let recommendWidth = UIScreen.main.bounds.width - 48
        
        if collectionView == feedCollectionView {
            let width = (UIScreen.main.bounds.width)/2 - 16 - 6
            return CGSize(width: width , height: 140)
        }
        else if collectionView == recommendCollectionView {
            return CGSize(width: recommendWidth, height: 90)
        }
        return CGSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == feedCollectionView {
            print("feedcollectionviewseleected")
            //let challengeId = feedList[indexPath.row].feedId
            
        }
        else if collectionView == recommendCollectionView {
            let cell = collectionView.cellForItem(at: indexPath) as! RecommendCollectionViewCell
            let challengeId = cell.recommendChallengeId
            var isEnrolled = false
            
            ChallengeService.shared.challengeEnrolled(EnrollChallengeId: challengeId ?? 0) { response in
                isEnrolled = response.data.isEnrolled
            }
            
            if isEnrolled {
                let nextVC = JoinChallengeViewController()
                nextVC.joinChallengeId = challengeId
                navigationController?.pushViewController(nextVC, animated: true)
            } else {
                let nextVC = ChallengeDetailViewController()
                nextVC.detailChallengeId = challengeId
                navigationController?.pushViewController(nextVC, animated: true)
            }
        }
    }
}

extension SearchFeedViewController {
    func request() {
        let searchText = SearchGlobalData.shared.searchText
        SearchService.shared.SearchResult(name: "\(searchText ?? "")") { response in
            self.setChallenge(response.data.feeds)
        }
        noResultLabel.text = "'\(searchText ?? "")' 검색 결과가 없습니다"
    }
    
    @MainActor
    func setChallenge(_ response: [Feed]) {
        self.feedList = response
        self.feedCollectionView.reloadData()
        
    }
    
    // 추천 챌린지 2개 정보 가져오는 함수
    func challengeRecommend() {
        ChallengeService.shared.challengeRecommend() { response in
            self.setRecommendData(response.data!.recommendChallengeDTOList)
        }
    }
    @MainActor
    private func setRecommendData(_ response: [ChallengeRecommendsData]) {
        self.challengeRecommendData = response
        self.recommendCollectionView.reloadData()
    }
}

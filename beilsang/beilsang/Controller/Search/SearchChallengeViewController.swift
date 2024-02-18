//
//  SearchChallengeViewController.swift
//  beilsang
//
//  Created by Seyoung on 2/18/24.
//

import UIKit
import UIKit
import SnapKit
import Kingfisher

class SearchChallengeViewController: UIViewController, UIScrollViewDelegate {
    
    //MARK: - Properties
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    var challengeList : [Challenge] = []
    
    lazy var fullScrollView: UIScrollView = {
            let scrollView = UIScrollView()
            scrollView.delegate = self
            return scrollView
        }()
    
    lazy var fullContentView: UIView = {
            let view = UIView()
            return view
        }()
    
    lazy var tipView : UIView = {
        let view = UIView()
        view.backgroundColor = .beBgCard
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.beBorderDis.cgColor
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tipViewTapped))
        view.addGestureRecognizer(tapGesture)
        
        return view
    }()
    
    lazy var tipLabel: UILabel = {
        let view = UILabel()
        view.text = "플로깅 챌린지는 \n 이렇게 진행돼요"
        view.font = UIFont(name: "NotoSansKR-SemiBold", size: 14)
        view.numberOfLines = 0
        view.textColor = .beTextDef
        view.textAlignment = .center
        
        return view
    }()
    
    lazy var tipImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "ploggingtip")
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        
        return view
    }()
    
    lazy var challengeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    
    //MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupUI()
        setupLayout()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        challengeCollectionView.isScrollEnabled = false
        self.challengeCollectionView.delegate = self
        self.challengeCollectionView.dataSource = self
        self.challengeCollectionView.register(ChallengeListCollectionViewCell.self, forCellWithReuseIdentifier: ChallengeListCollectionViewCell.identifier)
        
        view.addSubview(fullScrollView)
        
        fullScrollView.addSubview(fullContentView)
        
        fullContentView.addSubview(tipView)
        fullContentView.addSubview(challengeCollectionView)
        
        tipView.addSubview(tipLabel)
        tipView.addSubview(tipImage)
        
        
    }
    
    private func setupLayout() {
        
        let collectionViewHeight = challengeList.count * 140 + challengeList.count * 8 + 30
        let tipViewHeight = 100
        let contentHeight = collectionViewHeight + tipViewHeight + 8 + 64
        
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
        
        tipView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(64)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(width - 32)
            make.height.equalTo(tipViewHeight)
        }
        
        tipLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(16)
        }
        
        tipImage.snp.makeConstraints{ make in
            make.bottom.equalToSuperview().offset(-12)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        challengeCollectionView.snp.makeConstraints { make in
            make.top.equalTo(tipView.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.width.equalTo(width)
            make.height.equalTo(collectionViewHeight)
        }
        
        
    }
    
    //MARK: - Actions
    
    @objc func tipViewTapped(_ sender: UIButton) {
        print("tipViewTapped")
    }
    
    
}

// MARK: - collectionView setting(챌린지 리스트)
extension SearchChallengeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // 셀 개수 설정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return challengeList.count
    }
    
    // 셀 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChallengeListCollectionViewCell.identifier, for: indexPath) as?
                ChallengeListCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let target = challengeList[indexPath.row]
    
        cell.challengeNameLabel.text = target.title
        if let url = URL(string: target.imageUrl) {
            cell.challengeImage.kf.setImage(with: url)
        }
        cell.challengId = target.challengeId
        cell.makerNickname.text = target.hostName
        cell.buttonLabel.text = "참여인원 \(target.attendeeCount)명"
        
        cell.backgroundColor = .beBgDef
        
        return cell
    }
    
    // 셀 크기 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - 32
        
        return CGSize(width: width , height: 140)
    }
}

extension SearchChallengeViewController {
    func request() {
        SearchService.shared.SearchResult(name: "검색 ㅋ ") { response in
            self.setChallenge(response.data.challenges)
        }
    }
    
    @MainActor
    func setChallenge(_ response: [Challenge]) {
        self.challengeList = response
        self.challengeCollectionView.reloadData()
    }
}

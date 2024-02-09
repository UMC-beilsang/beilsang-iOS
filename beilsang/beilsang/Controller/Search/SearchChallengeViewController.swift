//
//  SearchChallengeViewController.swift
//  beilsang
//
//  Created by Seyoung on 2/8/24.
//

import UIKit
import SnapKit

class SearchChallengeViewController: UIViewController {
    
    //MARK: - Properties
    
    let dataList = SearchCallenge.data
    var dataCount = 8
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    let fullContentView  = UIView()
    
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
        
        view.backgroundColor = .white
        view.addSubview(fullContentView)
        
        fullContentView.addSubview(tipView)
        fullContentView.addSubview(challengeCollectionView)
        
        tipView.addSubview(tipLabel)
        tipView.addSubview(tipImage)
        
        
    }
    
    private func setupLayout() {
        
        let collectionViewHeight = dataCount * 140 + dataCount * 8 + 30
        let tipViewHeight: CGFloat = 100
        let contentHeight = CGFloat(collectionViewHeight) + tipViewHeight + 8 + 120 // 8은 간격, 64는 top safe area
    
        
        fullContentView.snp.makeConstraints{ make in
            make.top.leading.equalToSuperview()
            make.width.equalTo(width)
            make.height.equalTo(contentHeight)
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
            make.leading.equalToSuperview()
            make.width.equalTo(width)
            make.height.equalTo(collectionViewHeight)
            //make.height.equalTo(1500)
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
        return dataCount
    }
    
    // 셀 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChallengeListCollectionViewCell.identifier, for: indexPath) as?
                ChallengeListCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        //let target = dataList[indexPath.row]
        
        //cell.challengeNameLabel.text = target.title
       // cell.challengeImage.image = UIImage(named: target.image)
       // cell.makerNickname.text = target.nickName
        //cell.numOfPeople = target.numJoin
        
        cell.backgroundColor = .beBgDef
        
        return cell
    }
    
    // 셀 크기 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - 32
        
        return CGSize(width: width , height: 140)
    }
}


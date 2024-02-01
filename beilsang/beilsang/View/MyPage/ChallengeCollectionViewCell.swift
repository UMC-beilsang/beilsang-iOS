//
//  ChallengeCollectionViewCell.swift
//  beilsang
//
//  Created by 강희진 on 1/29/24.
//

import UIKit

class ChallengeCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "challengeCollectionViewCell"
    var delegate: CustomChallengeCellDelegate?
    // 달성 메달 셀 전체 뷰
    lazy var challengeView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    // 달성 메달 텍스트 레이블
    lazy var challengeLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        view.text = "참여 챌린지"
        view.numberOfLines = 0
        view.textColor = .black
        view.textAlignment = .center
        
        return view
    }()
    
    lazy var challengeCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
            
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        return view
    }()
    
    
    //사용자가 선택한 셀에 따라 POST
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setCollectionView()
        delegate?.setContentHeight(count: 5)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setLayout()
        setCollectionView()
        delegate?.setContentHeight(count: 5)
    }
}

// MARK: - layout setting
extension ChallengeCollectionViewCell {
    func setLayout() {
        self.addSubview(challengeView)
        [challengeLabel, challengeCollectionView].forEach { view in
            challengeView.addSubview(view)
        }
        challengeView.snp.makeConstraints { make in
            make.size.equalToSuperview()
            make.edges.equalToSuperview()
        }
        challengeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(28)
            make.leading.equalToSuperview()
        }
        challengeCollectionView.snp.makeConstraints { make in
            make.top.equalTo(challengeLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview()
            make.size.equalToSuperview()
        }
    }
}
// MARK: - collectionView setting(챌린지 리스트)
extension ChallengeCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // 콜렉션뷰 세팅
    func setCollectionView() {
        challengeCollectionView.delegate = self
        challengeCollectionView.dataSource = self
        challengeCollectionView.register(ChallengeListCollectionViewCell.self, forCellWithReuseIdentifier: ChallengeListCollectionViewCell.identifier)
    }
    
    // 셀 개수 설정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    // 셀 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChallengeListCollectionViewCell.identifier, for: indexPath) as?
                ChallengeListCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
    
    // 셀 크기 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - 32
        
        return CGSize(width: width , height: 140)
    }
}
protocol CustomChallengeCellDelegate: AnyObject {
    func setContentHeight(count: Int)
}

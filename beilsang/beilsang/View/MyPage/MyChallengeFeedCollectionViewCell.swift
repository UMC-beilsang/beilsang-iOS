//
//  MyChallengeFeedCollectionView.swift
//  beilsang
//
//  Created by 강희진 on 1/22/24.
//

import UIKit
class MyChallengeFeedCollectionViewCell: UICollectionViewCell{
    
    static let identifier = "myChallengeFeedCollectionViewCell"
    var feedId : Int? = nil
    
    lazy var challengeFeed: UIImageView = {
        let feed = UIImageView()
        feed.image = UIImage(named: "Mask group")
        feed.layer.borderWidth = 1
        feed.layer.borderColor = UIColor.beBorderDis.cgColor
        feed.layer.cornerRadius = 10
        feed.backgroundColor = .white
        feed.contentMode = .scaleAspectFill
        feed.clipsToBounds = true
        return feed
    }()
    override init(frame: CGRect){
        super.init(frame: frame)
        setupAttribute()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAttribute() {
        self.addSubview(challengeFeed)
    }
    private func setConstraint() {
        challengeFeed.translatesAutoresizingMaskIntoConstraints = false
        challengeFeed.snp.makeConstraints({ make in
            make.size.edges.equalToSuperview()
        })
    }
}

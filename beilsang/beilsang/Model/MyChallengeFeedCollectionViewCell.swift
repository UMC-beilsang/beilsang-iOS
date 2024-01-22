//
//  MyChallengeFeedCollectionView.swift
//  beilsang
//
//  Created by 강희진 on 1/22/24.
//

import UIKit
class MyChallengeFeedCollectionViewCell: UICollectionViewCell{
    
    static let identifier = "MyChallengeFeedVC"
    
    lazy var challengeFeed: UIButton = {
        let feedButton = UIButton()
        feedButton.setImage(UIImage(named: "Mask group"), for: .normal)
        feedButton.layer.borderWidth = 1
        feedButton.layer.cornerRadius = 10
        feedButton.backgroundColor = .red
        return feedButton
    }()
    
}

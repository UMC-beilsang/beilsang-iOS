//
//  JoinCollectionViewCell.swift
//  beilsang
//
//  Created by Seyoung on 1/20/24.
//

import UIKit
import SnapKit

class JoinCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "joinViewCell"
    
    let keywordImage = UIImageView()
    
    lazy var keywordView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.99, green: 0.99, blue: 0.99, alpha: 1)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).cgColor
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    lazy var keywordLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "NotoSansKR-Medium", size: 12)
        view.numberOfLines = 0
        view.textColor = UIColor(red: 0.27, green: 0.27, blue: 0.27, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    override var isSelected: Bool {
            didSet{
                if isSelected {
                    keywordView.backgroundColor = UIColor(red: 0.66, green: 0.71, blue: 1, alpha: 0.3)
                    keywordView.layer.borderColor = UIColor(red: 0.75, green: 0.78, blue: 1, alpha: 1).cgColor
                    
                }
                else {
                    keywordView.backgroundColor = .clear
                    keywordView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).cgColor
                }
            }
        }
    
    //사용자가 선택한 셀에 따라 POST
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setKeywordLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setKeywordLayout()
    }
}

extension JoinCollectionViewCell {
    func setKeywordLayout() {
        addSubview(keywordView)
        keywordView.addSubview(keywordImage)
        keywordView.addSubview(keywordLabel)
        
        keywordView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
        
        keywordImage.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(17)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(56)
        }
        
        keywordLabel.snp.makeConstraints{ make in
            make.top.equalTo(keywordImage.snp.bottom).offset(7)
            make.centerX.equalToSuperview()
        }
    }
}

//
//  RecommendCollectionViewCell.swift
//  beilsang
//
//  Created by Seyoung on 2/7/24.
//

import UIKit
import SnapKit

class RecommendCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "recommendCell"
    
    lazy var recommendCellView: UIView = {
        let view = UIView()
        view.backgroundColor = .beBgSub
        view.layer.cornerRadius = 12
        
        return view
    }()
    
    lazy var recommendImageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.beBorderDis.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    lazy var categoryLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        view.numberOfLines = 0
        view.textColor = .beTextSub
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "NotoSansKR-Medium", size: 18)
        view.numberOfLines = 0
        view.textColor = .beTextDef
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setRecommendLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setRecommendLayout()
    }
}

extension RecommendCollectionViewCell {
    func setRecommendLayout() {
        addSubview(recommendCellView)
        recommendCellView.addSubview(recommendImageView)
        recommendCellView.addSubview(categoryLabel)
        recommendCellView.addSubview(titleLabel)
        recommendCellView.addSubview(categoryLabel)
        
        recommendCellView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
        
        recommendImageView.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.width.height.equalTo(70)
        }
        
        categoryLabel.snp.makeConstraints{ make in
            make.leading.equalTo(recommendImageView.snp.trailing).offset(16)
            make.top.equalTo(recommendImageView.snp.top).offset(10)
        }
        
        titleLabel.snp.makeConstraints{ make in
            make.leading.equalTo(recommendImageView.snp.trailing).offset(16)
            make.bottom.equalTo(recommendImageView.snp.bottom).offset(-10)
        }
    }
}

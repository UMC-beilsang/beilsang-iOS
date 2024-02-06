//
//  CautionCollectionViewCell.swift
//  beilsang
//
//  Created by Seyoung on 2/7/24.
//

import UIKit
import SnapKit

class CautionCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "cautionCell"
    
    lazy var cautionCellView: UIView = {
        let view = UIView()
        view.backgroundColor = .beBgSub
        
        return view
    }()
    
    lazy var cautionIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "cautionTrue")
        
        return view
    }()

    lazy var cautionLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "NotoSansKR-Medium", size: 12)
        view.numberOfLines = 0
        view.textColor = .beTextDef
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCautionLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setCautionLayout()
    }
}

extension CautionCollectionViewCell {
    func setCautionLayout() {
        addSubview(cautionCellView)
        cautionCellView.addSubview(cautionIcon)
        cautionCellView.addSubview(cautionLabel)
        
        cautionCellView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
        
        cautionIcon.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.height.equalTo(18)
        }
        
        cautionLabel.snp.makeConstraints{ make in
            make.leading.equalTo(cautionIcon.snp.trailing).offset(4)
            make.centerY.equalToSuperview()
        }
    }
}

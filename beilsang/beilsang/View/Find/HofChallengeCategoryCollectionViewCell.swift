//
//  ChallengeCategoryCollectionViewCell.swift
//  beilsang
//
//  Created by 강희진 on 2/4/24.
//

import UIKit

// 발견 - 명예의 전당 챌린지 모음집 카테고리
class HofChallengeCategoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "hofChallengeCategoryCollectionViewCell"
    // 달성 메달 셀 전체 뷰
    lazy var categoryLabel: UILabel = {
        let view = UILabel()
        view.backgroundColor = .white
        view.textColor = .black
        view.layer.cornerRadius = 14
        view.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        view.textAlignment = .center
        view.layer.borderColor = UIColor.bePrPurple500.cgColor
        view.layer.borderWidth = 1
        view.clipsToBounds = true
        return view
    }()
    
    //사용자가 선택한 셀에 따라 POST
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setLayout()
    }
    override var isSelected: Bool {
        didSet{
            if isSelected {
                categoryLabel.textColor = .white
                categoryLabel.backgroundColor = .beScPurple600
            }
            else {
                categoryLabel.textColor = .black
                categoryLabel.backgroundColor = .white
            }
        }
    }
}

// MARK: - layout setting
extension HofChallengeCategoryCollectionViewCell {
    func setLayout() {
        self.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints { make in
            make.size.equalToSuperview()
            make.edges.equalToSuperview()
        }
    }
}

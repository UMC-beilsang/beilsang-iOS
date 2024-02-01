//
//  MyPageCategoryCollectionViewCell.swift
//  beilsang
//
//  Created by 강희진 on 1/28/24.
//

import UIKit

// CategoryCollectionViewCell과 다른점 : 폰트, didSet 부분(선택할 때 색상 변경)
class MyPageCategoryCollectionViewCell: UICollectionViewCell {
        
    static let identifier = "categoryViewCell"
    
    // 카테고리 셀 전체 뷰
    lazy var keywordView: UIView = {
        let view = UIView()
        view.backgroundColor = .beBgSub
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    // 카테고리 이미지
    let keywordImage = UIImageView()
    
    // 카테고리 텍스트 레이블
    lazy var keywordLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "NotoSansKR-Regular", size: 11)
        view.numberOfLines = 0
        view.textColor = .beTextInfo
        view.textAlignment = .center
        
        return view
    }()
    
    //사용자가 선택한 셀에 따라 POST
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setKeywordLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setKeywordLayout()
    }
    
    override var isSelected: Bool {
            didSet{
                if isSelected {
                    keywordView.backgroundColor = .bePrPurple30Per.withAlphaComponent(0.3)
                }
                else {
                    keywordView.backgroundColor = .beBgSub
                }
            }
        }
}

// MARK: - layout setting
extension MyPageCategoryCollectionViewCell {
    func setKeywordLayout() {
        addSubview(keywordView)
        keywordView.addSubview(keywordImage)
        keywordView.addSubview(keywordLabel)
        
        keywordView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
        
        keywordImage.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(36)
        }
        
        keywordLabel.snp.makeConstraints{ make in
            make.top.equalTo(keywordImage.snp.bottom).offset(6)
            make.centerX.equalToSuperview()
        }
    }
}

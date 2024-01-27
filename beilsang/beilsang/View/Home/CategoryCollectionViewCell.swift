//
//  CategoryCollectionViewCell.swift
//  beilsang
//
//  Created by 곽은채 on 1/26/24.
//

import SnapKit
import UIKit

// [홈] 메인화면
// 카테고리 뷰 셀
class CategoryCollectionViewCell: UICollectionViewCell {
    
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
        view.font = UIFont(name: "NotoSansKR-Medium", size: 12)
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
}

// MARK: - layout setting
extension CategoryCollectionViewCell {
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

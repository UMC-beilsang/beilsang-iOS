//
//  ChallengeMenuCollectionViewCell.swift
//  beilsang
//
//  Created by 강희진 on 1/28/24.
//

import UIKit

class ChallengeMenuCollectionViewCell: UICollectionViewCell {
    static let identifier = "ChallengeMenuCollectionVC"
    
    // 메뉴 셀 전체 뷰
    lazy var menuView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    // 메뉴 텍스트 레이블
    lazy var menuLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        view.numberOfLines = 0
        view.textColor = .beTextSub
        view.textAlignment = .center
        
        return view
    }()
    
    // 메뉴 하단 바
    lazy var menuBar: UIView = {
        let view = UIView()
        view.backgroundColor = .beBorderAct
        view.isHidden = true
        return view
    }()
    
    //사용자가 선택한 셀에 따라 POST
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setMenuLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setMenuLayout()
    }
}

// MARK: - layout setting
extension ChallengeMenuCollectionViewCell {
    func setMenuLayout() {
        setupAttribute()
        menuView.translatesAutoresizingMaskIntoConstraints = false
        menuView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
        
        menuLabel.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        menuBar.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(6)
            make.centerX.equalToSuperview()
            make.top.equalTo(menuLabel.snp.bottom).offset(6)
        }
    }
    private func setupAttribute() {
        self.addSubview(menuView)
        [menuLabel, menuBar].forEach { view in
            menuView.addSubview(view)
        }
    }
}

// MARK: - function
extension ChallengeMenuCollectionViewCell{
    // cell이 선택되었을 때, label의 폰트가 두꺼워지고, 하단의 bar가 보여진다.
    override var isSelected: Bool {
      didSet {
        if isSelected {
            menuLabel.font = UIFont(name: "NotoSansKR-Medium", size: 16)
            menuBar.isHidden = false
        } else {
            menuLabel.font = UIFont(name: "NotoSansKR-Regular", size: 16)
            menuBar.isHidden = true
        }
      }
    }
}

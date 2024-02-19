//
//  RecentSearchCollectionViewCell.swift
//  beilsang
//
//  Created by Seyoung on 2/18/24.
//

import UIKit
import SnapKit

class RecentSearchCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    static let identifier = "RecentSearchViewCell"
    
    var deleteHandler: (() -> Void)?
    
    lazy var searchTermView : UIView = {
        let view = UIView()
        view.backgroundColor = .beBgSub
        view.layer.cornerRadius = 14
        view.clipsToBounds = true
        
        return view
    }()
    
    lazy var termLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        view.numberOfLines = 0
        view.textColor = .beTextDef
        view.textAlignment = .center
        
        return view
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "xicongray"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchDown)
        
        return button
    }()
    
    
    
    //MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI setup
    
    private func setUI() {
        addSubview(searchTermView)
        searchTermView.addSubview(termLabel)
        searchTermView.addSubview(deleteButton)
        
        searchTermView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        termLabel.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }
        
        deleteButton.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    //MARK: - Actions
    
    @objc func deleteButtonTapped(_ sender: UIButton) {
        deleteHandler?()
    }
}

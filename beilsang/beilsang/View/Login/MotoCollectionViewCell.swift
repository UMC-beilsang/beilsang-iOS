//
//  MotoCollectionViewCell.swift
//  beilsang
//
//  Created by Seyoung on 1/22/24.
//

import UIKit
import SnapKit

class MotoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MotoViewCell"
    
    lazy var motoImage: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "NotoSansKR-Medium", size: 18)
        view.numberOfLines = 0
        view.textColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var motoView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).cgColor
        view.layer.cornerRadius = 10
        
        return view
    }()

    lazy var motoLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "NotoSansKR-Medium", size: 18)
        view.numberOfLines = 0
        view.textColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var checkImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Check")
        view.sizeToFit()
        view.isHidden = true
        
        return view
    }()
    
    override var isSelected: Bool {
            didSet{
                if isSelected {
                    motoView.backgroundColor = UIColor(red: 0.66, green: 0.71, blue: 1, alpha: 0.3)
                    motoView.layer.borderColor = UIColor(red: 0.75, green: 0.78, blue: 1, alpha: 1).cgColor
                    checkImage.isHidden = false
                    
                }
                else {
                    motoView.backgroundColor = .clear
                    motoView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).cgColor
                    checkImage.isHidden = true
                }
            }
        }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setMotoLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setMotoLayout()
    }
}

extension MotoCollectionViewCell {
    func setMotoLayout() {
        addSubview(motoView)
        motoView.addSubview(motoImage)
        motoView.addSubview(motoLabel)
        motoView.addSubview(checkImage)
        
        motoView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()}
        
        motoImage.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            
        }
        
        motoLabel.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(motoImage.snp.trailing).offset(8)
            
        }
        
        checkImage.snp.makeConstraints{ make in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
            make.height.equalTo(13)
            make.width.equalTo(18)
        }
    }
}



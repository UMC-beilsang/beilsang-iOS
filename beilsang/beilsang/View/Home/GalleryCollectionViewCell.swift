//
//  GalleryCollectionViewCell.swift
//  beilsang
//
//  Created by Seyoung on 2/7/24.
//

import UIKit
import SnapKit

class GalleryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "galleryCell"
    var FeedId : Int?
    
    lazy var galleryImage: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.beBorderDis.cgColor
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(galleryImage)
        galleryImage.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        addSubview(galleryImage)
        galleryImage.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    
    }
    
}

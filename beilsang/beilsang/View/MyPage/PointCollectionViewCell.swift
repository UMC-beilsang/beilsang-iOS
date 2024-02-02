//
//  PointCollectionViewCell.swift
//  beilsang
//
//  Created by 강희진 on 2/1/24.
//

import UIKit

class PointCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "pointCollectionViewCell"
    
    lazy var pointView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.beBgDiv.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 10
        return view
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NotoSansKR-Medium", size: 12)
        label.textColor = .beIconDef
        label.text = "2023. 01. 08"
        return label
    }()
    
    lazy var pointImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Group 1000002645")
        return view
    }()
    
    lazy var pointLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NotoSansKR-Medium", size: 18)
        label.textColor = .beTextInfo
        label.text = "+500P"
        return label
    }()
    
    lazy var pointContent: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NotoSansKR-Medium", size: 12)
        label.textColor = .beTextSub
        label.text = "다회용기 사용하자 챌린지 참여 포인트"
        return label
    }()
    lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NotoSansKR-Medium", size: 12)
        label.textColor = .beTextInfo
        label.text = "사용"
        return label
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
}
// MARK: - layout setting
extension PointCollectionViewCell {
    func setLayout() {
        self.addSubview(pointView)
        [dateLabel, pointImage, pointLabel, pointContent, typeLabel].forEach { view in
            pointView.addSubview(view)
        }
        pointView.snp.makeConstraints { make in
            make.size.equalToSuperview()
            make.edges.equalToSuperview()
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(12)
        }
        pointImage.snp.makeConstraints { make in
            make.width.height.equalTo(35)
            make.top.equalTo(dateLabel.snp.bottom).offset(8)
            make.leading.equalTo(dateLabel)
        }
        pointLabel.snp.makeConstraints { make in
            make.centerY.equalTo(pointImage)
            make.leading.equalTo(pointImage.snp.trailing).offset(24)
        }
        pointContent.snp.makeConstraints { make in
            make.top.equalTo(pointLabel.snp.bottom).offset(4)
            make.leading.equalTo(pointLabel.snp.leading)
        }
        typeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(54)
            make.trailing.equalToSuperview().offset(-14)
        }
    }
}

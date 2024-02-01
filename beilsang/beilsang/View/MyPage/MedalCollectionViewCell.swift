//
//  MedalCollectionViewCell.swift
//  beilsang
//
//  Created by 강희진 on 1/28/24.
//

import UIKit
import SwiftUI

class MedalCollectionViewCell: UICollectionViewCell {

    static let identifier = "medalCollectionViewCell"
    var delegate: CustomMedalCellDelegate?
    
    // 달성 메달 셀 전체 뷰
    lazy var medalView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.isHidden = true
        return view
    }()
    
    // 달성 메달 텍스트 레이블
    lazy var medalLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        view.text = "달성 메달"
        view.numberOfLines = 0
        view.textColor = .black
        view.textAlignment = .center
        
        return view
    }()
    // 달성 메달 background 사각형
    lazy var medalBox: UIView = {
        let view = UIView()
        view.backgroundColor = .beBgSub
        view.layer.cornerRadius = 10
        return view
    }()
            
    // 달성 메달 이미지(총 5개)
    lazy var medal1: UIButton = {
        let button = UIButton()
        button.setTitle("10", for: .normal)
        button.setTitleColor(.clear, for: .normal)
        button.setImage(UIImage(named: "Group 1000002757"), for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    lazy var medal2: UIButton = {
        let button = UIButton()
        button.setTitle("20", for: .normal)
        button.setTitleColor(.clear, for: .normal)
        button.setImage(UIImage(named: "Ellipse 1674"), for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    lazy var medal3: UIButton = {
        let button = UIButton()
        button.setTitle("30", for: .normal)
        button.setTitleColor(.clear, for: .normal)
        button.setImage(UIImage(named: "Ellipse 1674"), for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    lazy var medal4: UIButton = {
        let button = UIButton()
        button.setTitle("40", for: .normal)
        button.setTitleColor(.clear, for: .normal)
        button.setImage(UIImage(named: "Ellipse 1674"), for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    lazy var medal5: UIButton = {
        let button = UIButton()
        button.setTitle("50", for: .normal)
        button.setTitleColor(.clear, for: .normal)
        button.setImage(UIImage(named: "Ellipse 1674"), for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
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
extension MedalCollectionViewCell {
    func setLayout() {
        self.addSubview(medalView)
        
        [medalLabel, medalBox, medal1, medal2, medal3, medal4, medal5].forEach { view in
            medalView.addSubview(view)
        }
        
        medalView.snp.makeConstraints { make in
            make.size.equalToSuperview()
            make.edges.equalToSuperview()
        }
        medalLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(28)
            make.leading.equalToSuperview()
        }
        medalBox.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(85)
            make.leading.equalToSuperview()
            make.top.equalTo(medalLabel.snp.bottom).offset(12)
        }
        medal1.snp.makeConstraints { make in
            make.width.equalTo(60)
            make.height.equalTo(60)
            make.trailing.equalTo(medal2.snp.leading).offset(-8)
            make.centerY.equalTo(medalBox)
        }
        medal2.snp.makeConstraints { make in
            make.size.equalTo(medal1)
            make.trailing.equalTo(medal3.snp.leading).offset(-8)
            make.centerY.equalTo(medalBox)
        }
        medal3.snp.makeConstraints { make in
            make.size.equalTo(medal1)
            make.centerX.equalTo(medalBox)
            make.centerY.equalTo(medalBox)
        }
        medal4.snp.makeConstraints { make in
            make.size.equalTo(medal1)
            make.leading.equalTo(medal3.snp.trailing).offset(8)
            make.centerY.equalTo(medalBox)
        }
        medal5.snp.makeConstraints { make in
            make.size.equalTo(medal1)
            make.leading.equalTo(medal4.snp.trailing).offset(8)
            make.centerY.equalTo(medalBox)
        }
    }
}
// MARK: - function
extension MedalCollectionViewCell {
    @objc func buttonTapped(_ sender: UIButton) {
        if sender.isEnabled {
            delegate?.didTapButton(in: self, button: sender)
        }
    }
    
}
private struct FloatingView: View {
  var body: some View {
    HStack {
      Spacer()
      Text("This is Floating")
        .font(.headline)
        .padding(.vertical, 10)
      Spacer()
    }
    .background(Color.white)
    .cornerRadius(20)
    .padding(.horizontal, 20)
  }
}

protocol CustomMedalCellDelegate: AnyObject {
    func didTapButton(in cell: UICollectionViewCell, button: UIButton)
}

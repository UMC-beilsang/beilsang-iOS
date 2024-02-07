//
//  FindFeedDetailCollectionViewCell.swift
//  beilsang
//
//  Created by 강희진 on 2/5/24.
//

import UIKit
import SCLAlertView
import SafariServices

class FindFeedDetailCollectionViewCell: UICollectionViewCell,UIScrollViewDelegate {
    
    static let identifier = "findFeedDetailCollectionViewCell"
    var delegate: CustomFeedCellDelegate?
    var findDelegate: CustomFindCellDelegate?
    // 달성 메달 셀 전체 뷰
    let fullScrollView = UIScrollView()
    
    let fullContentView = UIView()
    
    lazy var feedImage : UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var profileImage: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 24
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 1
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowPath = nil
        view.image = UIImage(named: "Mask group")
        return view
    }()
    
    lazy var nicknameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        label.textColor = .black
        label.text = "춤추는 텀블러"
        
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font =  UIFont(name: "NotoSansKR-Medium", size: 12)
        label.text = "1일 전"
        label.textColor = .beTextSub
        return label
    }()
    
    lazy var heartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "iconamoon_heart-bold"), for: .normal)
        return button
    }()
    
    lazy var categoryTag: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NotoSansKR-Medium", size: 12)
        label.textColor = .beTextSub
        label.text = "#플로깅"
        return label
    }()
    lazy var titleTag: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NotoSansKR-Medium", size: 12)
        label.textColor = .beTextSub
        label.text = "#우리가치플로깅하자"
        return label
    }()
    
    lazy var reviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        label.text = "챌린지 후기"
        label.textColor = .beTextSub
        return label
    }()
    lazy var reviewBox: UIView = {
        let view = UIView()
        view.backgroundColor = .beBgSub
        view.layer.cornerRadius = 10
        return view
    }()
    lazy var reviewContent: UILabel = {
        let view = UILabel()
        view.textColor = .beTextDef
        view.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        view.numberOfLines = 5
        view.text = "플로깅을 하면서 즐거운 경험을 할 수 있었습니다! 친환경을 위해 앞장설 수 있어서 좋았어요!"
        return view
    }()
    lazy var closeButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "icon-close-circle"), for: .normal)
        view.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        return view
    }()
    
    lazy var line : UIView = {
        let view = UIView()
        view.backgroundColor = .beBgSub
        return view
    }()
    
    lazy var recommendLabel : UILabel = {
        let label = UILabel()
        label.text = "이런 챌린지는 어떠세요? 👀"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        label.textColor = .black
        return label
    }()
    lazy var recommendCellView: UIView = {
        let view = UIView()
        view.backgroundColor = .beBgSub
        view.layer.cornerRadius = 12
        
        return view
    }()
        
    lazy var recommendImageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.beBorderDis.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var categoryLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        view.numberOfLines = 0
        view.textColor = .beTextSub
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "NotoSansKR-Medium", size: 18)
        view.numberOfLines = 0
        view.textColor = .beTextDef
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var reportButton: UIButton = {
        let view = UIButton()
        view.setTitle("신고하기", for: .normal)
        view.titleLabel?.font = UIFont(name: "NotoSansKR-Regular", size: 11)
        view.setTitleColor(.beTextEx, for: .normal)
        view.addTarget(self, action: #selector(tapReportButton), for: .touchUpInside)
        return view
    }()
    
    //사용자가 선택한 셀에 따라 POST
    override init(frame: CGRect) {
        super.init(frame: frame)
        setScrollLayout()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setScrollLayout()
        setLayout()
    }
}

// MARK: - layout setting
extension FindFeedDetailCollectionViewCell {
    func setScrollLayout() {
        self.addSubview(fullScrollView)
        fullScrollView.delegate = self
        fullScrollView.addSubview(fullContentView)
        fullScrollView.showsVerticalScrollIndicator = false
        fullScrollView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        fullContentView.snp.makeConstraints { make in
            make.edges.equalTo(fullScrollView.contentLayoutGuide)
            make.width.equalTo(fullScrollView.frameLayoutGuide)
            make.height.equalTo(950)
        }
    }
    func setLayout() {
        [feedImage, profileImage, nicknameLabel, dateLabel, heartButton, categoryTag, titleTag, reviewLabel, reviewBox, reviewContent, closeButton, reportButton, line, recommendLabel, recommendCellView].forEach { view in
            fullContentView.addSubview(view)
        }
        [recommendImageView, categoryLabel, titleLabel].forEach { view in
            recommendCellView.addSubview(view)
        }
        
        feedImage.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(fullScrollView.snp.width)
            make.top.leading.equalToSuperview()
        }
        profileImage.snp.makeConstraints { make in
            make.width.height.equalTo(48)
            make.top.equalTo(feedImage.snp.bottom).offset(12)
            make.leading.equalTo(feedImage.snp.leading).offset(10)
        }
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.top).offset(2)
            make.leading.equalTo(profileImage.snp.trailing).offset(16)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(4)
            make.leading.equalTo(nicknameLabel)
        }
        heartButton.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.centerY.equalTo(profileImage)
            make.trailing.equalTo(feedImage.snp.trailing).offset(-10)
        }
        categoryTag.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(16)
            make.leading.equalTo(profileImage)
        }
        titleTag.snp.makeConstraints { make in
            make.top.equalTo(categoryTag)
            make.leading.equalTo(categoryTag.snp.trailing).offset(8)
        }
        reviewLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryTag.snp.bottom).offset(24)
            make.leading.equalToSuperview()
        }
        reviewBox.snp.makeConstraints { make in
            make.width.leading.trailing.equalToSuperview()
            make.top.equalTo(reviewLabel.snp.bottom).offset(12)
            make.height.equalTo(140)
        }
        reviewContent.snp.makeConstraints { make in
            make.top.equalTo(reviewBox.snp.top).offset(14)
            make.leading.equalTo(reviewBox.snp.leading).offset(19)
            make.trailing.equalTo(reviewBox.snp.trailing).offset(-19)
        }
        closeButton.snp.makeConstraints { make in
            make.width.height.equalTo(32)
            make.top.equalTo(feedImage.snp.top).offset(10)
            make.trailing.equalTo(feedImage.snp.trailing).offset(-10)
        }
        reportButton.snp.makeConstraints { make in
            make.top.equalTo(reviewBox.snp.bottom).offset(12)
            make.trailing.equalTo(reviewBox.snp.trailing)
        }
        line.snp.makeConstraints { make in
            make.top.equalTo(reviewBox.snp.bottom).offset(82)
            make.height.equalTo(8)
            make.leading.trailing.equalToSuperview()
        }
        recommendLabel.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).offset(28)
            make.leading.equalToSuperview().offset(8)
        }
        recommendCellView.snp.makeConstraints{ make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(recommendLabel.snp.bottom).offset(16)
            make.height.equalTo(90)
        }
        
        recommendImageView.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.width.height.equalTo(70)
        }
        
        categoryLabel.snp.makeConstraints{ make in
            make.leading.equalTo(recommendImageView.snp.trailing).offset(16)
            make.top.equalTo(recommendImageView.snp.top).offset(10)
        }
        
        titleLabel.snp.makeConstraints{ make in
            make.leading.equalTo(recommendImageView.snp.trailing).offset(16)
            make.bottom.equalTo(recommendImageView.snp.bottom).offset(-10)
        }
    }
}
// MARK: - function
extension FindFeedDetailCollectionViewCell {
    @objc func tapButton(_ sender: UIButton) {
        delegate?.didTapButton()
    }
    @objc func tapReportButton(_ sender: UIButton) {
        print("신고하기")
        findDelegate?.didTapReportButton()
    }
}
protocol CustomFindCellDelegate {
    func didTapReportButton()
}

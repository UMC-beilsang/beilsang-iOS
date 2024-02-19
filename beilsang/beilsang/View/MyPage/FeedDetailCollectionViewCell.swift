//
//  FeedDetailCollectionViewCell.swift
//  beilsang
//
//  Created by 강희진 on 2/2/24.
//

import UIKit

class FeedDetailCollectionViewCell: UICollectionViewCell,UIScrollViewDelegate {
    
    static let identifier = "feedDetailCollectionViewCell"
    var delegate: CustomFeedCellDelegate?
    var feedId: Int = 1
    
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
        view.contentMode = .scaleAspectFit
        //넘치는 영역 잘라내기
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var profileShadowView: UIView = {
        let view = UIView()
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        
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
        button.addTarget(self, action: #selector(likeButton), for: .touchUpInside)
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
extension FeedDetailCollectionViewCell {
    func setScrollLayout() {
        self.addSubview(fullScrollView)
        fullScrollView.delegate = self
        fullScrollView.addSubview(fullContentView)
        fullScrollView.showsVerticalScrollIndicator = false
        fullScrollView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        fullContentView.snp.makeConstraints { make in
            make.edges.width.equalToSuperview()
            make.height.equalTo(700)
        }
    }
    func setLayout() {
        [feedImage, profileShadowView, profileImage, nicknameLabel, dateLabel, heartButton, categoryTag, titleTag, reviewLabel, reviewBox, reviewContent, closeButton].forEach { view in
            fullContentView.addSubview(view)
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
        profileShadowView.snp.makeConstraints { make in
            make.edges.width.equalTo(profileImage)
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
    }
}
// MARK: - function
extension FeedDetailCollectionViewCell {
    @objc func tapButton(_ sender: UIButton) {
        delegate?.didTapButton()
    }
    
    @objc private func likeButton(_ sender: UIButton) {
        if sender.image(for: .normal) == UIImage(named: "iconamoon_heart-bold"){
            sender.setImage(UIImage(named: "iconamoon_fullheart-bold"), for: .normal)
            requestLikeButtonTapped()
        } else if sender.image(for: .normal) == UIImage(named: "iconamoon_fullheart-bold"){
            sender.setImage(UIImage(named: "iconamoon_heart-bold"), for: .normal)
            requestCancelLikeButtonTapped()
        }
    }
    //찜하기
    private func requestLikeButtonTapped() {
        MyPageService.shared.postLikeButton(baseEndPoint: .feeds, addPath: "/\(feedId)/likes", completionHandler: { response in
            print("post 요청 완료 - like button tapped")
        })
    }
    // 찜 취소
    private func requestCancelLikeButtonTapped() {
        MyPageService.shared.deleteLikeButton(baseEndPoint: .feeds, addPath: "/\(feedId)/likes", completionHandler: { response in
            print("delete 요청 완료 - cancel like button tapped")
        })
    }
}

protocol CustomFeedCellDelegate: AnyObject {
    func didTapButton()
    func didTapReportButton()
    func didTapRecommendButton(id: Int)
}

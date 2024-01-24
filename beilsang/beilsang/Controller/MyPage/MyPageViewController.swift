//
//  MyPageViewController.swift
//  beilsang
//
//  Created by 강희진 on 1/20/24.
//

import UIKit
import SnapKit


class MyPageViewController: UIViewController, UIScrollViewDelegate {
    // MARK: - Properties
    
    let fullScrollView = UIScrollView()
    let fullContentView = UIView()

    //상단부
    // 마이페이지 - "마이페이지" UILabel
    lazy var myPageTitle: UILabel = {
        let label = UILabel()
        label.text = "마이페이지"
        label.textColor = UIColor(.black)
        label.font = UIFont(name: "NotoSansKR-SemiBold", size: 22)
        
        return label
    }()
    
    // 마이페이지 - 최상단 바
    lazy var firstBar: UIView = {
        let view = UIView()
        return view
    }()
    
    // 알림 버튼
    lazy var notificationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "iconamoon_notification-bold"), for: .normal)
        button.tintColor = .white
        return button
    }()
    // 세팅 버튼
    lazy var settingBackground: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 14
        view.backgroundColor = UIColor(red: 0.66, green: 0.71, blue: 1, alpha: 1)
        return view
    }()
    lazy var settingButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon_settings"), for: .normal)
        return button
    }()
    
    lazy var rectangleBox: UIView = {
        let view = UIView()
        view.layer.backgroundColor = UIColor(red: 0.796, green: 0.831, blue: 1, alpha: 1).cgColor
        view.layer.cornerRadius = 8
        view.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMaxYCorner, .layerMaxXMaxYCorner)
        return view
    }()
    // "안녕하세요, 00님" Label
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        var name = "앤"
        label.text = "안녕하세요, " + name + "님"
        label.textColor = UIColor(.black)
        label.font = UIFont(name: "NotoSansKR-SemiBold", size: 18)
        return label
    }()
    
    lazy var profileImage: UIImageView = {
        let view =  UIImageView()
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        view.image = UIImage(named: "Mask group")
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 48
        
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
//        view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds,
//                               cornerRadius: view.layer.cornerRadius).cgPath
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var feed: UILabel = {
        let label = UILabel()
        label.text = "피드"
        label.textColor = UIColor(named: "feedLabel")
        label.font = UIFont(name: "NotoSansKR-Medium", size: 18)
        label.textAlignment = .center
        return label
    }()
    lazy var goal: UILabel = {
        let label = UILabel()
        label.text = "달성"
        label.textColor = UIColor(named: "feedLabel")
        label.font = UIFont(name: "NotoSansKR-Medium", size: 18)
        label.textAlignment = .center
        return label
    }()
    lazy var fail: UILabel = {
        let label = UILabel()
        label.text = "실패"
        label.textColor = UIColor(named: "feedLabel")
        label.font = UIFont(name: "NotoSansKR-Medium", size: 18)
        label.textAlignment = .center
        return label
    }()
    
    lazy var feedCount : UILabel = {
        let label = UILabel()
        label.text = "20"
        label.textColor = UIColor(.black)
        label.textAlignment = .center
        label.font = UIFont(name: "NotoSansKR-SemiBold", size: 20)
        return label
    }()
    lazy var goalCount : UILabel = {
        let label = UILabel()
        label.text = "18"
        label.textColor = UIColor(.black)
        label.textAlignment = .center
        label.font = UIFont(name: "NotoSansKR-SemiBold", size: 20)
        return label
    }()
    lazy var failCount : UILabel = {
        let label = UILabel()
        label.text = "13"
        label.textColor = UIColor(.black)
        label.textAlignment = .center
        label.font = UIFont(name: "NotoSansKR-SemiBold", size: 20)
        return label
    }()

    lazy var commentBox: UIView = {
        let view = UIView()
        view.layer.backgroundColor = UIColor(.white).cgColor
        view.layer.cornerRadius = 10
        return view
    }()
    // 중앙부
    lazy var comment: UILabel = {
        let label = UILabel()
        var comment = "일상생활 속 꾸준하게 실천하는"
        label.text = "🙌  " + comment
        label.textColor = UIColor(.black)
        label.font = UIFont(name: "NotoSansKR-Medium", size: 16)

        return label
    }()
    
    lazy var challengeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "나의 챌린지"
        label.textColor = UIColor(.black)
        label.font = UIFont(name: "NotoSansKR-SemiBold", size: 18)
        
        return label
    }()
    
    lazy var challengeBox: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor(named: "challengeBox")
        return view
    }()
    
    lazy var checkImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon-check")
        return view
    }()
    lazy var starImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon-star")
        return view
    }()
    lazy var pointImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon-point")
        return view
    }()
    
    lazy var checkLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(.black)
        label.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        label.text = "참여 중"
        return label
    }()
    lazy var starLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(.black)
        label.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        label.text = "찜"
        return label
    }()
    lazy var pointLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(.black)
        label.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        label.text = "포인트"
        return label
    }()
    lazy var checkCount: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        label.text = "6"
        return label
    }()
    lazy var starCount: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        label.text = "12"
        return label
    }()
    lazy var pointCount: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        label.text = "916"
        return label
    }()
    lazy var line1 : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "challengeLine")
        return view
    }()
    lazy var line2 : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "challengeLine")
        return view
    }()
    lazy var myChallengeUnderBar: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "challengeBox")
        return view
    }()
    lazy var checkButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        return button
    }()
    lazy var starButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        return button
    }()
    lazy var pointButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        return button
    }()
    // 하단부
    lazy var myChallengeFeedLabel: UILabel = {
        let label = UILabel()
        label.text = "나의 챌린지 피드"
        label.textColor = UIColor(.black)
        label.font = UIFont(name: "NotoSansKR-SemiBold", size: 18)
        return label
    }()
    lazy var showAllChallengeFeedView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 9
        view.backgroundColor = UIColor(named: "challengeBox")
        return view
    }()
    lazy var showAllChallengeFeedLabel: UILabel = {
        let label = UILabel()
        label.text = "전체 보기"
        label.textColor = UIColor(named: "showAllFeedLabel")
        label.font = UIFont(name: "NotoSansKR-Medium", size: 12)
        return label
    }()
    lazy var showAllChallengeFeedButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        return button
    }()
    lazy var myChallengeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView =  UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    
    // MARK: - Lifecycle
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            setupAttribute()
            viewConstraint()
            collectionviewSet()
        }

    }

extension MyPageViewController {
    
    func setupAttribute() {
        setFullScrollView()
        setLayout()
        setScrollViewLayout()
    }
    
    func setFullScrollView() {
        fullScrollView.showsVerticalScrollIndicator = true
        fullScrollView.delegate = self
        
    }

    func setLayout() {
        view.addSubview(fullScrollView)
        fullScrollView.addSubview(fullContentView)
        addView()
    }
    func setScrollViewLayout(){
        fullScrollView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        fullContentView.snp.makeConstraints { make in
            make.edges.equalTo(fullScrollView.contentLayoutGuide)
            make.width.equalTo(fullScrollView.frameLayoutGuide)
            make.height.equalTo(1056)
        }
    }
    
    func collectionviewSet(){
        self.myChallengeCollectionView.dataSource = self
        self.myChallengeCollectionView.delegate = self
        self.myChallengeCollectionView.register(MyChallengeFeedCollectionViewCell.self, forCellWithReuseIdentifier: MyChallengeFeedCollectionViewCell.identifier)
        self.myChallengeCollectionView.backgroundColor = .white
    }
        
    // addSubview() 메서드 모음
    func addView() {
        // foreach문을 사용해서 클로저 형태로 작성
        //상단부
        [myPageTitle, firstBar, notificationButton, rectangleBox, nameLabel, profileShadowView, settingBackground, feed, goal, fail, feedCount, goalCount, failCount, commentBox, comment, challengeTitleLabel].forEach{view in fullContentView.addSubview(view)}
        //중앙부
        [challengeTitleLabel, challengeBox, checkImage, starImage, pointImage, checkLabel, starLabel, pointLabel, checkCount, starCount, pointCount, line1, line2, myChallengeUnderBar, checkButton, starButton, pointButton].forEach{view in fullContentView.addSubview(view)}
        
        //하단부
        [myChallengeFeedLabel, showAllChallengeFeedView, showAllChallengeFeedLabel, showAllChallengeFeedButton, myChallengeCollectionView].forEach{view in fullContentView.addSubview(view)}
        
        profileShadowView.addSubview(profileImage)
        settingBackground.addSubview(settingButton)
    }
        
    // MARK: - 전체 오토레이아웃 관리
        // MARK: - 상단부
    func viewConstraint(){
        
        myPageTitle.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(8)
        }
        
        notificationButton.snp.makeConstraints { make in
            make.width.equalTo(24)
            make.height.equalTo(24)
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalTo(myPageTitle)
        }
        
        settingBackground.snp.makeConstraints { make in
            make.width.equalTo(28)
            make.height.equalTo(28)
            make.top.equalTo(rectangleBox).offset(146)
            make.leading.equalToSuperview().offset(114)
        }
        settingButton.snp.makeConstraints { make in
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.leading.equalTo(settingBackground).offset(4)
            make.top.equalTo(settingBackground).offset(4)
        }
        
        rectangleBox.snp.makeConstraints { make in
            make.height.equalTo(274)
            make.width.equalToSuperview()
            make.top.equalToSuperview().offset(48)
            make.leading.equalToSuperview()
        }
        nameLabel.snp.makeConstraints { make in
            make.height.equalTo(26)
            make.top.equalTo(myPageTitle.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(16)
        }
        profileImage.snp.makeConstraints { make in
            make.width.equalTo(96)
            make.height.equalTo(96)
            make.leading.equalTo(nameLabel).offset(30)
            make.top.equalTo(nameLabel.snp.bottom).offset(28)
        }
        profileShadowView.snp.makeConstraints { make in
            make.width.equalTo(96)
            make.height.equalTo(96)
            make.leading.equalTo(nameLabel).offset(30)
            make.top.equalTo(nameLabel.snp.bottom).offset(28)
        }
        feed.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(190)
            make.top.equalTo(rectangleBox ).offset(91)
        }
        goal.snp.makeConstraints { make in
            make.leading.equalTo(feed.snp.trailing).offset(28)
            make.top.equalTo(feed)
        }
        fail.snp.makeConstraints { make in
            make.leading.equalTo(goal.snp.trailing).offset(28)
            make.top.equalTo(feed)
        }
        feedCount.snp.makeConstraints { make in
            make.top.equalTo(feed.snp.bottom).offset(16)
            make.centerX.equalTo(feed)
        }
        goalCount.snp.makeConstraints { make in
            make.centerX.equalTo(goal)
            make.centerY.equalTo(feedCount)
        }
        failCount.snp.makeConstraints { make in
            make.centerX.equalTo(fail)
            make.centerY.equalTo(feedCount)
        }
        commentBox.snp.makeConstraints { make in
            make.width.equalTo(358)
            make.height.equalTo(60)
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(rectangleBox).offset(198)
        }
        comment.snp.makeConstraints { make in
            make.leading.equalTo(commentBox.snp.leading).offset(20)
            make.top.equalTo(commentBox.snp.top).offset(19)
        }
        // MARK: - 중앙부
        challengeTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.top.equalTo(rectangleBox.snp.bottom).offset(24)
        }
        challengeBox.snp.makeConstraints { make in
            make.width.equalTo(358)
            make.height.equalTo(123)
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(challengeTitleLabel.snp.bottom).offset(12)
        }
        checkImage.snp.makeConstraints { make in
            make.width.equalTo(35)
            make.height.equalTo(35)
            make.leading.equalTo(challengeBox.snp.leading).offset(45)
            make.top.equalTo(challengeBox.snp.top).offset(19)
        }
        starImage.snp.makeConstraints { make in
            make.size.equalTo(checkImage)
            make.centerY.equalTo(checkImage)
            make.leading.equalTo(checkImage.snp.trailing).offset(82)
        }
        pointImage.snp.makeConstraints { make in
            make.size.equalTo(checkImage)
            make.centerY.equalTo(checkImage)
            make.leading.equalTo(starImage.snp.trailing).offset(79)
        }
        checkLabel.snp.makeConstraints { make in
            make.top.equalTo(challengeBox.snp.top).offset(62)
            make.centerX.equalTo(checkImage)
        }
        starLabel.snp.makeConstraints { make in
            make.centerY.equalTo(checkLabel)
            make.centerX.equalTo(starImage)
        }
        pointLabel.snp.makeConstraints { make in
            make.centerY.equalTo(checkLabel)
            make.centerX.equalTo(pointImage)
        }
        checkCount.snp.makeConstraints { make in
            make.top.equalTo(challengeBox.snp.top).offset(86)
            make.centerX.equalTo(checkImage)
        }
        starCount.snp.makeConstraints { make in
            make.centerY.equalTo(checkCount)
            make.centerX.equalTo(starImage)
        }
        pointCount.snp.makeConstraints { make in
            make.centerY.equalTo(checkCount)
            make.centerX.equalTo(pointImage)
        }
        checkButton.snp.makeConstraints { make in
            make.width.equalTo(122)
            make.height.equalTo(challengeBox)
            make.leading.equalTo(challengeBox)
            make.top.equalTo(challengeBox.snp.top)
        }
        starButton.snp.makeConstraints { make in
            make.width.equalTo(114)
            make.height.equalTo(checkButton)
            make.leading.equalTo(line1.snp.trailing)
            make.top.equalTo(challengeBox.snp.top)
        }
        pointButton.snp.makeConstraints { make in
            make.size.equalTo(checkButton)
            make.leading.equalTo(line2.snp.trailing)
            make.top.equalTo(challengeBox.snp.top)
        }
        line1.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.height.equalTo(100)
            make.top.equalTo(challengeBox).offset(12)
            make.leading.equalTo(challengeBox).offset(122)
        }
        line2.snp.makeConstraints { make in
            make.size.equalTo(line1)
            make.top.equalTo(challengeBox).offset(12)
            make.leading.equalTo(line1).offset(114)
        }
        myChallengeUnderBar.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(8)
            make.leading.equalToSuperview()
            make.top.equalTo(challengeBox.snp.bottom).offset(24)
        }
        // MARK: - 하단부
        myChallengeFeedLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(myChallengeUnderBar.snp.bottom).offset(24)
        }
        showAllChallengeFeedView.snp.makeConstraints{ make in
            make.width.equalTo(70)
            make.height.equalTo(21)
            make.top.equalTo(myChallengeUnderBar.snp.bottom).offset(27)
            make.leading.equalToSuperview().offset(304)
        }
        showAllChallengeFeedLabel.snp.makeConstraints { make in
            make.top.equalTo(myChallengeUnderBar.snp.bottom).offset(29)
            make.leading.equalTo(showAllChallengeFeedView).offset(12)
        }
        showAllChallengeFeedButton.snp.makeConstraints { make in
            make.size.equalTo(showAllChallengeFeedView)
            make.edges.equalTo(showAllChallengeFeedView)
        }
        myChallengeCollectionView.snp.makeConstraints { make in
            make.width.equalTo(super.view.frame.width - 32)
            make.height.equalTo(292)
            make.top.equalTo(myChallengeFeedLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
//            make.edges.equalTo(UIEdgeInsets(top: 553, left: 16, bottom: 188, right: 16))
        }
    }
}

extension MyPageViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    // cell 개수 지정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    // cell 등록 및 관련 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyChallengeFeedCollectionViewCell.identifier, for: indexPath) as! MyChallengeFeedCollectionViewCell
        cell.backgroundColor = .white
        return cell
        
    }
    
    //cell 크기 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width : CGFloat = 173
        let height: CGFloat = 140
        return CGSize(width: width, height: height)
    }
    
    
}

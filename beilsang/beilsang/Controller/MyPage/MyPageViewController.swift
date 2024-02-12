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
    var feedList : [feedData] = []

    //상단부
    // 세팅 버튼
    lazy var settingBackground: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 14
        view.backgroundColor = .bePrPurple500
        return view
    }()
    lazy var settingImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon_settings")
        return view
    }()
    lazy var settingButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(edit), for: .touchUpInside)
        return button
    }()
    lazy var rectangleBox: UIView = {
        let view = UIView()
        view.layer.backgroundColor = UIColor.beScPurple300.cgColor
        view.layer.cornerRadius = 14
        view.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMaxYCorner, .layerMaxXMaxYCorner)
        return view
    }()
    // "안녕하세요, 00님" Label
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        var name = "앤"
        label.text = "안녕하세요, " + name + "님"
        label.textColor = .black
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
        label.textColor = .beTextInfo
        label.font = UIFont(name: "NotoSansKR-Medium", size: 18)
        label.textAlignment = .center
        return label
    }()
    lazy var goal: UILabel = {
        let label = UILabel()
        label.text = "달성"
        label.textColor = .beTextInfo
        label.font = UIFont(name: "NotoSansKR-Medium", size: 18)
        label.textAlignment = .center
        return label
    }()
    lazy var fail: UILabel = {
        let label = UILabel()
        label.text = "실패"
        label.textColor = .beTextInfo
        label.font = UIFont(name: "NotoSansKR-Medium", size: 18)
        label.textAlignment = .center
        return label
    }()
    
    lazy var feedCount : UILabel = {
        let label = UILabel()
        label.text = "20"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "NotoSansKR-SemiBold", size: 20)
        return label
    }()
    lazy var achivementCount : UILabel = {
        let label = UILabel()
        label.text = "18"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "NotoSansKR-SemiBold", size: 20)
        return label
    }()
    lazy var failCount : UILabel = {
        let label = UILabel()
        label.text = "13"
        label.textColor = .black
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
        label.textColor = .black
        label.font = UIFont(name: "NotoSansKR-Medium", size: 16)

        return label
    }()
    
    lazy var challengeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "나의 챌린지"
        label.textColor = .black
        label.font = UIFont(name: "NotoSansKR-SemiBold", size: 18)
        
        return label
    }()
    
    lazy var challengeBox: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .beBgSub
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
    
    lazy var challengeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        label.text = "전체"
        return label
    }()
    lazy var likeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        label.text = "찜"
        return label
    }()
    lazy var pointLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        label.text = "포인트"
        return label
    }()
    lazy var challengeCount: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "NotoSansKR-SemiBold", size: 14)
        label.textColor = .beScPurple700
        label.text = "6"
        return label
    }()
    lazy var likeCount: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "NotoSansKR-SemiBold", size: 14)
        label.textColor = .beScPurple700
        label.text = "12"
        return label
    }()
    lazy var pointCount: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "NotoSansKR-SemiBold", size: 14)
        label.textColor = .beScPurple700
        label.text = "916"
        return label
    }()
    lazy var line1 : UIView = {
        let view = UIView()
        view.backgroundColor = .beBgDiv
        return view
    }()
    lazy var line2 : UIView = {
        let view = UIView()
        view.backgroundColor = .beBgDiv
        return view
    }()
    lazy var myChallengeUnderBar: UIView = {
        let view = UIView()
        view.backgroundColor = .beBgSub
        return view
    }()
    lazy var challengeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(challenge), for: .touchUpInside)
        return button
    }()
    
    lazy var likeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(like), for: .touchUpInside)
        return button
    }()
    lazy var pointButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(point), for: .touchUpInside)
        return button
    }()
    // 하단부
    lazy var myChallengeFeedLabel: UILabel = {
        let label = UILabel()
        label.text = "나의 챌린지 피드"
        label.textColor = .black
        label.font = UIFont(name: "NotoSansKR-SemiBold", size: 18)
        return label
    }()
    lazy var showAllChallengeFeedView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 9
        view.backgroundColor = .beBgSub
        return view
    }()
    lazy var showAllChallengeFeedLabel: UILabel = {
        let label = UILabel()
        label.text = "전체 보기"
        label.textColor = .beButtonNavi
        label.font = UIFont(name: "NotoSansKR-Medium", size: 12)
        return label
    }()
    lazy var showAllChallengeFeedButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(challengeFeed), for: .touchUpInside)
        return button
    }()
    lazy var myChallengeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView =  UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        request()
        setupAttribute()
        viewConstraint()
        setNavigationBar()
        collectionviewSet()
    }
}

extension MyPageViewController {
    
    func request() {
        let memberId = UserDefaults.standard.string(forKey: "memberId")
            MyPageService.shared.getMyPage(baseEndPoint: .mypage, addPath: "/\(memberId ?? "")") { response in
                
            self.feedList = response.data.feedDTOs.feeds
            self.feedCount.text = String(response.data.feedNum)
            self.achivementCount.text = String(response.data.achieve)
            self.failCount.text = String(response.data.fail)
            self.comment.text = String(response.data.resolution ?? "")
            self.challengeCount.text = String(response.data.challenges)
            self.likeCount.text = String(response.data.likes)
            self.pointCount.text = String(response.data.points)
            self.setFeedList(response.data.feedDTOs.feeds)
        }
    }
    
    // collecion
    @MainActor
    private func setFeedList(_ feedDTOs: [feedData]){
        self.feedList = feedDTOs
        myChallengeCollectionView.reloadData()
    }
    
    func setupAttribute() {
        setFullScrollView()
        setLayout()
        setScrollViewLayout()
    }
    
    func setFullScrollView() {
        fullScrollView.delegate = self
        
        //스크롤 안보이게 설정
        fullScrollView.showsVerticalScrollIndicator = false
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
        [rectangleBox, nameLabel, profileShadowView, settingBackground, settingButton, feed, goal, fail, feedCount, achivementCount, failCount, commentBox, comment, challengeTitleLabel].forEach{view in fullContentView.addSubview(view)}
        //중앙부
        [challengeTitleLabel, challengeBox, checkImage, starImage, pointImage, challengeLabel, likeLabel, pointLabel, challengeCount, likeCount, pointCount, line1, line2, myChallengeUnderBar, challengeButton, likeButton, pointButton].forEach{view in fullContentView.addSubview(view)}
        
        //하단부
        [myChallengeFeedLabel, showAllChallengeFeedView, showAllChallengeFeedLabel, showAllChallengeFeedButton, myChallengeCollectionView].forEach{view in fullContentView.addSubview(view)}
        
        profileShadowView.addSubview(profileImage)
        settingBackground.addSubview(settingImage)
    }
        
    // MARK: - 전체 오토레이아웃 관리
        // MARK: - 상단부
    func viewConstraint(){
        
        
        settingBackground.snp.makeConstraints { make in
            make.width.equalTo(28)
            make.height.equalTo(28)
            make.top.equalTo(rectangleBox).offset(146)
            make.leading.equalToSuperview().offset(114)
        }
        settingImage.snp.makeConstraints { make in
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.leading.equalTo(settingBackground).offset(4)
            make.top.equalTo(settingBackground).offset(4)
        }
        settingButton.snp.makeConstraints { make in
            make.edges.size.equalTo(settingBackground)
        }
        rectangleBox.snp.makeConstraints { make in
            make.height.equalTo(274)
            make.width.equalToSuperview()
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
        nameLabel.snp.makeConstraints { make in
            make.height.equalTo(26)
            make.top.equalTo(rectangleBox.snp.top).offset(24)
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
        achivementCount.snp.makeConstraints { make in
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
        challengeLabel.snp.makeConstraints { make in
            make.top.equalTo(challengeBox.snp.top).offset(62)
            make.centerX.equalTo(checkImage)
        }
        likeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(challengeLabel)
            make.centerX.equalTo(starImage)
        }
        pointLabel.snp.makeConstraints { make in
            make.centerY.equalTo(challengeLabel)
            make.centerX.equalTo(pointImage)
        }
        challengeCount.snp.makeConstraints { make in
            make.top.equalTo(challengeBox.snp.top).offset(86)
            make.centerX.equalTo(checkImage)
        }
        likeCount.snp.makeConstraints { make in
            make.centerY.equalTo(challengeCount)
            make.centerX.equalTo(starImage)
        }
        pointCount.snp.makeConstraints { make in
            make.centerY.equalTo(challengeCount)
            make.centerX.equalTo(pointImage)
        }
        challengeButton.snp.makeConstraints { make in
            make.width.equalTo(122)
            make.height.equalTo(challengeBox)
            make.leading.equalTo(challengeBox)
            make.top.equalTo(challengeBox.snp.top)
        }
        likeButton.snp.makeConstraints { make in
            make.width.equalTo(114)
            make.height.equalTo(challengeButton)
            make.leading.equalTo(line1.snp.trailing)
            make.top.equalTo(challengeBox.snp.top)
        }
        pointButton.snp.makeConstraints { make in
            make.size.equalTo(challengeButton)
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
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.top.equalTo(myChallengeFeedLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
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
        if !feedList.isEmpty{
            if ("https://beilsang-bucket.s3.ap-northeast-2.amazonaws.com/feed/53c28c26-5b4c-471b-a02f-ae9353c9b301" == self.feedList[indexPath.row].feedUrl){
                cell.challengeFeed.image = UIImage(named: "icon-meatballs")
            }
            if (self.feedList[indexPath.row].feedUrl == "https://beilsang-bucket.s3.ap-northeast-2.amazonaws.com/feed/908dee82-7164-4ef4-8745-db7c5bf7f06c" ){
                cell.challengeFeed.image = UIImage(named: "icon-point")
            }
            if (self.feedList[indexPath.row].feedUrl == "https://beilsang-bucket.s3.ap-northeast-2.amazonaws.com/feed/d2497de7-1d63-4354-8a08-192139d1bcba"){
                cell.challengeFeed.image = UIImage(named: "icon-star")
            }
            if (self.feedList[indexPath.row].feedUrl == "https://beilsang-bucket.s3.ap-northeast-2.amazonaws.com/feed/e675e124-6746-4caf-9ef9-1a916d13d4e9"){
                cell.challengeFeed.image = UIImage(named: "iconamoon_heart-bold")
            }}
        return cell
        
    }
//    // cell 선택시 액션
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        switch collectionView{
//        case myChallengeCollectionView:
//            let cell = collectionView.cellForItem(at: indexPath) as! MyChallengeFeedCollectionViewCell
//
//        default:
//            return
//        }
//    }
    //cell 크기 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width : CGFloat = 173
        let height: CGFloat = 140
        return CGSize(width: width, height: height)
    }
    
    
}
// MARK: - 네비게이션 바 커스텀
extension MyPageViewController{
    private func setNavigationBar() {
        self.navigationItem.titleView = attributeTitleView()
        setBackButton()
        
    }
    private func attributeTitleView() -> UIView {
        // 네비게이션 바에 타이틀을 왼쪽으로 옮기기 위해 커스텀 뷰 생성
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))

        // 커스텀 뷰 내에 타이틀 레이블 추가
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        titleLabel.text = "마이페이지"
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont(name: "NotoSansKR-SemiBold", size: 22)
        view.addSubview(titleLabel)
          
        return view
    }
    // 백버튼 커스텀
    func setBackButton() {
        let notiButton = UIBarButtonItem(image: UIImage(named: "iconamoon_notification-bold")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(tabBarButtonTapped))
        notiButton.tintColor = .black
        self.navigationItem.rightBarButtonItem = notiButton
    }
    // 사이드 버튼 액션
    @objc func tabBarButtonTapped() {
        print("알림버튼")
        let notificationVC = NotificationViewController()
        navigationController?.pushViewController(notificationVC, animated: true)
    }
}
// MARK: - function
extension MyPageViewController {
    @objc func edit() {
        let accountInfoVC = AccountInfoViewController()
        accountInfoVC.nameField.attributedPlaceholder = NSAttributedString(string: nameLabel.layer.name ?? "2~8자 이내로 입력해 주세요")
        navigationController?.pushViewController(accountInfoVC, animated: true)
    }
    @objc func challenge() {
        let myChallengeVC = MyChallengeViewController()
        navigationController?.pushViewController(myChallengeVC, animated: true)
    }
    @objc func like() {
        let likeVC = LikeViewController()
        navigationController?.pushViewController(likeVC, animated: true)
    }
    @objc func point() {
        let pointVC = PointViewController()
        navigationController?.pushViewController(pointVC, animated: true)
    }
    @objc func challengeFeed() {
        let myChallengeFeedVC = MyChallengeFeedViewController()
        navigationController?.pushViewController(myChallengeFeedVC, animated: true)
    }
//    func testImage2(fileName: String) async -> UIImage {
//        let url: URL
//        do {
//        url = try await Amplify.Storage.getURL(key: fileName)
//        } catch {
//        print("Failed to get URL for image: \(error)")
//        return UIImage(named: "test1.jpeg")!
//        }
//        let downloadTask = Amplify.Storage.downloadFile(
//        key: fileName,
//        local: url,
//        options: nil
//        )
//        Task {
//        for await progress in await downloadTask.progress {
//        print("Progress: \(progress)")
//        }
//        }
//        do {
//        //let imageData = try Data(contentsOf: url)
//        let (data, _) = try await URLSession.shared.data(from: url)
//        let image = UIImage(data: data) ?? UIImage(named: fileName)!
//        //try await downloadTask.value
//        print("Completed!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
//        //return UIImage(data: imageData) ?? UIImage(named: fileName)!
//        return image
//        } catch {
//        print("--------------------------------------------------------------------------------Failed to get URL for image: \(error)")
//        print(url)
//        return UIImage(named: "test1.jpeg")!
//        }
//    }
}


//
//  LearnMoreViewController.swift
//  beilsang
//
//  Created by 강희진 on 2/17/24.
//

import UIKit

class LearnMoreViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Properties
    
    // 전체 화면 scrollview
    let fullScrollView = UIScrollView()
    let fullContentView = UIView()
    
    lazy var tipLabel : UILabel = {
        let label = UILabel()
        label.text = "오늘의 실천 꿀팁 🍯"
        label.font = UIFont(name: "NotoSansKR-SemiBold", size: 18)
        label.textColor = .black
        return label
    }()
    
    lazy var tipView : UIView = {
        let view = UIView()
        view.backgroundColor = .beScPurple400
        view.layer.cornerRadius = 10
        return view
    }()
    
    lazy var mapLabel: UILabel = {
        let label = UILabel()
        label.text = "내 주변 친환경 스팟 📌"
        label.font = UIFont(name: "NotoSansKR-SemiBold", size: 18)
        label.textColor = .black
        return label
    }()
    
    lazy var mapView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.beBgDiv.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    lazy var mapButton : UIButton = {
        let button = UIButton()
        button.setTitle("자세히 보기", for: .normal)
        button.setTitleColor(.beNavy500, for: .normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 12)
        button.layer.cornerRadius = 10.5
        button.backgroundColor = .beBgSub
        return button
    }()
    
    lazy var mapImage: UIImageView = {
        let view =  UIImageView()
        view.image = UIImage(named: "icon-learn-more-1")?.withRenderingMode(.alwaysTemplate) // 이미지 색상을 tintcolor로 변경
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 14
        view.tintColor = .beScPurple600
        //넘치는 영역 잘라내기
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var mapShadowView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var eventLabel : UILabel = {
        let label = UILabel()
        label.text = "오늘의 이벤트"
        label.font = UIFont(name: "NotoSansKR-SemiBold", size: 18)
        label.textColor = .black
        
        return label
    }()
    
    lazy var eventCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        layout.itemSize = CGSize(width: (view.frame.width-56)/3, height: 200)
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupAttribute()
        setCollectionView()
        setNavigationBar()
        viewConstraint()
    }
}
extension LearnMoreViewController {
    
    func setupAttribute() {
        setFullScrollView()
        setLayout()
        setScrollViewLayout()
    }
    
    func setFullScrollView() {
        fullScrollView.delegate = self
        //스크롤 안움직이게 설정
        fullScrollView.isScrollEnabled = true
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
    
    // addSubview() 메서드 모음
    func addView() {
        // foreach문을 사용해서 클로저 형태로 작성
        [tipLabel, tipView, mapLabel, mapView, mapButton, mapShadowView, eventLabel, eventCollectionView].forEach{ view in fullContentView.addSubview(view)}
        mapShadowView.addSubview(mapImage)
    }
    
    //snp 설정
    func viewConstraint(){
        tipLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalToSuperview().offset(16)
        }
        tipView.snp.makeConstraints { make in
            make.top.equalTo(tipLabel.snp.bottom).offset(12)
            make.width.equalTo(view.frame.width-32)
            make.height.equalTo(100)
            make.centerX.equalToSuperview()
        }
        mapLabel.snp.makeConstraints { make in
            make.top.equalTo(tipView.snp.bottom).offset(28)
            make.leading.equalTo(tipLabel)
        }
        mapView.snp.makeConstraints { make in
            make.top.equalTo(mapLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(180)
        }
        mapButton.snp.makeConstraints { make in
            make.height.equalTo(21)
            make.width.equalTo(81)
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalTo(mapLabel)
        }
        mapShadowView.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.leading.equalTo(mapView.snp.leading).offset(12)
            make.bottom.equalTo(mapView.snp.bottom).offset(-12)
        }
        mapImage.snp.makeConstraints { make in
            make.width.height.equalTo(28)
            make.centerX.centerY.equalToSuperview()
        }
        eventLabel.snp.makeConstraints { make in
            make.leading.equalTo(mapLabel)
            make.top.equalTo(mapView.snp.bottom).offset(28)
        }
        eventCollectionView.snp.makeConstraints { make in
            make.top.equalTo(eventLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
        }
    }
}
// MARK: - 네비게이션 바 커스텀
extension LearnMoreViewController{
    private func setNavigationBar() {
        self.navigationItem.titleView = attributeTitleView()
        setBackButton()
    }
    private func attributeTitleView() -> UIView {
        // 네비게이션 바에 타이틀을 왼쪽으로 옮기기 위해 커스텀 뷰 생성
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        // 커스텀 뷰 내에 타이틀 레이블 추가
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        titleLabel.text = "더 알아보기"
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont(name: "NotoSansKR-SemiBold", size: 22)
        view.addSubview(titleLabel)
          
        return view
    }
    // 백버튼 커스텀
    func setBackButton() {
        let notiButton = UIBarButtonItem(image: UIImage(named: "iconamoon_notification-bold")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(tabBarNotiButtonTapped))
        notiButton.tintColor = .black
        let searchButton = UIBarButtonItem(image: UIImage(named: "icon-search")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(tabBarSearchButtonTapped))
        searchButton.tintColor = .black
        self.navigationItem.rightBarButtonItems = [searchButton, notiButton]
    }
    // 사이드 버튼 액션 - 알림
    @objc func tabBarNotiButtonTapped() {
        print("알림버튼")
        let notificationVC = NotificationViewController()
        navigationController?.pushViewController(notificationVC, animated: true)
    }
    // 사이드 버튼 액션 - 검색
    @objc func tabBarSearchButtonTapped() {
        print("검색버튼")
    }
}

// MARK: - collectionView setting(카테고리)
extension LearnMoreViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    // collectionView, delegate, datasorce 설정
    func setCollectionView() {
        [eventCollectionView].forEach { view in
            view.delegate = self
            view.dataSource = self
        }
        //Cell 등록
        eventCollectionView.register(LearnMoreEventCollectionViewCell.self, forCellWithReuseIdentifier: LearnMoreEventCollectionViewCell.identifier)
        
    }
    // section 개수 설정
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    // cell 개수 설정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case eventCollectionView:
            return 6
        default:
            return 0
        }
    }
    
    // cell 설정 - 순서 2
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView{
        case eventCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LearnMoreEventCollectionViewCell.identifier, for: indexPath) as?
                    LearnMoreEventCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
//    // cell 선택시 액션
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        switch collectionView{
//        case eventCollectionView:
//        default:
//            return
//        }
//    }
}

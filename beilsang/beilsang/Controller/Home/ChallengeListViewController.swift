//
//  ChallengeListViewController.swift
//  beilsang
//
//  Created by 곽은채 on 1/26/24.
//

import SnapKit
import UIKit
import Kingfisher

// [홈] 챌린지 리스트
// 홈 메인 화면에서 카테고리를 누른 경우
class ChallengeListViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - properties
    // 전체 화면 scrollview
    let fullScrollView = UIScrollView()
    let fullContentView = UIView()
    
    // topview - navigation
    lazy var navigationButton: UIBarButtonItem = {
        let view = UIBarButtonItem(image: UIImage(named: "icon-navigation"), style: .plain, target: self, action: #selector(tabBarButtonTapped))
        view.tintColor = .beIconDef
        
        return view
    }()
    
    // topview - 레이블
    var categoryLabelText: String?
    lazy var categoryLabel: UILabel = {
        let view = UILabel()
        
        view.text = categoryLabelText
        view.font = UIFont(name: "NotoSansKR-Medium", size: 20)
        view.textColor = .beTextDef
        view.textAlignment = .center
        
        return view
    }()
    
    // 네비게이션 오른쪽 버튼 두 개
    lazy var topRightView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    // topview - plus
    lazy var plusButton: UIButton = {
        let view = UIButton()
        
        view.setImage(UIImage(named: "icon_plus"), for: .normal)
        view.addTarget(self, action: #selector(plusButtonClicked), for: .touchUpInside)
        view.tintColor = .beIconDef
        
        return view
    }()
    
    // topview - search
    lazy var searchButton: UIButton = {
        let view = UIButton()
        
        view.setImage(UIImage(named: "icon-search"), for: .normal)
        view.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
        view.tintColor = .beIconDef
        
        return view
    }()
    
    // topview - border
    lazy var topViewBorder: UIView = {
        let view = UIView()
        
        view.backgroundColor = .beBorderDis
        
        return view
    }()
    
    // 챌린지 진행 팁
    lazy var challengeTipButton: UIButton = {
        let view = UIButton()
        
        view.setImage(UIImage(named: "challengeListBanner"), for: .normal)
        view.addTarget(self, action: #selector(challengeTipButtonClicked), for: .touchUpInside)
        
        return view
    }()
    
    // 챌린지 리스트 콜렉션 뷰
    lazy var challengeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var challengeData : [ChallengeCategoryData] = []
    
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setChallenges()
        setupAttribute()
        setCollectionView()
    }
    
    // MARK: - actions
    // 네비게이션 아이템 누르면 뒤(홈 메인화면)으로 가기
    @objc func tabBarButtonTapped() {
        print("뒤로 가기")
        navigationController?.popViewController(animated: true)
    }
    
    @objc func plusButtonClicked() {
        print("플러스 버튼")
        let registerChallengeVC = RegisterFirstViewController()
        navigationController?.pushViewController(registerChallengeVC, animated: true)
    }
    
    @objc func searchButtonClicked() {
        print("검색")
    }
    
    @objc func challengeTipButtonClicked() {
        let challengeTipVC = ChallengeTipViewController()
        navigationController?.pushViewController(challengeTipVC, animated: true)
    }
}

// MARK: - Layout
extension ChallengeListViewController {
    
    func setupAttribute() {
        setFullScrollView()
        setAddViews()
        setLayout()
        setNavigationBar()
    }
    
    func setFullScrollView() {
        fullScrollView.showsVerticalScrollIndicator = true
        fullScrollView.delegate = self
    }
    
    func setNavigationBar() {
        let rightBarButtons = UIBarButtonItem(customView: topRightView)
        navigationItem.titleView = categoryLabel
        navigationItem.leftBarButtonItem = navigationButton
        navigationItem.rightBarButtonItem = rightBarButtons
    }
    
    func setAddViews() {
        [plusButton, searchButton].forEach { view in
            topRightView.addSubview(view)
        }
        
        view.addSubview(fullScrollView)
        
        fullScrollView.addSubview(fullContentView)
        
        [topViewBorder, challengeTipButton, challengeCollectionView].forEach { view in
            fullContentView.addSubview(view)
        }
    }
    
    func setLayout() {
        topRightView.snp.makeConstraints { make in
            make.width.equalTo(64)
            make.height.equalTo(24)
        }
        
        plusButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        searchButton.snp.makeConstraints { make in
            make.leading.equalTo(plusButton.snp.trailing).offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        fullScrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.leading.trailing.equalToSuperview()
        }
        
        fullContentView.snp.makeConstraints { make in
            make.edges.equalTo(fullScrollView.contentLayoutGuide)
            make.width.equalTo(fullScrollView.frameLayoutGuide)
            make.height.equalTo(1000)
        }
        
        topViewBorder.snp.makeConstraints { make in
            make.top.equalTo(fullScrollView.snp.top)
            make.width.equalTo(fullScrollView.snp.width)
            make.height.equalTo(1)
        }
        
        challengeTipButton.snp.makeConstraints { make in
            make.top.equalTo(topViewBorder.snp.bottom).offset(17)
            make.leading.equalTo(fullScrollView.snp.leading).offset(16)
            make.trailing.equalTo(fullScrollView.snp.trailing).offset(-16)
            make.height.equalTo(100)
        }
        
        challengeCollectionView.snp.makeConstraints { make in
            make.top.equalTo(challengeTipButton.snp.bottom).offset(24)
            make.leading.equalTo(fullScrollView.snp.leading)
            make.trailing.equalTo(fullScrollView.snp.trailing)
            make.bottom.equalTo(fullScrollView.snp.bottom)
        }
    }
}

// MARK: - 카테고리별 챌린지 리스트 api 세팅
extension ChallengeListViewController {
    func setChallenges() {
        if categoryLabelText == "전체" {
            print("전체")
            ChallengeService.shared.challengeCategoriesAll { response in
                self.setChallengesList(response.data!.challenges)
            }
        } else if categoryLabelText == "참여중" {
            print("참여중")
            ChallengeService.shared.challengeCategoriesEnrolled { response in
                self.setChallengesList(response.data!.challenges.challenges)
            }
        } else {
            print("카테고리")
            let category = CategoryConverter.shared.convertToEnglish(categoryLabelText ?? "")
            ChallengeService.shared.challengeCategories(categoryName: category ?? "") { response in
                self.setChallengesList(response.data!.challenges)
            }
        }
    }
    
    @MainActor
    private func setChallengesList(_ response: [ChallengeCategoryData]) {
        self.challengeData = response
        self.challengeCollectionView.reloadData()
    }
}

// MARK: - collectionView setting(챌린지 리스트)
extension ChallengeListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // 콜렉션뷰 세팅
    func setCollectionView() {
        challengeCollectionView.delegate = self
        challengeCollectionView.dataSource = self
        challengeCollectionView.register(ChallengeListCollectionViewCell.self, forCellWithReuseIdentifier: ChallengeListCollectionViewCell.identifier)
    }
    
    // 셀 개수 설정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return challengeData.count
    }
    
    // 셀 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChallengeListCollectionViewCell.identifier, for: indexPath) as?
                ChallengeListCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.challengeId = challengeData[indexPath.row].challengeId
        
        let url = URL(string: challengeData[indexPath.row].imageUrl!)
        cell.challengeImage.kf.setImage(with: url)
        cell.challengeNameLabel.text = challengeData[indexPath.row].title
        cell.makerNickname.text = challengeData[indexPath.row].hostName
        cell.buttonLabel.text = "참여 인원 \(challengeData[indexPath.row].attendeeCount)명"
        
        return cell
    }
    
    // 셀 크기 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - 32
        
        return CGSize(width: width , height: 140)
    }
    
    // 셀 선택시 액션
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ChallengeListCollectionViewCell
        let challengeId = cell.challengeId
        
        ChallengeService.shared.challengeEnrolled(challengId: challengeId!) { response in
            let isEnrolled = response.data.isEnrolled
            
            if isEnrolled {
                let nextVC = JoinChallengeViewController()
                nextVC.challengeId = challengeId
                self.navigationController?.pushViewController(nextVC, animated: true)
            } else {
                let nextVC = ChallengeDetailViewController()
                nextVC.challengeId = challengeId
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        }
    }
}

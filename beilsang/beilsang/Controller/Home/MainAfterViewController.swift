//
//  MainAfterViewController.swift
//  beilsang
//
//  Created by 곽은채 on 1/26/24.
//

import SnapKit
import UIKit
import Kingfisher

// [홈] 메인화면
// 카테고리 하단의 서비스 이용 후 화면(참여 중인 챌린지, 앤님을 위해 준비한 챌린지)
class MainAfterViewController: UIViewController {
    
    // MARK: - properties
    // "참여 중인 챌린지" 레이블
    lazy var participatingChallenge: UILabel = {
        let view = UILabel()
        
        view.text = "참여 중인 챌린지💪"
        view.textAlignment = .left
        view.textColor = .beTextDef
        view.font = UIFont(name: "NotoSansKR-Medium", size: 18)
        
        return view
    }()
    
    // "전체 보기" 버튼
    lazy var viewAllButton: UIButton = {
        let view = UIButton()
        
        view.backgroundColor = .beBgSub
        view.setTitle("전체 보기", for: .normal)
        view.setTitleColor(.beNavy500, for: .normal)
        view.titleLabel?.font = UIFont(name: "Noto Sans KR", size: 12)
        view.contentHorizontalAlignment = .center
        view.layer.cornerRadius = 10
        view.addTarget(self, action: #selector(viewAllButtonClicked), for: .touchUpInside)
        
        return view
    }()
    
    // 참여 중 챌린지 콜렉션 뷰
    lazy var challengeParticipatingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
  
    // oo님을 위해 준비한 챌린지 - oo
    var username = UserDefaults.standard.string(forKey: UserDefaultsKey.memberId)
    // oo님을 위해 준비한 챌린지 - 레이블
    lazy var recommendChallenge: UILabel = {
        let view = UILabel()
        
        view.text = "\(String(describing: username))님을 위해 준비한 챌린지✨"
        view.textAlignment = .left
        view.textColor = .beTextDef
        view.font = UIFont(name: "NotoSansKR-Medium", size: 18)
        
        return view
    }()
    
    // 추천 챌린지 리스트 콜렉션 뷰
    lazy var challengeRecommendCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    // var challengeParticipateData
    var challengeRecommendData : [ChallengeRecommendsData] = []
    var challengeJoinData : [ChallengeJoinTwoData] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        challengeRecommend()
        challengeJoin()
        setAddViews()
        setLayout()
        setCollectionView()
    }
    
    // MARK: - actions
    // 챌린지 리스트 화면 - 전체
    @objc func viewAllButtonClicked() {
        print("전체 보기")
        
        let labelText = "참여중"
        let challengeListVC = ChallengeListViewController()
        challengeListVC.categoryLabelText = labelText
        challengeListVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(challengeListVC, animated: true)
    }
}

// MARK: - Layout setting
extension MainAfterViewController {
    func setAddViews() {
        [participatingChallenge, viewAllButton, challengeParticipatingCollectionView, recommendChallenge, challengeRecommendCollectionView].forEach { view in
            self.view.addSubview(view)
        }
    }
    
    func setLayout() {
        participatingChallenge.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(24)
            make.leading.equalTo(view.snp.leading).offset(16)
        }
        
        viewAllButton.snp.makeConstraints { make in
            make.centerY.equalTo(participatingChallenge.snp.centerY)
            make.trailing.equalTo(view.snp.trailing).offset(-16)
            make.width.equalTo(70)
            make.height.equalTo(21)
        }
        
        challengeParticipatingCollectionView.snp.makeConstraints { make in
            make.top.equalTo(participatingChallenge.snp.bottom).offset(12)
            make.leading.equalTo(view.snp.leading).offset(16)
            make.trailing.equalTo(view.snp.trailing).offset(-16)
            make.height.equalTo(140)
        }
        
        recommendChallenge.snp.makeConstraints { make in
            make.top.equalTo(challengeParticipatingCollectionView.snp.bottom).offset(28)
            make.leading.equalTo(view.snp.leading).offset(16)
        }
        
        challengeRecommendCollectionView.snp.makeConstraints { make in
            make.top.equalTo(recommendChallenge.snp.bottom).offset(12)
            make.leading.equalTo(view.snp.leading).offset(16)
            make.trailing.equalTo(view.snp.trailing).offset(-16)
            make.height.equalTo(140)
        }
    }
}

// MARK: - 참여중 챌린지, 추천 챌린지 api 세팅
extension MainAfterViewController {
    func challengeRecommend() {
        ChallengeService.shared.challengeRecommend() { response in
            self.setRecommendData(response.data!.recommendChallengeDTOList)
        }
    }
    @MainActor
    private func setRecommendData(_ response: [ChallengeRecommendsData]) {
        self.challengeRecommendData = response
        self.challengeRecommendCollectionView.reloadData()
    }
    
    func challengeJoin() {
        ChallengeService.shared.challengeJoinTwo() { response in
            self.setJoinData(response.data!.challenges)
            print(response)
        }
    }
    @MainActor
    private func setJoinData(_ response: [ChallengeJoinTwoData]) {
        self.challengeJoinData = response
        self.challengeParticipatingCollectionView.reloadData()
    }
}

// MARK: - collectionView setting(챌린지 리스트)
extension MainAfterViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // 콜렉션뷰 세팅
    func setCollectionView() {
        challengeParticipatingCollectionView.delegate = self
        challengeParticipatingCollectionView.dataSource = self
        challengeParticipatingCollectionView.register(MainAfterCollectionViewCell.self, forCellWithReuseIdentifier: MainAfterCollectionViewCell.identifier)
        
        challengeRecommendCollectionView.delegate = self
        challengeRecommendCollectionView.dataSource = self
        challengeRecommendCollectionView.register(MainAfterCollectionViewCell.self, forCellWithReuseIdentifier: MainAfterCollectionViewCell.identifier)
    }
    
    // 셀 개수 설정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case challengeParticipatingCollectionView :
            return challengeJoinData.count
        case challengeRecommendCollectionView :
            return challengeRecommendData.count
        default:
            return 2
        }
    }
    
    // 셀 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case challengeParticipatingCollectionView :
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainAfterCollectionViewCell.identifier, for: indexPath) as?
                    MainAfterCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.mainAfterChallengeId = challengeJoinData[indexPath.row].challengeId
            
            let url = URL(string: challengeJoinData[indexPath.row].imageUrl!)
            cell.challengeImage.kf.setImage(with: url)
            cell.challengeNameLabel.text = challengeJoinData[indexPath.row].title
            let achieve = challengeJoinData[indexPath.row].achieveRate
            cell.buttonLabel.text = "달성률 \(achieve)%"
            
            return cell
        case challengeRecommendCollectionView :
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainAfterCollectionViewCell.identifier, for: indexPath) as?
                    MainAfterCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.mainAfterChallengeId = challengeRecommendData[indexPath.row].challengeId
            
            let url = URL(string: challengeRecommendData[indexPath.row].imageUrl!)
            cell.challengeImage.kf.setImage(with: url)
            cell.challengeNameLabel.text = challengeRecommendData[indexPath.row].title
            let categoryName = CategoryConverter.shared.convertToKorean(challengeRecommendData[indexPath.row].category)
            cell.buttonLabel.text = "참여인원 \(categoryName!)명"
            
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    // 셀 크기 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 44) / 2
        
        return CGSize(width: width , height: 140)
    }
    
    // 셀 선택시 액션
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! MainAfterCollectionViewCell
        let challengeId = cell.mainAfterChallengeId
        
        if collectionView == challengeParticipatingCollectionView {
            let nextVC = JoinChallengeViewController()
            nextVC.joinChallengeId = challengeId
            nextVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(nextVC, animated: true)
        } else {
            let nextVC = ChallengeDetailViewController()
            nextVC.detailChallengeId = challengeId
            nextVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}

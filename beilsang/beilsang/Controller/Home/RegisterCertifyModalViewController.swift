//
//  RegisterCertifyModalViewController.swift
//  beilsang
//
//  Created by 곽은채 on 2/7/24.
//

import SnapKit
import UIKit
import Kingfisher

class RegisterCertifyModalViewController: UIViewController {
    
    // MARK: - properties
    // 모달 제외 뷰(모달 아닌 부분 클릭하면 dismiss 모달)
    lazy var notModalView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 33.0/255.0)
        
        return view
    }()
    
    // 모달 전체 뷰
    lazy var modalView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        
        return view
    }()
    
    // 챌린지 인증 유의사항 제목 레이블
    lazy var cautionTitleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "NotoSansKR-SemiBold", size: 18)
        view.text = "챌린지 인증 유의사항"
        view.textColor = .beTextSub
        view.textAlignment = .left
        
        return view
    }()
    
    // 챌린지 인증 유의사항 콜렉션뷰
    lazy var cautionCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    // 챌린지 인증 유의사항 예시 이미지
    lazy var cautionImageView: UIImageView = {
        let view = UIImageView()
        
        view.image = UIImage(named: "testChallengeImage")
        
        return view
    }()
    
    // 유의사항 확인 버튼
    lazy var checkNoticeButton: UIButton = {
        let view = UIButton()
        
        view.backgroundColor = .beScPurple600
        view.layer.cornerRadius = 10
        view.setTitle("유의사항을 확인했어요", for: .normal)
        view.setTitleColor(.beTextWhite, for: .normal)
        view.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        view.addTarget(self, action: #selector(checkNoticeButtonClicked), for: .touchUpInside)
        
        return view
    }()
    
    // 챌린지 인증 유의사항 리스트
    var challengeGuideData : [String] = []
    
    var reviewModalChallengeId : Int?
    
    var collectionViewHeight : Constraint?
    var modalViewHeight : Constraint?
    
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        
        setAttribute()
        setCollectionView()
        setChallengeGuide()
    }
    
    // MARK: - Actions
    @objc func checkNoticeButtonClicked() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - layout setting
extension RegisterCertifyModalViewController {
    func setAttribute() {
        setLayout()
    }
    
    func setLayout() {
        view.addSubview(notModalView)
        view.addSubview(modalView)
        
        notModalView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        modalView.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view)
            make.left.right.equalTo(self.view)
            modalViewHeight = make.height.equalTo(0).constraint
        }
        
        [cautionTitleLabel, cautionImageView, cautionCollectionView, checkNoticeButton].forEach { view in
            modalView.addSubview(view)
        }
        
        cautionTitleLabel.snp.makeConstraints{ make in
            make.top.equalTo(modalView.snp.top).offset(24)
            make.leading.equalToSuperview().offset(16)
        }
        
        cautionImageView.snp.makeConstraints{ make in
            make.top.equalTo(cautionTitleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(175)
            make.height.equalTo(180)
        }
        
        cautionCollectionView.snp.makeConstraints { make in
            make.top.equalTo(cautionImageView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            collectionViewHeight = make.height.equalTo(0).constraint
        }
        
        checkNoticeButton.snp.makeConstraints { make in
            make.top.equalTo(cautionCollectionView.snp.bottom).offset(32)
            make.height.equalTo(56)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
}

// MARK: - 챌린지 유의사항 api 세팅
extension RegisterCertifyModalViewController {
    func setChallengeGuide() {
        ChallengeService.shared.challengeGuide(guideChallengeId: reviewModalChallengeId ?? 0) { response in
            let url = URL(string: response.data.certImage)
            self.cautionImageView.kf.setImage(with: url)
            self.challengeGuideData = response.data.challengeNoteList
            self.cautionCollectionView.reloadData()
            
            let height = (self.challengeGuideData.count * 18) + ((self.challengeGuideData.count) * 8)
            self.collectionViewHeight!.update(offset: height)
            self.modalViewHeight!.update(offset: 388 + height)
        }
    }
}

// MARK: - collectionView setting
extension RegisterCertifyModalViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // 콜렉션뷰 세팅
    func setCollectionView() {
        cautionCollectionView.delegate = self
        cautionCollectionView.dataSource = self
        cautionCollectionView.register(CautionCollectionViewCell.self, forCellWithReuseIdentifier: CautionCollectionViewCell.identifier)
    }
    
    // 셀 개수 설정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return challengeGuideData.count
    }
    
    // 셀 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CautionCollectionViewCell.identifier, for: indexPath) as?
                CautionCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.cautionLabel.text = challengeGuideData[indexPath.row]
        cell.cautionCellView.backgroundColor = .clear
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - 32
        
        return CGSize(width: width, height: 18)
    }
}

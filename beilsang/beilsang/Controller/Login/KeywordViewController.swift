//
//  JoinViewController.swift
//  beilsang
//
//  Created by Seyoung on 1/20/24.
//

import UIKit
import SnapKit

class KeywordViewController: UIViewController {
    
    // MARK: - Properties
    
    let dataList = Keyword.data
    
    lazy var joinCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(JoinCollectionViewCell.self, forCellWithReuseIdentifier: JoinCollectionViewCell.identifier)
        collectionView.backgroundColor = .beBgDef
        return collectionView
    }()
    
    lazy var progressView: UIProgressView = {
        let view = UIProgressView()
        view.trackTintColor = .beBgDiv
        view.progressTintColor = .bePrPurple500
        view.clipsToBounds = true
        view.layer.cornerRadius = 4
        return view
    }()
    
    lazy var joinLabel: UILabel = {
        let label = UILabel()
        label.text = "비일상 키워드를\n한 가지 선택해주세요"
        label.font = UIFont(name: "NotoSansKR-SemiBold", size: 20)
        label.numberOfLines = 2
        label.textColor = .beTextDef
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .beScPurple400
        button.setTitle("다음으로", for: .normal)
        button.setTitleColor(.beTextWhite, for: .normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        button.addTarget(self, action: #selector(nextAction), for: .touchDown)
        
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(UserDefaults.standard.string(forKey: "serverToken"))
        navigationBarSetup()
        setupUI()
        setupLayout()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        //navigationBarHidden()
        view.backgroundColor = .beBgDef
        view.addSubview(joinLabel)
        view.addSubview(nextButton)
        view.addSubview(joinCollectionView)
    }
    
    private func setupLayout() {
        progressView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(38)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(192)
            make.height.equalTo(8)
        }

        joinLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(200)
            make.top.equalToSuperview().offset(116)
        }

        joinCollectionView.snp.makeConstraints { make in
            make.width.equalTo(354)
            make.height.equalTo(354)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }

        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-100)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(56)
        }
    }
    
    // MARK: - Navigation Bar
    
    private func navigationBarSetup() {
        navigationController?.navigationBar.addSubview(progressView)
        navigationController?.delegate = self
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
    }
    
    // MARK: - Button Disabled
    
    private func selectedKeyword(for cell: JoinCollectionViewCell) {
        let check = cell.isSelected
        
        if check {
            nextButton.isEnabled = true
            nextButton.backgroundColor = .beScPurple600
        } else {
            nextButton.isEnabled = false
            nextButton.backgroundColor = .beScPurple400
            // 필요한 경우 check 변수 사용 또는 반환 등을 진행
        }
    }
    
    // MARK: - Actions
    
    @objc private func nextAction() {
        let motoViewController = MotoViewController()
        self.navigationController?.pushViewController(motoViewController, animated: true)
        
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

extension KeywordViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JoinCollectionViewCell.identifier, for: indexPath) as?
                JoinCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let target = dataList[indexPath.row]
        let img = UIImage(named: "\(target.image).svg")
        cell.keywordImage.image = img
        cell.keywordLabel.text = target.title
        cell.backgroundColor = .beBgDef
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110 , height: 110)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? JoinCollectionViewCell else {
            return
        }
        selectedKeyword(for: cell)
        
        var key: String
            switch indexPath.row {
            case 0:
                key = "TUMBLER"
            case 1:
                key = "REFILL_STATION"
            case 2:
                key = "MULTIPLE_CONTAINERS"
            case 3:
                key = "ECO_PRODUCT"
            case 4:
                key = "PLOGGING"
            case 5:
                key = "VEGAN"
            case 6:
                key = "PUBLIC_TRANSPORT"
            case 7:
                key = "BIKE"
            case 8:
                key = "RECYCLE"
            default:
                key = ""
            }
        
        SignUpData.shared.keyword = key
        print("Keyword : \(key)")
    }
}

extension KeywordViewController: UINavigationBarDelegate, UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        let progressArray: [Float] = [0.25, 0.5, 0.75, 0.75, 0]
        if let currentIndex = navigationController.viewControllers.firstIndex(of: viewController) {
            let progress = progressArray[currentIndex]
            progressView.setProgress(progress, animated: true)
        }
    }
}

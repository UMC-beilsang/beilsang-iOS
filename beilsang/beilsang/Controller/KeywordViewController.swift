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
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    lazy var progressView: UIProgressView = {
        let view = UIProgressView()
        view.trackTintColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        view.progressTintColor = UIColor(red: 0.66, green: 0.71, blue: 1, alpha: 1)
        view.progress = 0.25
        view.clipsToBounds = true
        view.layer.cornerRadius = 4
        return view
    }()
    
    lazy var joinLabel: UILabel = {
        let label = UILabel()
        label.text = "비일상 키워드를\n한 가지 선택해주세요"
        label.font = UIFont(name: "NotoSansKR-SemiBold", size: 20)
        label.numberOfLines = 2
        label.textColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.75, green: 0.78, blue: 1, alpha: 1)
        button.setTitle("다음으로", for: .normal)
        button.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
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
        setupUI()
        setupLayout()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        navigationBarHidden()
        view.backgroundColor = .white
        view.addSubview(progressView)
        view.addSubview(joinLabel)
        view.addSubview(nextButton)
        view.addSubview(joinCollectionView)
    }
    
    private func setupLayout() {
        progressView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(84)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(192)
            make.height.equalTo(8)
        }

        joinLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(200)
            make.top.equalTo(progressView.snp.bottom).offset(32)
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
    
    private func navigationBarHidden() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    // MARK: - Button Disabled
    
    private func selectedKeyword(for cell: JoinCollectionViewCell) {
            let check = cell.isSelected

            if check {
                nextButton.isEnabled = true
                nextButton.backgroundColor = UIColor(red: 0.48, green: 0.53, blue: 0.86, alpha: 1)
            } else {
                nextButton.isEnabled = false
                nextButton.backgroundColor = UIColor(red: 0.75, green: 0.78, blue: 1, alpha: 1)
                // 필요한 경우 check 변수 사용 또는 반환 등을 진행
            }
        }
    
    // MARK: - Actions
    
    @objc private func nextAction() {
        let motoViewController = MotoViewController()
        navigationController?.pushViewController(motoViewController, animated: true)
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
        cell.backgroundColor = .white
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
    }
}

//
//  JoinViewController.swift
//  beilsang
//
//  Created by Seyoung on 1/20/24.
//

import UIKit
import SnapKit

class KeywordViewController: UIViewController {
    
    let dataList = Keyword.data
    let width = UIScreen.main.bounds.width
    let colorView = UIView()
    
    lazy var joinCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
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
        let view = UILabel()
        view.text = "비일상 키워드를\n한 가지 선택해주세요"
        view.font = UIFont(name: "NotoSansKR-SemiBold", size: 20)
        view.numberOfLines = 2
        view.textColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var nextButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = UIColor(red: 0.75, green: 0.78, blue: 1, alpha: 1)
        view.setTitle("다음으로", for: .normal)
        view.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        view.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        view.layer.cornerRadius = 10
        //constraints를 cumtom으로 설정
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.joinCollectionView.delegate = self
        self.joinCollectionView.dataSource = self
        self.joinCollectionView.register(JoinCollectionViewCell.self, forCellWithReuseIdentifier: JoinCollectionViewCell.identifier)
        
        view.backgroundColor = .white
        view.addSubview(progressView)
        view.addSubview(joinLabel)
        view.addSubview(nextButton)
        view.addSubview(joinCollectionView)

       
        
        progressView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(84)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(192)
            make.height.equalTo(8)
        }
        
        
        joinLabel.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(200)
            make.top.equalTo(progressView.snp.bottom).offset(32)
        }
        
        joinCollectionView.snp.makeConstraints{ make in
            make.width.equalTo(354)
            make.height.equalTo(354)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints{ make in
            make.bottom.equalToSuperview().offset(-100)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(56)
        }
        
    }
}

extension KeywordViewController: UICollectionViewDataSource {
    
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
}
    

        
extension KeywordViewController: UICollectionViewDelegateFlowLayout {
    //셀 크기 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110 , height: 110)
    }
}


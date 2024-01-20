//
//  JoinViewController.swift
//  beilsang
//
//  Created by Seyoung on 1/20/24.
//

import UIKit
import SnapKit

class JoinViewController: UIViewController {
    
    let dataList = Keyword.data
    let width = UIScreen.main.bounds.width
    
    lazy var joinCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    lazy var progressView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = .equalSpacing
        view.spacing = 12
        return view
    }()
    
    lazy var currentProgress: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.66, green: 0.71, blue: 1, alpha: 1)
        view.layer.cornerRadius = 6
        
        return view
        
    }()
    
    lazy var smallProgress1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.84, green: 0.84, blue: 0.84, alpha: 1)
        view.layer.cornerRadius = 6
        
        return view
    }()
   
    lazy var smallProgress2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.84, green: 0.84, blue: 0.84, alpha: 1)
        view.layer.cornerRadius = 6
        
        return view
    }()
   
    lazy var smallProgress3: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.84, green: 0.84, blue: 0.84, alpha: 1)
        view.layer.cornerRadius = 6
        
        return view
    }()
    
    
    //lazy var progressView: UIProgressView = {
    //    let view = UIProgressView()
    //    view.trackTintColor = .lightGray
    //    view.progressTintColor = UIColor(red: 0.66, green: 0.71, blue: 1, alpha: 1)
    //    view.progress = 0.25
    //    return view
    //}()
    
    lazy var joinLabel: UILabel = {
        let view = UILabel()
        view.text = "앤님의 비일상 키워드를 한 가지 선택해주세요"
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
        
        progressView.addArrangedSubview(currentProgress)
        progressView.addArrangedSubview(smallProgress1)
        progressView.addArrangedSubview(smallProgress2)
        progressView.addArrangedSubview(smallProgress3)
       
        
        progressView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(84)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(12)
        }
        
        currentProgress.snp.makeConstraints{ make in
            make.width.equalTo(48)
        }
        
        smallProgress1.snp.makeConstraints{ make in
            make.width.equalTo(12)
        }
        
        smallProgress2.snp.makeConstraints{ make in
            make.width.equalTo(12)
        }
        
        smallProgress3.snp.makeConstraints{ make in
            make.width.equalTo(12)
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

extension JoinViewController: UICollectionViewDataSource {
    
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
    

        
extension JoinViewController: UICollectionViewDelegateFlowLayout {
    //셀 크기 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110 , height: 110)
    }
}
    

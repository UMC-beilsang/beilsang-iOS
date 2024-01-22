//
//  JoinMotoViewController.swift
//  beilsang
//
//  Created by Seyoung on 1/22/24.
//

import UIKit
import SnapKit

class MotoViewController: UIViewController {
    
    let dataList = Moto.data
    let width = UIScreen.main.bounds.width
    
    lazy var motoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    lazy var progressView: UIProgressView = {
        let view = UIProgressView()
        view.trackTintColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        view.progressTintColor = UIColor(red: 0.66, green: 0.71, blue: 1, alpha: 1)
        view.progress = 0.5 //progress 조정
        view.clipsToBounds = true
        view.layer.cornerRadius = 4
        
        return view
    }()
    
    
    lazy var joinmotoLabel: UILabel = {
        let view = UILabel()
        view.text = "비일상을 통해 이루고 싶은 다짐을 입력해 주세요!"
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
        
        self.motoCollectionView.delegate = self
        self.motoCollectionView.dataSource = self
        self.motoCollectionView.register(MotoCollectionViewCell.self, forCellWithReuseIdentifier: MotoCollectionViewCell.identifier)
        
        view.backgroundColor = .white
        view.addSubview(progressView)
        view.addSubview(joinmotoLabel)
        view.addSubview(nextButton)
        
        view.addSubview(motoCollectionView)
        
        
        progressView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(84)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(192)
            make.height.equalTo(8)
        }
        
        
        joinmotoLabel.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(230)
            make.top.equalTo(progressView.snp.bottom).offset(32)
        }
        
        nextButton.snp.makeConstraints{ make in
            make.bottom.equalToSuperview().offset(-100)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(56)
        }

        motoCollectionView.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(joinmotoLabel.snp.bottom).offset(56)
            make.bottom.equalTo(nextButton.snp.top).offset(-65)
    
        }
        
        
    }
    
    // Do any additional setup after loading the view.
}

extension MotoViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MotoCollectionViewCell.identifier, for: indexPath) as?
                MotoCollectionViewCell else {
            return UICollectionViewCell()
        }
        let target = dataList[indexPath.row]
        
        cell.motoLabel.text = target.title
        cell.motoImage.text = target.image
        
        cell.backgroundColor = .white
        
        
        return cell
    }
}
    

//크기오토레이아웃 우짜죠
extension MotoViewController: UICollectionViewDelegateFlowLayout {
    //셀 크기 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 358, height: 70)
    }
}
    

//
//  JoinMotoViewController.swift
//  beilsang
//
//  Created by Seyoung on 1/22/24.
//

import UIKit
import SnapKit

class MotoViewController: UIViewController {
    
    //MARK: - Properties
    
    let dataList = Moto.data
    
    lazy var motoCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MotoCollectionViewCell.self, forCellWithReuseIdentifier: MotoCollectionViewCell.identifier)
        collectionView.backgroundColor = .beBgDef
        return collectionView
    }()
    
    lazy var joinmotoLabel: UILabel = {
        let view = UILabel()
        view.text = "비일상을 통해 이루고 싶은 다짐을 입력해 주세요!"
        view.font = UIFont(name: "NotoSansKR-SemiBold", size: 20)
        view.numberOfLines = 2
        view.textColor = .beTextDef
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
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
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setupUI()
        setupLayout()
    }
    
    //MARK: - UI Setup
    
    private func setupUI() {
       // navigationBarHidden()
        view.backgroundColor = .beBgDef
        view.addSubview(joinmotoLabel)
        view.addSubview(nextButton)
        view.addSubview(motoCollectionView)
    }
    
    private func setupLayout() {
        
        joinmotoLabel.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(230)
            make.top.equalToSuperview().offset(116)
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
    
    // MARK: - Navigation Bar
    
    private func setNavigationBar() {
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    // MARK: - Button Disabled
    
    private func selectedMoto(for cell: MotoCollectionViewCell) {
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
        let userInfoController = UserInfoViewController()
        self.navigationController?.pushViewController(userInfoController, animated: true)
        /*
        
        UIView.transition(with: self.view.window!,
                          duration: 0.7,
                          options: .transitionCrossDissolve,
                          animations: {
            self.navigationController?.pushViewController(userInfoController, animated: false)
        },
                          completion: nil)
         */
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

extension MotoViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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
        
        cell.backgroundColor = .beBgDef
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 358, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? MotoCollectionViewCell else {
            return
        }
        
        selectedMoto(for: cell)
    }
}

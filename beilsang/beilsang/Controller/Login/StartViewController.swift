//
//  StartViewController.swift
//  beilsang
//
//  Created by Seyoung on 1/23/24.
//

import UIKit
import SnapKit

class StartViewController: UIViewController {
    
    //MARK: - Properties
    lazy var characterImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "characterlogo")
        view.sizeToFit()
        view.layer.shadowColor = UIColor.beTextDef.cgColor
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.2
        
        return view
    }()
    
    lazy var startLabel: UILabel = {
        let view = UILabel()
        view.text = "당신의 친환경 활동이\nBe 일상이 되도록 응원할게요!"
        view.font = UIFont(name: "NotoSansKR-SemiBold", size: 20)
        view.numberOfLines = 2
        view.textColor = .beTextDef
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        
        return view
    }()
    
    lazy var nextButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .beScPurple600
        view.setTitle("비일상 시작하기", for: .normal)
        view.setTitleColor(.beTextWhite, for: .normal)
        view.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(nextAction), for: .touchDown)
        return view
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()


    }
    
    //MARK: - UI Setup
    
    private func setupUI() {
        navigationBarHidden()
        view.backgroundColor = .beBgDef
        view.addSubview(characterImage)
        view.addSubview(startLabel)
        view.addSubview(nextButton)
    }
    
    private func setupLayout() {
        characterImage.snp.makeConstraints{ make in
            make.height.width.equalTo(260)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(174)
        }
        
        startLabel.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(characterImage.snp.bottom).offset(24)
        }
        
        nextButton.snp.makeConstraints{ make in
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
    
    @objc private func nextAction() {
        print("Next button tapped")
        let testViewController = ViewController()
        
        if let navigationController = self.navigationController {
            navigationController.pushViewController(testViewController, animated: true)
        } else {
            print("Error")
            
        }
    }
}

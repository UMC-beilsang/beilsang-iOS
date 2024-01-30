//
//  LoginViewController.swift
//  beilsang
//
//  Created by Seyoung on 1/20/24.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    //MARK: - Properties
    
    lazy var logoColorImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Logo_app_color")
        view.sizeToFit()
        
        return view
    }()
    
    lazy var kakaoButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = UIColor(red: 1, green: 0.95, blue: 0.3, alpha: 1)
        view.setTitle("카카오톡으로 로그인하기", for: .normal)
        view.setTitleColor(.beTextDef, for: .normal)
        view.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 1, green: 0.93, blue: 0, alpha: 1).cgColor
        view.layer.cornerRadius = 10
        if let kakaoIcon = UIImage(named: "Kakao_logo") {
            view.setImage(kakaoIcon, for: .normal)
            view.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 10)
           }
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var appleButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .beBgCard
        view.setTitle("Apple로 계속하기", for: .normal)
        view.setTitleColor(.beTextDef, for: .normal)
        view.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.beBorderDis.cgColor
        view.layer.cornerRadius = 10
        if let appleIcon = UIImage(named: "Apple_logo") {
            view.setImage(appleIcon, for: .normal)
            view.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 10)
           }
        view.translatesAutoresizingMaskIntoConstraints = false
        
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
        view.backgroundColor = .white
        view.addSubview(logoColorImage)
        view.addSubview(kakaoButton)
        view.addSubview(appleButton)
    }
    
    private func setupLayout() {
        logoColorImage.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(256)
            make.height.equalTo(120)
            make.width.equalTo(100)
        }
        
        kakaoButton.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.width.equalTo(358)
            make.height.equalTo(56)
            make.top.equalTo(logoColorImage.snp.bottom).offset(250)
    
        }
        
        appleButton.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.width.equalTo(kakaoButton)
            make.height.equalTo(56)
            make.top.equalTo(kakaoButton.snp.bottom).offset(12)
        }
    }
}

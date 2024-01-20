//
//  LoginViewController.swift
//  beilsang
//
//  Created by Seyoung on 1/20/24.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    // 로고
    lazy var logoColorImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Logo_app_color")
        view.sizeToFit()
        
        return view
    }()
    
    // 카카오 로그인 버튼
    lazy var kakaoButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = UIColor(red: 1, green: 0.95, blue: 0.3, alpha: 1)
        view.setTitle("카카오톡으로 로그인하기", for: .normal)
        view.setTitleColor(UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1), for: .normal)
        view.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 1, green: 0.93, blue: 0, alpha: 1).cgColor
        view.layer.cornerRadius = 10
        if let kakaoIcon = UIImage(named: "Kakao_logo") {
            view.setImage(kakaoIcon, for: .normal)
            //수정 필요!
            view.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 10)
           }
        //constraints를 cumtom으로 설정
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    // 애플 로그인 버튼
    lazy var appleButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = UIColor(red: 0.99, green: 0.99, blue: 0.99, alpha: 1)
        view.setTitle("Apple로 시작하기", for: .normal)
        view.setTitleColor(UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1), for: .normal)
        view.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).cgColor
        view.layer.cornerRadius = 10
        if let appleIcon = UIImage(named: "Apple_logo") {
            view.setImage(appleIcon, for: .normal)
            //수정 필요!
            view.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 10)
           }
        //constraints를 cumtom으로 설정
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setLayout()

        // Do any additional setup after loading the view.
    }

}


extension LoginViewController{
    func setLayout(){
        view.addSubview(logoColorImage)
        view.addSubview(kakaoButton)
        view.addSubview(appleButton)
        
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


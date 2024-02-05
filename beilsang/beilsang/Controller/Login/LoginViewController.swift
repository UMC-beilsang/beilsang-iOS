//
//  LoginViewController.swift
//  beilsang
//
//  Created by Seyoung on 1/20/24.
//

import UIKit
import SnapKit
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser
import AuthenticationServices

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
        view.addTarget(self, action: #selector(kakaoSignInButtonPress), for: .touchDown)
        
        return view
    }()
    
    lazy var appleButton: ASAuthorizationAppleIDButton = {
        let view = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn, authorizationButtonStyle: .whiteOutline)
        view.addTarget(self, action: #selector(appleButtonPress), for: .touchDown)
        
        return view
    }()
    

    lazy var bubbleLabel: UILabel = {
        let view = UILabel()
        view.text = "🌱 우리의 일상이 될 친환경 프로젝트 시작하기"
        view.font = UIFont(name: "NotoSansKR-Medium", size: 12)
        view.numberOfLines = 0
        view.textColor = .beTextDef
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var bubbleView : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "bubble")
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.16
        view.layer.shadowRadius = 4
        view.layer.shadowOffset = CGSize(width: 2, height: 2)
        view.layer.shadowPath = nil
        view.contentMode = .scaleAspectFill
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
        view.addSubview(bubbleView)
        
        bubbleView.addSubview(bubbleLabel)
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
        
        bubbleView.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(kakaoButton.snp.top).offset(-12)
            make.height.equalTo(44)
        }
        
        bubbleLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(8)
            make.centerX.equalToSuperview()
        }
    }
    
    //MARK: - Actions
    
    @objc private func kakaoSignInButtonPress() {
        // 카카오톡 설치 여부 확인
        if UserApi.isKakaoTalkLoginAvailable() {
            // 카카오톡 로그인. api 호출 결과를 클로저로 전달.
            loginWithApp()
        } else {
            // 만약, 카카오톡이 깔려있지 않을 경우에는 웹 브라우저로 카카오 로그인함.
            loginWithWeb()
        }
    }
    
    @objc private func appleButtonPress() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

//MARK: - 카카오 로그인

extension LoginViewController {
    func loginWithApp() {
        UserApi.shared.loginWithKakaoTalk {(_, error) in
            if let error = error {
                print(error)
            } else {
                print("loginWithKakaoTalk() success.")
                
                UserApi.shared.me {(user, error) in
                    if let error = error {
                        print(error)
                    } else {
                        /*
                        guard let token = oauthToken?.accessToken, let email = user?.kakaoAccount?.email,
                              let name = user?.kakaoAccount?.profile?.nickname else{
                            print("token/email/name is nil")
                            return
                        }
                        
                        self.email = email
                        self.accessToken = token
                        self.name = name
                         */
                        //서버에 보내주기
                        
                        self.presentToMain()
                    }
                }
            }
        }
    }
    
    // 카카오톡 웹으로 로그인
    func loginWithWeb() {
        UserApi.shared.loginWithKakaoAccount {(_, error) in
            if let error = error {
                print(error)
            } else {
                print("loginWithKakaoAccount() success.")
                
                UserApi.shared.me {(user, error) in
                    if let error = error {
                        print(error)
                    } else {
                        self.presentToMain()
                    }
                }
            }
        }
    }
    
    // 화면 전환 함수
    func presentToMain() {
        let joinVC = KeywordViewController()
        let navigationController = UINavigationController(rootViewController: joinVC)
        
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            UIView.transition(with: sceneDelegate.window!,
                              duration: 1.5,
                              options: .transitionCrossDissolve,
                              animations: {
                sceneDelegate.window?.rootViewController = navigationController
            },
                              completion: nil)
        }
    }
}

//MARK: - 애플 로그인

extension LoginViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    // Apple 로그인 화면 표시
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    // Apple ID 연동 성공 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
            // Apple ID
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            print("User ID : \(userIdentifier)")
            print("User Email : \(email ?? "")")
            print("User Name : \((fullName?.givenName ?? "") + (fullName?.familyName ?? ""))")
            
            presentToMain()
            
        default:
            break
        }
    }
    
    // Apple ID 연동 실패 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Apple Login Error")
    }
    
}

//
//  SceneDelegate.swift
//  beilsang
//
//  Created by Seyoung on 1/16/24.
//

import UIKit
import KakaoSDKCommon
import KakaoSDKAuth
import AuthenticationServices
import KakaoSDKUser

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    //로그인 로직
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        // 카카오 로그인 상태 확인
        if (AuthApi.hasToken()) {
            // 토큰 유효성 검사
            UserApi.shared.accessTokenInfo { (oauthToken, error) in
                if let error = error {
                    print("Error checking token validity: \(error)")
                    DispatchQueue.main.async {
                        // 토큰 유효하지 않은 경우 로그인 화면으로 이동
                        let mainViewController = UINavigationController(rootViewController: LoginViewController())
                        self.window?.rootViewController = mainViewController
                        self.window?.makeKeyAndVisible()
                    }
                } else {
                    print("Kakao Token Found")
                    // 토큰 유효한 경우 홈 화면으로 이동
                    if UserDefaults.standard.bool(forKey: UserDefaultsKey.existMember) {
                        // 회원 가입이 완료된 사용자입니다.
                        DispatchQueue.main.async {
                            let mainViewController = UINavigationController(rootViewController: HomeMainViewController())
                            self.window?.rootViewController = mainViewController
                            self.window?.makeKeyAndVisible()
                        }
                    } else {
                        // 회원 가입이 필요한 사용자입니다.
                        DispatchQueue.main.async {
                            let mainViewController = UINavigationController(rootViewController: KeywordViewController())
                            self.window?.rootViewController = mainViewController
                            self.window?.makeKeyAndVisible()
                        }
                    }
                    
                }
            }
        } else {
            print("Kakao Token not Found")
            // 카카오 토큰이 없는 경우 애플 로그인 확인
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            appleIDProvider.getCredentialState(forUserID: UserDefaultsKey.memberId) { (credentialState, error) in
                switch credentialState {
                case .authorized:
                    print("Apple Authorized")
                    DispatchQueue.main.async {
                        // 애플 로그인이 되어 있는 경우 홈 화면으로 이동
                        if UserDefaults.standard.bool(forKey: UserDefaultsKey.existMember) {
                            // 회원 가입이 완료된 사용자입니다.
                            DispatchQueue.main.async {
                                let mainViewController = UINavigationController(rootViewController: HomeMainViewController())
                                self.window?.rootViewController = mainViewController
                                self.window?.makeKeyAndVisible()
                            }
                        } else {
                            // 회원 가입이 필요한 사용자입니다.
                            DispatchQueue.main.async {
                                let mainViewController = UINavigationController(rootViewController: KeywordViewController())
                                self.window?.rootViewController = mainViewController
                                self.window?.makeKeyAndVisible()
                            }
                        }
                    }
                case .revoked, .notFound:
                    print("Apple Not Authorized")
                    DispatchQueue.main.async {
                        // 애플 로그인이 되어 있지 않은 경우 로그인 화면 표시
                        let mainViewController = UINavigationController(rootViewController: LoginViewController())
                        self.window?.rootViewController = mainViewController
                        self.window?.makeKeyAndVisible()
                    }
                default:
                    break
                }
            }
        }
    }
        
    
    func changeRootViewController(_ newRootViewController: UIViewController) {
            guard let window = self.window else { return }
            window.rootViewController = newRootViewController
        }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                _ = AuthController.handleOpenUrl(url: url)
            }
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}


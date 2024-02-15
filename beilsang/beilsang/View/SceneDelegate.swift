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
        
        if let accessToken = UserDefaults.standard.string(forKey: UserDefaultsKey.serverToken) {
            // existmember 확인
            if UserDefaults.standard.bool(forKey: UserDefaultsKey.existMember) {
                let mainVC = UINavigationController(rootViewController: HomeMainViewController())
                self.window?.rootViewController = mainVC
                self.window?.makeKeyAndVisible()
                print("found access Token")
            } else {
                // 가입 절차 거치지 않은 유저
                let keywordVC = UINavigationController(rootViewController: KeywordViewController())
                self.window?.rootViewController = keywordVC
                self.window?.makeKeyAndVisible()
                print("No exist member")
            }
        } else {
            // 액세스 토큰이 없으면 로그인 화면으로 이동
            let loginVC = UINavigationController(rootViewController: LoginViewController())
            self.window?.rootViewController = loginVC
            self.window?.makeKeyAndVisible()
            print("Not found access Token")
        }
        
        window?.makeKeyAndVisible()
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

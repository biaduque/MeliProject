//
//  SceneDelegate.swift
//  MeliProject
//
//  Created by Beatriz Duque on 28/07/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var authCoordinator: AuthManager?
    
    /// 🇺🇸 Method used to configure the appCoordinator
    /// 🇧🇷 Método utilizado para configutar o appCoordinator
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let appScene = (scene as? UIWindowScene) else { return }
        
        let mainNavController = UINavigationController()

        let rootCoordinatior = MeliProjectCoordinator(with: mainNavController)
       
        window = UIWindow(windowScene: appScene)
        window?.rootViewController = mainNavController // App root
        window?.makeKeyAndVisible()
        
        let mlAPIManager = MeliAPIManager(accessToken: nil)
        self.authCoordinator = AuthManager(apiManager: mlAPIManager)
        
        rootCoordinatior.start()
    }


    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let urlContext = URLContexts.first else { return }
        
         if urlContext.url.scheme == "meliappcallback" {
            print("callback chamado para autenticações")
         }
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}


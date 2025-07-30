//
//  MeliProjectCoordinator.swift
//  MeliProject
//
//  Created by Beatriz Duque on 28/07/25.
//

import UIKit

/// ** Protocolo coordinator**
/// 🇺🇸 Used to app controllers orcherstrate
/// 🇧🇷 Utilizado para orquestração de controllers presentes no app
protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    func start()
    func startDetail(with requestId: String)
    func back()
}

class MeliProjectCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.navigationBar.backgroundColor = UIColor.meliYellow
        setupNavigationBar()
    }
    
    /// InitialViewController
    /// **Home*
    /// Controller que exibe uma lista de repositórios
    func start() {
        let viewController = HomeFactory.makeController(with: self,
                                                        aditionalInfos: nil)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    ///
    /// **DetailViewController*
    /// Controller que exibe a lista de pull requests dado um repositório selecionado
    func startDetail(with requestId: String) {
        let viewController = DetailFactory.makeController(with: self,
                                                          aditionalInfos: requestId)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func back() {
        navigationController.popViewController(animated: true)
    }
    
    
    func setupNavigationBar() {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()

            appearance.backgroundColor = UIColor.meliYellow
            appearance.titleTextAttributes = [.foregroundColor: UIColor.body]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.body]

            navigationController.navigationBar.standardAppearance = appearance
            navigationController.navigationBar.scrollEdgeAppearance = appearance
        }
}

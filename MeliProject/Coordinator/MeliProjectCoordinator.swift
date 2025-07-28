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
    // TO-DO: Adicionar modelo para request
    func startDetail(with request: Any)
    func back()
}

class MeliProjectCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    /// InitialViewController
    /// **Home*
    /// Controller que exibe uma lista de repositórios
    func start() {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .red
        navigationController.pushViewController(viewController, animated: true)
    }
    
    ///
    /// **RepoDetailViewController*
    /// Controller que exibe a lista de pull requests dado um repositório selecionado
    func startDetail(with request: Any) {
        let viewController = UIViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func back() {
        navigationController.popViewController(animated: true)
    }
}

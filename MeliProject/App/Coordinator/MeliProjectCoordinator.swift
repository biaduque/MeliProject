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
    func startBuyProduct(with url: String)
    func back()
}

class MeliProjectCoordinator: Coordinator {
    var navigationController: UINavigationController
    var journeyTypes: AppJourneys?
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.navigationBar.backgroundColor = UIColor.meliYellow
        setupNavigationBar()
        configureJourneyTypes()
    }
    
    /// Configurar o tipo de cada jornada
    func configureJourneyTypes() {
        if let jsonString = MeliAPIManager.loadFileContent(from: "app_journeys_config", withExtension: "json") {
            if let decodedJourneys = MeliAPIManager.decodeJSON(from: jsonString, as: AppJourneys.self) {
                self.journeyTypes = decodedJourneys
            } else {
                print("\nFalha ao decodificar AppJourneys do arquivo.")
            }
        } else {
            print("\nNão foi possível carregar o conteúdo do arquivo JSON.")
        }
    }
    
    /// InitialViewController
    /// **Home*
    /// Controller que exibe uma lista de repositórios
    func start() {
        guard let journeyTypes = journeyTypes else { return }
        
        switch journeyTypes.home {
            case .native:
                let viewController = HomeFactory.makeController(with: self,
                                                                aditionalInfos: nil)
                navigationController.pushViewController(viewController, animated: true)
            case .webview:
                print(" >>> Webview ainda não implementada para jornada HOME")
        }
    }
    
    ///
    /// **DetailViewController*
    /// Controller que exibe a lista de pull requests dado um repositório selecionado
    func startDetail(with requestId: String) {
        guard let journeyTypes = journeyTypes else { return }

        switch journeyTypes.detail {
            case .native:
                let viewController = DetailFactory.makeController(with: self,
                                                                  aditionalInfos: requestId)
                navigationController.pushViewController(viewController, animated: true)
            case .webview:
                print(" >>> Webview ainda não implementada para jornada DETALHE")
        }
       
    }
    
    ///
    /// **BuyProductViewController*
    /// Controller que exibe a lista de pull requests dado um repositório selecionado
    func startBuyProduct(with url: String) {
        guard let journeyTypes = journeyTypes else { return }

        switch journeyTypes.buyProduct {
            case .native:
                print(" >>> Jornada nativa não implementada para jornada DETALHE")
            case .webview:
                let viewController = BuyProductFactory.makeController(with: url)
                navigationController.pushViewController(viewController, animated: true)
        }
       
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

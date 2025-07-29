//
//  HomeFactory.swift
//  MeliProject
//
//  Created by Beatriz Duque on 28/07/25.
//

import UIKit

class HomeFactory: FactoryProtocol {
    static func makeController(with coordinator: MeliProjectCoordinator, aditionalInfos: Any?) -> UIViewController {
        let viewController = HomeViewController(view: HomeView(viewModel: HomeViewModel()))
        viewController.title = "Busca Livre"
        let router = HomeRouter()
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let worker = HomeWorker()
        
        viewController.setup(router: router)
        viewController.setup(interactor: interactor)
        
        router.setup(coordinator: coordinator)
        presenter.setup(controller: viewController)
        interactor.setup(worker: worker, presenter: presenter)
        
        return viewController
    }
}

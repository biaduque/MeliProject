//
//  DetailFactory.swift
//  MeliProject
//
//  Created by Beatriz Duque on 30/07/25.
//

import UIKit

class DetailFactory: FactoryProtocol {
    static func makeController(with coordinator: MeliProjectCoordinator, aditionalInfos: Any?) -> UIViewController {
        guard let requestId = aditionalInfos as? String else {
            /// TO-DO: Melhorar tratativa de erro
            return UIViewController()
        }
        
        let viewController = DetailViewController(view: DetailView(viewModel: DetailViewModel()), id: requestId)
        viewController.title = "Detalhe"
        let router = DetailRouter()
        let interactor = DetailInteractor()
        let presenter = DetailPresenter()
        let worker = DetailWorker()
        
        viewController.setup(router: router)
        viewController.setup(interactor: interactor)
        
        router.setup(coordinator: coordinator)
        presenter.setup(controller: viewController)
        interactor.setup(worker: worker, presenter: presenter)
        
        return viewController
    }
}

//
//  HomeRouter.swift
//  MeliProject
//
//  Created by Beatriz Duque on 28/07/25.
//

// TO-DO: adicionar modelo para detalhe
protocol HomeRoutingProtocol: AnyObject {
    func goToDetail(from id: String)
}

class HomeRouter: HomeRoutingProtocol {
    var coordinator: Coordinator?
    
    func setup(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func goToDetail(from id: String) {
        coordinator?.startDetail(with: id)
    }
}

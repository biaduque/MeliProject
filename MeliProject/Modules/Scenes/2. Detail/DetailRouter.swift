//
//  DetailRouter.swift
//  MeliProject
//
//  Created by Beatriz Duque on 30/07/25.
//

protocol DetailRoutingProtocol: AnyObject {
    func routeBackToHome()
}

class DetailRouter: DetailRoutingProtocol {
    var coordinator: Coordinator?
    
    func setup(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func routeBackToHome() {
        self.coordinator?.back()
    }
}

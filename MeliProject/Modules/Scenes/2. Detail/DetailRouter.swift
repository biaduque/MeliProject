//
//  DetailRouter.swift
//  MeliProject
//
//  Created by Beatriz Duque on 30/07/25.
//

protocol DetailRoutingProtocol: AnyObject {
    func routeBackToHome()
    func routeToBuyProduct(url: String)
}

class DetailRouter: DetailRoutingProtocol {
    var coordinator: Coordinator?
    
    func setup(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func routeBackToHome() {
        self.coordinator?.back()
    }
    
    func routeToBuyProduct(url: String) {
        self.coordinator?.startBuyProduct(with: url)
    }
    
}

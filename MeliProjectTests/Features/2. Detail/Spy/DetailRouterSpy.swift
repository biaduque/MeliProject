//
//  DetailRouterSpy.swift
//  MeliProject
//
//  Created by Beatriz Duque on 30/07/25.
//



import XCTest
@testable import MeliProject

class DetailRouterSpy: DetailRoutingProtocol {
    var routeBackToListCalled = false
    var routeToBuyProductCalled = false
    var url = ""
    
    func routeBackToHome() {
        routeBackToListCalled = true
    }
    
    func routeToBuyProduct(url: String) {
        routeToBuyProductCalled = true
        self.url = url
    }
}

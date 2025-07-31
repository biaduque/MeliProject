//
//  BuyProductInteractorSpy.swift
//  MeliProject
//
//  Created by Beatriz Duque on 31/07/25.
//


import XCTest
@testable import MeliProject

class BuyProductInteractorSpy: BuyProductBusinessLogic {
    var getWebViewCalled = false
    
    func getWebView(_ completion: @escaping ((URLRequest?) -> Void), url: String) {
        getWebViewCalled = true
    }
}

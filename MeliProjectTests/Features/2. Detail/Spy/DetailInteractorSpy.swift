//
//  DetailInteractorSpy.swift
//  MeliProject
//
//  Created by Beatriz Duque on 30/07/25.
//


import XCTest
@testable import MeliProject

class DetailInteractorSpy: DetailBusinessLogic {
    var fetchDetailCalled = false
    var calledBuyProduct = false
    
    func fetchDetail(id: String) {
        fetchDetailCalled = true
    }
    
    func calledBuyProduct(url: String) {
        calledBuyProduct = true 
    }
}

//
//  HomeInteractorSpy.swift
//  MeliProject
//
//  Created by Beatriz Duque on 30/07/25.
//


import XCTest
@testable import MeliProject

class HomeInteractorSpy: HomeBusinessLogic {
    var fetchItemListCalled = false
    
    func fetchItemList(search: String, page: String) {
        fetchItemListCalled = true
    }
    
}

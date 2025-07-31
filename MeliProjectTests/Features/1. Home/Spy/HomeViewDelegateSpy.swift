//
//  HomeViewDelegateSpy.swift
//  MeliProject
//
//  Created by Beatriz Duque on 30/07/25.
//


import XCTest
@testable import MeliProject

class HomeViewDelegateSpy: HomeViewDelegate {
    var didCallSearch = false
    var didCallSelectedItem = false
    var didCallNextPage = false

    var item = ""
    var id = ""
    
    func didSearch(item: String) {
        didCallSearch = true
        self.item = item
    }
    
    func didSelectItem(id: String) {
        didCallSelectedItem = true
        self.id = id
    }
    
    func didRequestedNextPage() {
        didCallNextPage = true
    }
}

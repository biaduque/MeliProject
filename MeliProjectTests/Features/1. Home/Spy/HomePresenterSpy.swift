//
//  HomePresenterSpy.swift
//  MeliProject
//
//  Created by Beatriz Duque on 30/07/25.
//


import XCTest
@testable import MeliProject

class HomePresenterSpy: HomePresentationLogic {
    var didCall = false
    var controller: HomeViewController?
    var content: MeliProject.SearchResult?
    
    func presentEmptyView() {
        didCall = true
        controller?.setupEmpty()
    }
    
    func presentError() {
        didCall = true
        controller?.setupError()
    }
    
    func presentiInitialView() {
        didCall = true
    }
    
    func presentItemsList(content: MeliProject.SearchResult) {
        didCall = true
        self.content = content
        controller?.setupContent(with: content)
    }
    
    func hideLoading() {
        didCall = true
    }
    
    func presentLoading() {
        didCall = true
        controller?.setupLoading()
    }
    
    func updateView() {
        didCall = true
        controller?.updateView()
    }
    
    func setup(controller: HomeViewController) {
        self.controller = controller
    }
}

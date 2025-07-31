//
//  DetailPresenterSpy.swift
//  MeliProject
//
//  Created by Beatriz Duque on 30/07/25.
//


import XCTest
@testable import MeliProject

class DetailPresenterSpy: DetailPresentationLogic {
    var didCall = false
    var didCallPresentDetail = false
    var detailModal = ""
    var controller: DetailViewController?
   
    func setup(controller: DetailViewController) {
        self.controller = controller
    }
    
    func presentEmptyView() {
        didCall = true
        controller?.setupEmpty()
    }
    
    func presentError() {
        didCall = true
        controller?.setupError()
    }
    
    func presentLoading() {
        didCall = true
        controller?.setupLoading()
    }
    
    func updateView() {
        didCall = true
        controller?.updateView()
    }
    
    func presentDetailModal(url: String) {
        detailModal = ""
    }
    
    func presentDetail(content: MeliProject.Item) {
        didCallPresentDetail = true
    }
    
    func hideLoading() {
        didCall = true
        controller?.hideLoading()
    }
}

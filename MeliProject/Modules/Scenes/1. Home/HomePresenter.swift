//
//  HomePresenter.swift
//  MeliProject
//
//  Created by Beatriz Duque on 28/07/25.
//

protocol HomePresentationLogic {
    func presentiInitialView()
    func presentEmptyView()
    func presentError()
    func presentItemsList(content: SearchResult)
    func presentLoading()
    func hideLoading()
    func updateView()
}

class HomePresenter: HomePresentationLogic {
   
    
    var controller: HomeViewController?

    func setup(controller: HomeViewController) {
        self.controller = controller
    }
    
    func presentiInitialView() {
        controller?.styleView?.setupView()
    }
    
    func presentLoading() {
        controller?.setupLoading()
    }
    
    func hideLoading() {
        controller?.hideLoading()
    }
    
    func presentEmptyView() {
        controller?.setupEmpty()
    }
    
    func presentError() {
        controller?.setupError()
    }
    
    func presentItemsList(content: SearchResult) {
        controller?.setupContent(with: content)
    }
   
    func updateView() {
        controller?.updateView()
    }
}

//
//  DetailPresenter.swift
//  MeliProject
//
//  Created by Beatriz Duque on 30/07/25.
//


protocol DetailPresentationLogic {
    func presentEmptyView()
    func presentError()
    func presentDetail(content: Item)
    func presentLoading()
    func hideLoading()
    func updateView()
}

class DetailPresenter: DetailPresentationLogic {
    var controller: DetailViewController?
    
    func setup(controller: DetailViewController) {
        self.controller = controller
    }
    
    func presentDetail(content: Item) {
        controller?.setupContent(with: content)
    }
    
    func presentEmptyView() {
        controller?.setupEmpty()
    }
    
    func presentError() {
        controller?.setupError()
    }
    
    func presentLoading() {
        controller?.setupLoading()
    }
    
    func hideLoading() {
        controller?.hideLoading()
    }
    
    func updateView() {
        controller?.updateView()
    }
    
}

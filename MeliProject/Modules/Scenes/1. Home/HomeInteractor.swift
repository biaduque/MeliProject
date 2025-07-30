//
//  HomeInteractor.swift
//  MeliProject
//
//  Created by Beatriz Duque on 28/07/25.
//
import RxSwift
import UIKit

///
/// O interactor está sendo responsável por consumir a peça que realizar a consulta direta na API no caso, o WORKER.
/// Responsável por invocar a **HomePresenter**, que por sua vez, invoca os casos de apresentação de view
/// que serão disponibilizadas para o usuário de acordo com cada estado: vazio, erro, carregando ou sucesso
protocol HomeBusinessLogic {
    func fetchItemList(search: String, page: String)
}

class HomeInteractor: HomeBusinessLogic {
    private let disposeBag = DisposeBag()
    
    var worker: HomeWorkingProtocol?
    var presenter: HomePresentationLogic?
    
    func setup(worker: HomeWorkingProtocol, presenter: HomePresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }
    
    func fetchItemList(search: String, page: String) {
            worker?.getItemList(searchedItem: search, page: page)
                .do(onSubscribe: { [weak self] in
                    self?.presenter?.presentLoading()
                }, onDispose: { [weak self] in
                    self?.presenter?.hideLoading()
                    self?.presenter?.updateView() 
                })
                .subscribe(
                    onNext: { [weak self] itemsResponse in
                        self?.presenter?.presentItemsList(content: itemsResponse)
                    },
                    onError: { [weak self] error in
                        self?.presenter?.presentError()
                    }
                )
                .disposed(by: disposeBag)
        }
}

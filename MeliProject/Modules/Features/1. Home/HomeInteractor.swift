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
                    onNext: { [weak self] response in
                        guard let self = self else { return }
                        var itemsResponse = response
                        if (itemsResponse.results.isEmpty || !self.checkIfExists(query: search, items: itemsResponse.results)) {
                            self.presenter?.presentEmptyView()
                            return
                        }
                        
                        let itemsFiltered = filterItemsByTitle(searchText: search, in: itemsResponse.results)
                        itemsResponse.results = itemsFiltered
                        
                        self.presenter?.presentItemsList(content: itemsResponse)
                    },
                    onError: { [weak self] error in
                        self?.presenter?.presentError()
                        FirebaseManager.shared.errorReport(error: MeliAPIError.apiError(statusCode: 500, message: error.localizedDescription))

                    }
                )
                .disposed(by: disposeBag)
        }
    
    func checkIfExists(query: String, items: [Item]) -> Bool {
        let lowercasedQuery = query.lowercased()
        
        return items.contains { item in
            let lowercasedTitle = item.title.lowercased()
            return lowercasedTitle.contains(lowercasedQuery)
        }
    }
    
    func filterItemsByTitle(searchText: String, in items: [Item]) -> [Item] {
        let lowercasedSearchText = searchText.lowercased()
        
        return items.filter { item in
            let lowercasedTitle = item.title.lowercased()
            return lowercasedTitle.contains(lowercasedSearchText)
        }
    }

}

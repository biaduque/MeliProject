//
//  DetailInteractor.swift
//  MeliProject
//
//  Created by Beatriz Duque on 30/07/25.
//
import RxSwift

protocol DetailBusinessLogic {
    func fetchDetail(id: String)
}

class DetailInteractor: DetailBusinessLogic {
    var worker: DetailWorkingProtocol?
    var presenter: DetailPresentationLogic?
    private let disposeBag = DisposeBag()
    
    func setup(worker: DetailWorkingProtocol, presenter: DetailPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }
    
    func fetchDetail(id: String) {
        worker?.getDetail(with: id)
            .do(onSubscribe: { [weak self] in
                self?.presenter?.presentLoading()
            }, onDispose: { [weak self] in
                self?.presenter?.hideLoading()
                self?.presenter?.updateView()
            })
            .subscribe(
                onNext: { [weak self] itemResponse in
                    self?.presenter?.presentDetail(content: itemResponse)
                },
                onError: { [weak self] error in
                    guard let self = self else { return }
                    
                    presenter?.presentError()
                }
            )
            .disposed(by: disposeBag)
    }

}

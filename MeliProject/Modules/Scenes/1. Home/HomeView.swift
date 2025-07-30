//
//  HomeView.swift
//  MeliProject
//
//  Created by Beatriz Duque on 28/07/25.
//

import UIKit
import SnapKit

protocol HomeViewDelegate: AnyObject {
    func didSearch(item: String)
    func didSelectItem(id: String)
    func didRequestedNextPage()
}

class HomeView: UIView {
    var homeViewModel: HomeViewModel
    weak var delegate: HomeViewDelegate?
    var searchFieldTopConstraint: Constraint?
    
    var searchState: SearchState = .initialSearch {
        didSet {
            if searchState == .topViewSearch {
                setupSearchingConstraints()
            }
        }
    }
    
    lazy var searchField: SearchTextFieldView = {
        let field = SearchTextFieldView()
        field.delegate = self
        return field
    }()
    
    lazy var contentTableView: ItemsTableView = {
        let table = ItemsTableView()
        table.setupStyle()
        table.register(ItemViewCell.self, forCellReuseIdentifier: ItemViewCell.identifier)
        table.isHidden = true
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    lazy var emptyView: EmptyListView = {
        let view = EmptyListView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var loadingView: LoadingView = {
        let loading = LoadingView()
        loading.isHidden = true
        loading.stop()
        loading.translatesAutoresizingMaskIntoConstraints = false
        return loading
    }()
    
    init(viewModel: HomeViewModel) {
        self.homeViewModel = viewModel
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    func setup(delegate: HomeViewDelegate) {
        self.delegate = delegate
    }
    
    func setup(content: SearchResult) {
        emptyView.hide()
        
        guard var contentList = homeViewModel.searchResult?.results else {
            homeViewModel.searchResult = content
            return
        }
        
        searchState = .topViewSearch
        contentList += content.results
        homeViewModel.searchResult?.results = contentList
    }
    

    func animate() {
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
}

extension HomeView: StatusChangeProtocol {
    func updateContent() {
        contentTableView.reloadData()
        reloadInputViews()
    }
    
    func setupLoading() {
        loadingView.isHidden = false
        loadingView.start()
    }
    
    func hideLoading() {
        loadingView.isHidden = true
        loadingView.stop()
    }
    
    func setupEmpty() {
        homeViewModel.searchResult?.results = []
        emptyView.isHidden = false
        emptyView.setEmpty(cause: .emptyList)
        loadingView.stop()
    }
    
    func setupError() {
        emptyView.isHidden = false
        emptyView.setEmpty(cause: .apiError)
        loadingView.stop()
    }
}

extension HomeView: BaseViewProtocol {
    func setupView() {
        setupHierarchy()
        setupConstraints()
        aditionalSetups()
    }
    
    func setupHierarchy() {
        addSubview(searchField)
        addSubview(contentTableView)
        addSubview(loadingView)
        addSubview(emptyView)
    }
    
    func setupConstraints() {
        searchField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
            searchFieldTopConstraint = make.centerY.equalToSuperview().inset(20).constraint
        }
        
        contentTableView.snp.makeConstraints { make in
            make.top.equalTo(searchField.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview().inset(20)
        }
        
        emptyView.snp.makeConstraints { make in
            make.centerX.centerY.width.equalToSuperview()
        }
    }
    
    func setupSearchingConstraints() {
        guard let searchFieldTopConstraint = searchFieldTopConstraint else { return }
        
        searchFieldTopConstraint.deactivate()
        
        searchField.snp.makeConstraints { make in
            self.searchFieldTopConstraint = make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(16).constraint
        }
        
        loadingView.snp.makeConstraints { make in
            make.centerX.centerY.width.equalToSuperview()
        }
        
        contentTableView.isHidden = false
        animate()
    }
    
    func aditionalSetups() {
        self.backgroundColor = UIColor.backgroundPrimary
    }
}

extension HomeView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.searchResult?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: ItemViewCell = tableView.dequeueReusableCell(withIdentifier: ItemViewCell.identifier, for: indexPath) as? ItemViewCell else { return UITableViewCell() }
        
        guard let items = homeViewModel.searchResult?.results else { return UITableViewCell() }
        if !items.isEmpty {
            let item = items[indexPath.row]
            cell.setupContent(itemName: item.title,
                              value: String(item.price),
                              payment: item.buyingMode ?? "")

            cell.setupItemImage(url: item.thumbnailUrl())
            cell.setupView()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item: Item = homeViewModel.searchResult?.results[indexPath.row] else { return }
        delegate?.didSelectItem(id: item.id)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = FooterView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let items = homeViewModel.searchResult?.results else { return }
        
        if indexPath.row == items.count - 2 && indexPath.row != 0 {
            delegate?.didRequestedNextPage()
        }
    }
    
    func updateTableStyle() {
        contentTableView.layer.shadowPath = UIBezierPath(roundedRect: contentTableView.bounds,
                                                         cornerRadius: contentTableView.layer.cornerRadius).cgPath
    }
}

extension HomeView: SearchFieldDelegate {
    func didSearch(state: SearchState,text: String) {
        delegate?.didSearch(item: text)
    }
    
    func showResults() {
        setupSearchingConstraints()
    }
}

//
//  HomeView.swift
//  MeliProject
//
//  Created by Beatriz Duque on 28/07/25.
//

import UIKit
import SnapKit

protocol HomeViewDelegate: AnyObject {
    func didSelectItem()
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
    
    lazy var contentTableView: UITableView = {
        let table = UITableView()
        table.register(ItemViewCell.self, forCellReuseIdentifier: ItemViewCell.identifier)
        table.isHidden = true
        table.delegate = self
        table.dataSource = self
        table.rowHeight = 120
        table.backgroundColor = .clear
        return table
    }()
    
    lazy var emptyView: EmptyListView = {
        let view = EmptyListView()
        view.isHidden = true
        return view
    }()
    
    lazy var loadingView: LoadingView = {
        let loading = LoadingView()
        loading.isHidden = false
        loading.start()
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
    
    func setup(content: [Any]) {
        loadingView.stop()
        emptyView.hide()
        
        guard var contentList = homeViewModel.items else {
            homeViewModel.items = content
            return
        }
        
        searchState = .topViewSearch
        contentList += content
        homeViewModel.items = contentList
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
        loadingView.start()
    }
    
    func setupEmpty() {
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
    }
    
    func setupConstraints() {
        searchField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(100)
            searchFieldTopConstraint = make.centerY.equalToSuperview().constraint
        }
        
        contentTableView.snp.makeConstraints { make in
            make.top.equalTo(searchField.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setupSearchingConstraints() {
        guard let searchFieldTopConstraint = searchFieldTopConstraint else { return }
        
        searchFieldTopConstraint.deactivate()
        
        searchField.snp.makeConstraints { make in
            self.searchFieldTopConstraint = make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(16).constraint
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
        return homeViewModel.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: ItemViewCell = tableView.dequeueReusableCell(withIdentifier: ItemViewCell.identifier, for: indexPath) as? ItemViewCell else { return UITableViewCell() }
        
        guard let items = homeViewModel.items else { return UITableViewCell() }
        if !items.isEmpty {
            let item = items[indexPath.row]
            cell.setupView()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let items = homeViewModel.items else { return }
        delegate?.didSelectItem()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = FooterView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let items = homeViewModel.items else { return }
        
        if indexPath.row == items.count - 2 {
            delegate?.didRequestedNextPage()
        }
    }
}

extension HomeView: SearchFieldDelegate {
    func didSearch(state: SearchState,text: String) {
        self.searchState = state
        print("BUSCAR")
    }
    
    func showResults() {
        setupSearchingConstraints()
    }
}

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
    
    lazy var contentTableView: UITableView = {
        let table = UITableView()
        table.register(ItemViewCell.self, forCellReuseIdentifier: ItemViewCell.identifier)
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
        contentList += content
        homeViewModel.items = contentList
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
        addSubview(contentTableView)
        addSubview(loadingView)
        addSubview(emptyView)
    }
    
    func setupConstraints() {
        contentTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loadingView.snp.makeConstraints { make in
            make.centerX.centerY.width.equalToSuperview()
            make.height.equalTo(300)
        }
        
        emptyView.snp.makeConstraints { make in
            make.centerX.centerY.width.equalToSuperview()
            make.height.equalTo(300)
        }
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

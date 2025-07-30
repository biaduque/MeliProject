//
//  DetailView.swift
//  MeliProject
//
//  Created by Beatriz Duque on 30/07/25.
//

import UIKit
import SnapKit

protocol DetailViewDelegate: AnyObject {
    func didSelectSeeMore()
}

class DetailView: UIView {
    weak var delegate: DetailViewDelegate?
    var detailViewModel: DetailViewModel
    
    lazy var itemImage: UIImageView =  {
        let image = UIImageView()
        image.image = UIImage(named: "empty-image")
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.contentMode = .scaleAspectFill
        image.backgroundColor = UIColor.backgroundPrimary
        return image
    }()
    
    lazy var itemDescription: UILabel = {
        let label = DSLabel.bodyStyle
        label.textColor = UIColor.caption
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    lazy var contentTableView: ItemsTableView = {
        let table = ItemsTableView()
        table.setupStyle()
        table.register(DetailInfosViewCell.self, forCellReuseIdentifier: DetailInfosViewCell.identifier)
        table.isHidden = false
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    lazy var emptyView: EmptyListView = {
        let view = EmptyListView()
        view.isHidden = true
        return view
    }()
    
    lazy var loadingView: LoadingView = {
        let loading = LoadingView()
        loading.isHidden = true
        loading.stop()
        return loading
    }()
    
    init(viewModel: DetailViewModel) {
        self.detailViewModel = viewModel
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    func setup(delegate: DetailViewDelegate) {
        self.delegate = delegate
    }
    
    func setup(content: Item) {
        detailViewModel.item = content
        itemDescription.text = content.description ?? "Sem descrição disponível."
        setupItemInfoImage(content: content)
    }
    
    func setupItemInfoImage(content: Item) {
        itemImage.kf.setImage(with: content.mainPictureUrl(),
                              placeholder: UIImage(named: "empty-user-image"))
        
        reloadInputViews()
    }
}

extension DetailView: StatusChangeProtocol {
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
    
    }
    
    func setupError() {
        emptyView.isHidden = false
        emptyView.setEmpty(cause: .apiError)
        loadingView.stop()
    }
}

extension DetailView: BaseViewProtocol {
    func setupView() {
        setupHierarchy()
        setupConstraints()
        aditionalSetups()
    }
    
    func setupHierarchy() {
        addSubview(itemImage)
        addSubview(itemDescription)
        addSubview(contentTableView)
        addSubview(loadingView)
    }
    
    func setupConstraints() {
        itemImage.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(16)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
            make.width.equalTo(100)
            make.height.equalTo(150)
        }
        itemDescription.snp.makeConstraints { make in
            make.top.equalTo(itemImage.snp.bottom).offset(16)
            make.width.equalTo(100)
            make.height.equalTo(130)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        contentTableView.snp.makeConstraints { make in
            make.top.equalTo(itemDescription.snp.bottom).offset(12)
            make.leading.trailing.bottom.equalToSuperview().inset(20)
        }
        loadingView.snp.makeConstraints { make in
            make.centerX.centerY.width.equalToSuperview()
            make.height.equalTo(300)
        }
    }
    
    func aditionalSetups() {
        self.backgroundColor = UIColor.backgroundPrimary
    }
}

extension DetailView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return ItemInfoType.allCases.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let infoType = ItemInfoType(rawValue: section) {
            return infoType.title
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: DetailInfosViewCell = tableView.dequeueReusableCell(withIdentifier: DetailInfosViewCell.identifier, for: indexPath) as? DetailInfosViewCell else { return UITableViewCell() }
        guard let infoType = ItemInfoType(rawValue: indexPath.section), let item = detailViewModel.item else  { return UITableViewCell() }
        cell.setupContent(itemIcon: infoType.icon, itemInfo: infoType.info(item: item))
        tableView.rowHeight = infoType.rowHeight()
        return cell
    }
    
    func updateTableStyle() {
        contentTableView.layer.shadowPath = UIBezierPath(roundedRect: contentTableView.bounds,
                                                         cornerRadius: contentTableView.layer.cornerRadius).cgPath
    }
}

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
// MARK: - DetailView
class DetailView: UIView {
    weak var delegate: DetailViewDelegate?
    var detailViewModel: DetailViewModel 
    let totalTableViewHeight = 0.0
    var contentTableViewHeightConstraint: Constraint?
    // MARK: - Elementos da UI
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var contentViewStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 16.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var itemImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "empty-image")
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .white
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var itemDescription: UILabel = {
        let label = DSLabel.bodyStyle
        label.textColor = UIColor.caption
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var contentTableView: ItemsTableView = {
        let table = ItemsTableView()
        table.setupStyle()
        table.rowHeight = 60
        table.register(DetailInfosViewCell.self, forCellReuseIdentifier: DetailInfosViewCell.identifier)
        table.isHidden = false
        table.delegate = self
        table.dataSource = self
        table.isScrollEnabled = false
        table.translatesAutoresizingMaskIntoConstraints = false
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
    
    // MARK: - Inicialização
    init(viewModel: DetailViewModel) {
        self.detailViewModel = viewModel
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - Métodos Públicos
    func setup(delegate: DetailViewDelegate) {
        self.delegate = delegate
    }
    
    func setup(content: Item) {
        detailViewModel.item = content
        itemDescription.text = content.description ?? "Sem descrição disponível."
        setupItemInfoImage(content: content)
    
        updateContent()
    }
    
    func setupItemInfoImage(content: Item) {
        itemImage.kf.setImage(with: content.mainPictureUrl(),
                              placeholder: UIImage(named: "empty-user-image"))
    }
}

// MARK: - StatusChangeProtocol
extension DetailView: StatusChangeProtocol {
    func updateContent() {
        contentTableView.reloadData()
        
        /// atualizacao necessaria ja que o tamanho da celula varia de acordo com o conteudo 
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.contentTableViewHeightConstraint?.update(offset: self.contentTableView.contentSize.height+110)
        }
    }
    
    func setupLoading() {
        loadingView.isHidden = false
        loadingView.start()
        scrollView.isHidden = true
        emptyView.isHidden = true
    }
    
    func hideLoading() {
        loadingView.isHidden = true
        loadingView.stop()
        scrollView.isHidden = false
    }
    
    func setupEmpty() {
        emptyView.isHidden = false
        emptyView.setEmpty(cause: .apiError)
        loadingView.isHidden = true
        loadingView.stop()
        scrollView.isHidden = true
    }
    
    func setupError() {
        emptyView.isHidden = false
        emptyView.setEmpty(cause: .apiError)
        loadingView.stop()
        loadingView.isHidden = true
        scrollView.isHidden = true
    }
}

// MARK: - BaseViewProtocol
extension DetailView: BaseViewProtocol {
    func setupView() {
        setupHierarchy()
        setupConstraints()
        aditionalSetups()
    }
    
    func setupHierarchy() {
        addSubview(scrollView)
        
        scrollView.addSubview(contentViewStack)
        contentViewStack.addArrangedSubview(itemImage)
        contentViewStack.addArrangedSubview(itemDescription)
        contentViewStack.addArrangedSubview(contentTableView)
        
        addSubview(loadingView)
        addSubview(emptyView)
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentViewStack.snp.makeConstraints { make in
            make.top.equalTo(scrollView.contentLayoutGuide.snp.top).offset(16)
            make.leading.equalTo(scrollView.contentLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(scrollView.contentLayoutGuide.snp.trailing).offset(-20)
            make.bottom.equalTo(scrollView.contentLayoutGuide.snp.bottom).offset(-20)
            make.width.equalTo(scrollView.frameLayoutGuide.snp.width).offset(-40)
        }
        
        itemImage.snp.makeConstraints { make in
            make.height.equalTo(150)
        }
       
        contentTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            self.contentTableViewHeightConstraint = make.height.equalTo(0).constraint
        }
        
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        emptyView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func aditionalSetups() {
        self.backgroundColor = UIColor.backgroundPrimary
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            guard let infoType = ItemInfoType(rawValue: indexPath.section) else { return UITableView.automaticDimension }
            
            switch infoType {
            case .attributes:
                return 150
            case .sellerInfo:
                return UITableView.automaticDimension
            default:
                return 65
            }
        }
}


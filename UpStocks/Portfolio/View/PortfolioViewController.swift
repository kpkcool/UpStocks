//
//  ViewController.swift
//  UpStocks
//
//  Created by K Praveen Kumar on 22/05/24.
//

import UIKit

class PortfolioViewController: UIViewController {
    
    //MARK: - Constants
    static let footerHeight: CGFloat = 36
    static let portfolioCellHeight: CGFloat = 80
    static let profitLossCellHeight: CGFloat = 42
    
    //MARK: - UI Elements
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var headerContainerView: UIView = {
        let view = UIView()
        view.addShadow(color: UIColor.lightGray, opacity: 0.2, radius: 4, offset: CGSize(width: 2, height: 4))
        view.backgroundColor = UIColor.theme.mainColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var headerName: UILabel = {
        let label = UILabel()
        label.text = Constants.kPortfolio
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var portfolioTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var profitLossContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var profitLossTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.allowsSelection = false
        tableView.isHidden = true
        tableView.addCornerRadius(radius: 10)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        indicator.color = .systemBlue
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    //MARK: - Properties
    private var profitLossTableViewHeightConstraint: NSLayoutConstraint?
    var stockViewModel = StockViewModel()
    var profitLossCellViewModel: ProfitLossCellViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        setupUI()
        showLoadingIndicator()
        stockViewModel.loadData()
        observeEvents()
    }

    deinit {
        profitLossTableView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize", let tableView = object as? UITableView {
            profitLossTableViewHeightConstraint?.constant = tableView.contentSize.height
        }
    }
}

//MARK: - UI Methods
private extension PortfolioViewController {
    func setupUI() {
        navigationController?.isNavigationBarHidden = true
        view.addSubview(containerView)
        containerView.fillSuperView()
        
        containerView.addSubview(headerContainerView)
        headerContainerView.addSubview(headerImageView)
        headerContainerView.addSubview(headerName)
        headerContainerView.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor, height: 110)
        headerImageView.anchor(leading: headerContainerView.leadingAnchor, bottom: headerContainerView.bottomAnchor, paddingLeft: 16, paddingBottom: 12, width: 24, height: 24)
        headerName.anchor(leading: headerImageView.trailingAnchor, bottom: headerContainerView.bottomAnchor, paddingLeft: 12, paddingBottom: 12)
        
        containerView.addSubview(portfolioTableView)
        portfolioTableView.anchor(top: headerContainerView.bottomAnchor, leading: containerView.leadingAnchor, bottom: containerView.safeAreaLayoutGuide.bottomAnchor, trailing: containerView.trailingAnchor)
        
        containerView.addSubview(loadingIndicator)
        loadingIndicator.centerInSuperview()
        
        containerView.addSubview(profitLossContainerView)
        profitLossContainerView.anchor(leading: containerView.leadingAnchor, bottom: containerView.safeAreaLayoutGuide.bottomAnchor, trailing: containerView.trailingAnchor)
        profitLossContainerView.addSubview(profitLossTableView)
        profitLossTableView.fillSuperView()
        
        profitLossTableViewHeightConstraint = profitLossTableView.heightAnchor.constraint(equalToConstant: 30)
        profitLossTableViewHeightConstraint?.isActive = true
        profitLossTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    func registerCells() {
        portfolioTableView.register(PortfolioTableViewCell.self, forCellReuseIdentifier: String(describing: PortfolioTableViewCell.self))
        profitLossTableView.register(ProfitLossCell.self, forCellReuseIdentifier: String(describing: ProfitLossCell.self))
        profitLossTableView.register(ProfitLossFooterView.self, forHeaderFooterViewReuseIdentifier: String(describing: ProfitLossFooterView.self))
    }
    
    func showLoadingIndicator() {
        loadingIndicator.startAnimating()
        containerView.bringSubviewToFront(loadingIndicator)
    }
    
    func hideLoadingIndicator() {
        loadingIndicator.stopAnimating()
    }
}

//MARK: - TableView Methods
extension PortfolioViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == portfolioTableView {
            return stockViewModel.stockArray.count
        } else {
            return profitLossCellViewModel?.profitLossHeader.isExpandable ?? false ? 3 : 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == portfolioTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PortfolioTableViewCell.self), for: indexPath) as? PortfolioTableViewCell else { return UITableViewCell() }
            cell.configure(stock: stockViewModel.stockArray[indexPath.row])
            return cell
        }
        
        if tableView == profitLossTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProfitLossCell.self), for: indexPath) as? ProfitLossCell else { return UITableViewCell() }
            cell.configure(model: profitLossCellViewModel?.getProfitLossModelArray()?[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView == portfolioTableView ? PortfolioViewController.portfolioCellHeight : PortfolioViewController.profitLossCellHeight
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if tableView == profitLossTableView {
            guard let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: ProfitLossFooterView.self)) as? ProfitLossFooterView else { return UIView() }
            footerView.configure(footerModel: profitLossCellViewModel?.profitLossHeader)
            footerView.footerToggle = {
                self.profitLossTableView.reloadData()
            }
            return footerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return PortfolioViewController.footerHeight
    }
}

//MARK: - Observe Data
extension PortfolioViewController {
    
    func observeEvents() {
        stockViewModel.eventHandler = { [weak self] event in
            guard let self = self else { return }
            switch event {
            case .loading:
                break
            case .loaded:
                DispatchQueue.main.async {
                    self.hideLoadingIndicator()
                    self.profitLossCellViewModel = .init(stocksArray: self.stockViewModel.stockArray)
                    self.reloadTableViews()
                }
            case .error(let error):
                print(error?.localizedDescription ?? "Error")
            }
        }
    }
    
    private func reloadTableViews() {
        self.profitLossTableView.isHidden = false
        self.portfolioTableView.reloadData()
        self.profitLossTableView.reloadData()
    }
}

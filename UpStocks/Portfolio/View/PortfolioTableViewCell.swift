//
//  PortfolioTableViewCell.swift
//  UpStocks
//
//  Created by K Praveen Kumar on 22/05/24.
//

import UIKit

class PortfolioTableViewCell: UITableViewCell {
    
    //MARK: - UI Elements
    private lazy var stockSymbolName: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.theme.textColor
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var quantityStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var quantityLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.kNetQTYLabel
        label.textColor = UIColor.theme.textColor
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var quantityValue: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.theme.textColor
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ltpStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var ltpLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.kLTPLabel
        label.textColor = UIColor.theme.textColor
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ltpValue: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.theme.textColor
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var profitLossStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var profitLossLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.kPLLabel
        label.textColor = UIColor.theme.textColor
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var profitLossValue: UILabel = {
        let label = UILabel()
        label.textColor = .systemGreen
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var viewModel: PortfolioTableViewCellViewModel?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    func configure(stock: Stock) {
        viewModel = .init(stock: stock)
        stockSymbolName.text = viewModel?.stock?.stockName
        quantityValue.text = "\(viewModel?.stock?.netQuantity ?? 0)"
        ltpValue.text = viewModel?.stock?.lastTradedPrice?.toCurrencyString()
        profitLossValue.text = viewModel?.getProfitLossValue()
        profitLossValue.textColor = viewModel?.isProfited() ?? true ? .systemGreen : .systemRed
    }
    
    private func setupViews() {
        contentView.addSubview(stockSymbolName)
        contentView.addSubview(quantityStackView)
        quantityStackView.addArrangedSubview(quantityLabel)
        quantityStackView.addArrangedSubview(quantityValue)
        contentView.addSubview(ltpStackView)
        ltpStackView.addArrangedSubview(ltpLabel)
        ltpStackView.addArrangedSubview(ltpValue)
        contentView.addSubview(profitLossStackView)
        profitLossStackView.addArrangedSubview(profitLossLabel)
        profitLossStackView.addArrangedSubview(profitLossValue)
        
        stockSymbolName.anchor(top: topAnchor, leading: leadingAnchor, paddingTop: 12, paddingLeft: 16)
        quantityStackView.anchor(leading: leadingAnchor, bottom: bottomAnchor, paddingLeft: 16, paddingBottom: 12)
        ltpStackView.anchor(top: topAnchor, trailing: trailingAnchor, paddingTop: 12, paddingRight: 16)
        profitLossStackView.anchor(bottom: bottomAnchor, trailing: trailingAnchor, paddingBottom: 12, paddingRight: 16)
    }
}

//
//  ProfitLossFooterView.swift
//  UpStocks
//
//  Created by K Praveen Kumar on 22/05/24.
//

import UIKit

class ProfitLossFooterView: UITableViewHeaderFooterView {
    
    //MARK: - UI Elements
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var profitLossStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var profitLossLabelView = StarMarkView()
    
    private lazy var arrowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor.theme.textColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var valueStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.theme.textColor
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var valuePercentage: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.theme.textColor
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray.withAlphaComponent(0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var footer: ProfitLossFooter?
    var footerToggle: (() -> Void)?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    func configure(footerModel: ProfitLossFooter?) {
        self.footer = footerModel
        profitLossLabelView.configure(name: footer?.footerName)
        valueLabel.text = footer?.totalValue?.toCurrencyString()
        valuePercentage.text = footer?.percentageValue?.toPercentageString(decimalPlaces: 2)
        valueLabel.textColor = footer?.isProfited ?? true ? .systemGreen : .systemRed
        valuePercentage.textColor = footer?.isProfited ?? true ? .systemGreen : .systemRed
        updateArrowImage()
        updateSeparatorView()
    }
    
    private func setupViews() {
        contentView.backgroundColor = .lightGray.withAlphaComponent(0.2)
        contentView.addSubview(containerView)
        containerView.fillSuperView()
        
        containerView.addSubview(profitLossStackView)
        profitLossStackView.addArrangedSubview(profitLossLabelView)
        profitLossStackView.addArrangedSubview(arrowImage)
        arrowImage.anchor(width: 12)
        
        containerView.addSubview(valueStackView)
        valueStackView.addArrangedSubview(valueLabel)
        valueStackView.addArrangedSubview(valuePercentage)
        
        profitLossStackView.anchor(leading: containerView.leadingAnchor, paddingLeft: 16)
        profitLossStackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        
        valueStackView.anchor(trailing: containerView.trailingAnchor, paddingRight: 16)
        valueStackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        
        containerView.addSubview(separatorView)
        separatorView.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor, paddingLeft: 16, paddingRight: 16, height: 1)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(footerTapped))
        contentView.addGestureRecognizer(tapGesture)
    }
}

//MARK: - Required Methods
private extension ProfitLossFooterView {
    func updateArrowImage() {
        arrowImage.image = footer?.isExpandable ?? false ? UIImage(systemName: "chevron.down") : UIImage(systemName: "chevron.up")
    }
    
    func updateSeparatorView() {
        separatorView.isHidden = !(footer?.isExpandable ?? false)
    }
    
    @objc func footerTapped() {
        footer?.isExpandable.toggle()
        updateArrowImage()
        updateSeparatorView()
        footerToggle?()
    }
}

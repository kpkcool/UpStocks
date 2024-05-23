//
//  ProfitLossCell.swift
//  UpStocks
//
//  Created by K Praveen Kumar on 22/05/24.
//

import UIKit

class ProfitLossCell: UITableViewCell {
    
    //MARK: - UI Elements
    private lazy var titleView = StarMarkView()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.theme.textColor
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    func configure(model: ProfitLossModel?) {
        titleView.configure(name: model?.name)
        valueLabel.text = model?.value
        if model?.name == Constants.kTodaysProfitAndLoss {
            valueLabel.textColor = model?.isProfited ?? true ? .systemGreen : .systemRed
        } else {
            valueLabel.textColor = UIColor.theme.textColor
        }
    }
    
    private func setupViews() {
        backgroundColor = .lightGray.withAlphaComponent(0.2)
        addSubview(titleView)
        addSubview(valueLabel)
        
        titleView.anchor(leading: leadingAnchor, paddingLeft: 16)
        valueLabel.anchor(trailing: trailingAnchor, paddingRight: 16)
        titleView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        valueLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
}


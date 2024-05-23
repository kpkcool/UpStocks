//
//  StarMarkView.swift
//  UpStocks
//
//  Created by K Praveen Kumar on 23/05/24.
//

import UIKit

class StarMarkView: UIView {
    
    //MARK: - UI Elements
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var headerName: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.theme.textColor
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var starLabel: UILabel = {
        let label = UILabel()
        label.text = "*"
        label.textColor = UIColor.theme.textColor
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    func configure(name: String?) {
        headerName.text = name
    }
    
    private func setupViews() {
        addSubview(containerView)
        containerView.fillSuperView()
        containerView.addSubview(headerName)
        containerView.addSubview(starLabel)
        headerName.anchor(leading: containerView.leadingAnchor)
        headerName.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        starLabel.anchor(leading: headerName.trailingAnchor, trailing: containerView.trailingAnchor)
        starLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: -3).isActive = true
    }
}

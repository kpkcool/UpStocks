//
//  MainTabBarViewController.swift
//  UpStocks
//
//  Created by K Praveen Kumar on 22/05/24.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let portfolioVC = UINavigationController(rootViewController: PortfolioViewController())
        portfolioVC.tabBarItem.image = UIImage(systemName: "handbag")
        portfolioVC.title = Constants.kPortfolio
        tabBar.tintColor = UIColor.theme.mainColor
        tabBar.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        setViewControllers([portfolioVC], animated: true)
    }
}

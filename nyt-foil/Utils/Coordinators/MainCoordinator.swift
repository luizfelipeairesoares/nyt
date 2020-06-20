//
//  MainCoordinator.swift
//  nyt-foil
//
//  Created by Luiz Felipe Aires Soares on 20/06/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import UIKit

struct MainCoordinator: CoordinatorProtocol {
    
    func make() -> UIViewController {
        let emailed = navigationController(rootViewController: ListViewController(with: .emailed), tabBarItemTitle: "Emailed", tabBarItemIcon: UIImage(named: "tab_emailed")!)
        let viewed = navigationController(rootViewController: ListViewController(with: .viewed), tabBarItemTitle: "Viewed", tabBarItemIcon: UIImage(named: "tab_viewed")!)
        let shared = navigationController(rootViewController: ListViewController(with: .shared), tabBarItemTitle: "Shared", tabBarItemIcon: UIImage(named: "tab_shared")!)
        
        return createTabBar(with: [emailed, viewed, shared])
    }
    
    // MARK: - Private Functions
    
    private func navigationController(rootViewController: UIViewController,
                                      tabBarItemTitle: String,
                                      tabBarItemIcon: UIImage) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.barTintColor = .white
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        navigationController.tabBarItem.title = tabBarItemTitle
        navigationController.tabBarItem.image = tabBarItemIcon
        
        // Text colors for states
        let normalTextAttributes = self.tabBarItemTextAttributes(textColor: .lightGray)
        let selectedTextAttributes = self.tabBarItemTextAttributes(textColor: .black)
        navigationController.tabBarItem.setTitleTextAttributes(normalTextAttributes, for: .normal)
        navigationController.tabBarItem.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        
        return navigationController
    }
    
    private func tabBarItemTextAttributes(textColor: UIColor) -> [NSAttributedString.Key : Any] {
        return [
            NSAttributedString.Key.foregroundColor: textColor,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10.0)
        ] as [NSAttributedString.Key : Any]
    }
    
    private func createTabBar(with viewControllers: [UIViewController]) -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.barTintColor = .white
        tabBarController.tabBar.tintColor = .black
        tabBarController.tabBar.unselectedItemTintColor = .lightGray
        tabBarController.viewControllers = viewControllers
        return tabBarController
    }
    
}

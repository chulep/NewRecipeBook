// 
//  FavoriteRouter.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 02.02.2023.
//

import UIKit

protocol FavoriteRoutingLogic {
    func navigateToDetail(indexPath: IndexPath)
}

protocol FavoriteDataPassing {
    var dataStore: FavoriteDataStore? { get }
}

class FavoriteRouter: FavoriteDataPassing {
    
    var dataStore: FavoriteDataStore?
    weak var viewController: UIViewController?
}

extension FavoriteRouter: FavoriteRoutingLogic {
    
    //MARK: - Navigate methods

    func navigateToDetail(indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        var nextDataStore = detailViewController.router?.dataStore
        let mainDataStore = dataStore
        nextDataStore?.data = mainDataStore?.recipes?[indexPath.row]
        let navController = UINavigationController(rootViewController: detailViewController)
        navController.modalPresentationStyle = .fullScreen
        viewController?.present(navController, animated: true)
    }
}

//
//  BookRouter.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 05.01.2023.
//

import UIKit

protocol BookRoutingLogic {
    func navigateToAdd()
    func navigateToDetail(indexPath: IndexPath)
    func navigateToCategory(category: String)
}

protocol BookDataPassing {
    var dataStore: BookDataStore? { get }
}

final class BookRouter: BookRoutingLogic, BookDataPassing {
    
    //MARK: - Properties
    
    weak var viewController: UIViewController?
    var dataStore: BookDataStore?
    
    //MARK: - Methods
    
    func navigateToAdd() {
        let addViewController = AddBaseInformationViewController()
        let navController = UINavigationController(rootViewController: addViewController)
        navController.modalPresentationStyle = .fullScreen
        viewController?.present(navController, animated: true)
    }
    
    func navigateToDetail(indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        let navgationController = UINavigationController(rootViewController: detailViewController)
        navgationController.modalPresentationStyle = .fullScreen
        var nextDataStore = detailViewController.router?.dataStore
        let mainDataStore = dataStore
        nextDataStore?.data = mainDataStore?.data?[indexPath.row]
        viewController?.present(navgationController, animated: true)
    }
    
    func navigateToCategory(category: String) {
        let categoryViewController = SelectCategoryViewController()
        var nextDataStore = categoryViewController.router?.dataStore
        nextDataStore?.category = category
        let navigationController = UINavigationController(rootViewController: categoryViewController)
        viewController?.present(navigationController, animated: true)
    }
}

// 
//  SelectCategoryRouter.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 21.01.2023.
//

import UIKit

protocol SelectCategoryRoutingLogic {
    func navigateToDetailScene(indexPath: IndexPath)
    func dismiss()
}

protocol SelectCategoryDataPassing {
    var dataStore: SelectCategoryDataStore? { get }
}

class SelectCategoryRouter: SelectCategoryDataPassing {
    
    //MARK: - Properties
    
    var dataStore: SelectCategoryDataStore?
    weak var viewController: UIViewController?
}

extension SelectCategoryRouter: SelectCategoryRoutingLogic {
    
    //MARK: - Methods

    func navigateToDetailScene(indexPath: IndexPath) {
        let detailVC = DetailViewController()
        var nextDataStore = detailVC.router?.dataStore
        let mainDataStore = dataStore
        nextDataStore?.data = mainDataStore?.data?[indexPath.row]
        let navigationController = UINavigationController(rootViewController: detailVC)
        navigationController.modalPresentationStyle = .fullScreen
        viewController?.present(navigationController, animated: true)
    }
    
    func dismiss() {
        viewController?.dismiss(animated: true)
    }
}

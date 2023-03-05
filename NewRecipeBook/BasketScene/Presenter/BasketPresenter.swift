// 
//  BasketPresenter.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 03.02.2023.
//

import Foundation

protocol BasketPresentationLogic {
    func presentData(data: BasketModels.FecthData.Response)
}

class BasketPresenter {
    weak var viewController: BasketDisplayLogic?
}

extension BasketPresenter: BasketPresentationLogic {
    
    //MARK: - Present Method
    
    func presentData(data: BasketModels.FecthData.Response) {
        let viewModel = BasketModels.FecthData.ViewModel(ingredients: data.ingredients)
        viewController?.displaying(data: viewModel)
    }

}

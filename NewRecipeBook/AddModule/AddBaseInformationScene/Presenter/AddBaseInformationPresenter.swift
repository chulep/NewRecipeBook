// 
//  AddBaseInformationPresenter.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 11.01.2023.
//

import Foundation

protocol AddBaseInformationPresentationLogic {
    func presentData(data: AddBaseInformationModels.FetchData.Response)
}

class AddBaseInformationPresenter {
    weak var viewController: AddBaseInformationDisplayLogic?
}

extension AddBaseInformationPresenter: AddBaseInformationPresentationLogic {
    
    //MARK: - Methods
    
    func presentData(data: AddBaseInformationModels.FetchData.Response) {
        let categoryString = data.category.map { category in
            category.name
        }
        viewController?.displaying(data: AddBaseInformationModels.FetchData.ViewModel(category: categoryString))
    }

}

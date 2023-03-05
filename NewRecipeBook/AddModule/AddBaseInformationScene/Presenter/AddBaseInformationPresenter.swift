// 
//  AddBaseInformationPresenter.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 11.01.2023.
//

import Foundation

protocol AddBaseInformationPresentationLogic {
    func presentData(model: AddBaseInformationModels.FetchData.Response)
}

class AddBaseInformationPresenter {
    weak var viewController: AddBaseInformationDisplayLogic?
}

extension AddBaseInformationPresenter: AddBaseInformationPresentationLogic {
    
    //MARK: - Methods
    
    func presentData(model: AddBaseInformationModels.FetchData.Response) {
        var categoryString = [String]()
        for i in NameHelper.allCategories {
            categoryString.append(i.name)
        }
        let viewModel = AddBaseInformationModels.FetchData.ViewModel(category: categoryString)
        viewController?.displaying(viewModel: viewModel)
    }

}

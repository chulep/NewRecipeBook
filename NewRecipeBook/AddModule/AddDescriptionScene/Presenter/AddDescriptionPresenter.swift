// 
//  AddDescriptionScenePresenter.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 08.01.2023.
//

import Foundation

protocol AddDescriptionPresentationLogic {
    func presentData(model: AddDescriptionModels.FetchData.Response)
}

class AddDescriptionPresenter {
    weak var viewController: AddDescriptionViewController?
}

extension AddDescriptionPresenter: AddDescriptionPresentationLogic {
    
    //MARK: - Presentation Method
    
    func presentData(model: AddDescriptionModels.FetchData.Response) {
        let viewModel = AddDescriptionModels.FetchData.ViewModel(description: model.description)
        viewController?.displaying(viewModel: viewModel)
    }

}

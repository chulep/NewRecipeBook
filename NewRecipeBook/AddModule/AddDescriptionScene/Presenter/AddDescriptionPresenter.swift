// 
//  AddDescriptionScenePresenter.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 08.01.2023.
//

import Foundation

protocol AddDescriptionPresentationLogic {
    func presentData(data: AddDescriptionModels.FetchData.Response)
}

class AddDescriptionPresenter {
    weak var viewController: AddDescriptionViewController?
}

extension AddDescriptionPresenter: AddDescriptionPresentationLogic {
    
    //MARK: - Presentation Method
    
    func presentData(data: AddDescriptionModels.FetchData.Response) {
        viewController?.displaying(data: AddDescriptionModels.FetchData.ViewModel(description: data.description))
    }

}

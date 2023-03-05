// 
//  NewPresenter.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 06.01.2023.
//

import Foundation

protocol NewPresentationLogic {
    func presentData()
}

class NewPresenter {
    weak var viewController: NewDisplayLogic?
}

extension NewPresenter: NewPresentationLogic {
    
    func presentData() {
        //data viewModel to viewController
        viewController?.displaying()
    }

}
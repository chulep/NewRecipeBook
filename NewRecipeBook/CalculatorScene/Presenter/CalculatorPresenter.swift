// 
//  CalculatorPresenter.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 05.02.2023.
//

import Foundation

protocol CalculatorPresentationLogic {
    func presentData(data: CalculatorModels.FecthData.Response)
}

class CalculatorPresenter {
    weak var viewController: CalculatorDisplayLogic?
}

extension CalculatorPresenter: CalculatorPresentationLogic {
    
    //MARK: - Present Method
    
    func presentData(data: CalculatorModels.FecthData.Response) {
        let cup = Double(round(data.cup * 10) / 10)
        let spoon = Double(round(data.spoon * 10) / 10)
        let viewModel = CalculatorModels.FecthData.ViewModel(cup: String(cup), spoon: String(spoon))
        viewController?.displaying(data: viewModel)
    }

}

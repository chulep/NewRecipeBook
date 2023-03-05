// 
//  CalculatorInteractor.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 05.02.2023.
//

import Foundation

protocol CalculatorBusinessLogic {
    func fetchData(data: CalculatorModels.FecthData.Request)
}

protocol CalculatorDataStore {
    var data: String? { get set }
}

class CalculatorInteractor: CalculatorBusinessLogic, CalculatorDataStore {
    
    //MARK: - Properties
    
    var presenter: CalculatorPresentationLogic?
    var data: String?
    
    //MARK: - Fetch Data
    
    func fetchData(data: CalculatorModels.FecthData.Request) {
        let number = data.number
        switch data.select {
        case 0:
            let dataFromPresenter = CalculatorModels.FecthData.Response(cup: number / data.flourCup, spoon: number / data.flourSpoon)
            presenter?.presentData(data: dataFromPresenter)
        case 1:
            let dataFromPresenter = CalculatorModels.FecthData.Response(cup: number / data.sugarCup, spoon: number / data.sugarSpoon)
            presenter?.presentData(data: dataFromPresenter)
        case 2:
            let dataFromPresenter = CalculatorModels.FecthData.Response(cup: number / data.grainCup, spoon: number / data.grainSpoon)
            presenter?.presentData(data: dataFromPresenter)
        default:
            break
        }
    }
}

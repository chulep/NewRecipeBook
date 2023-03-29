// 
//  DetailPresenter.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 17.01.2023.
//

import Foundation

protocol DetailPresentationLogic {
    func presentData(data: DetailModels.FecthData.Response)
    func presentShare(data: DetailModels.FecthData.Response)
}

class DetailPresenter {
    weak var viewController: DetailDisplayLogic?
}

extension DetailPresenter: DetailPresentationLogic {
    
    //MARK: - Presented Method
    
    func presentData(data: DetailModels.FecthData.Response) {
        let viewModel = DetailModels.FecthData.ViewModel(name: data.recipe.name,
                                                         image: data.recipe.image,
                                                         ingredients: data.recipe.ingredients,
                                                         description: data.recipe.descriptions,
                                                         isFavorite: data.recipe.isFavorite)
        viewController?.displaying(data: viewModel)
    }
    
    func presentShare(data: DetailModels.FecthData.Response) {
        var text = "\(data.recipe.name ?? "")\n \nИнгредиенты:\(createText(array: data.recipe.ingredients))\n \nОписание:\(createText(array: data.recipe.descriptions))"
        viewController?.shareDisplaying(data: DetailModels.FecthData.ShareViewModel(text: text))
    }
    
    private func createText(array: [String]?) -> String {
        var number = 0
        var text = ""
        guard let array = array else { return text}
        for i in array {
            number += 1
            text.append("\n\(number). \(i)")
        }
        return text
    }
}

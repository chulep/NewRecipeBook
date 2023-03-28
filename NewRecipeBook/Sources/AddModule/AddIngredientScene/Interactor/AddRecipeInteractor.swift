//
//  AddRecipeInteractor.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 05.01.2023.
//

import Foundation

protocol AddIngredientBusinessLogic {
    func fetchData()
    func saveData(text: String)
}

protocol AddIngredientDataStore {
    var saveData: AddBaseInformationModels.SaveData.Request? { get set }
    var saveIngredientData: AddIngredientModels.SaveData.Request? { get set }
}

final class AddIngredientInteractor: AddIngredientBusinessLogic, AddIngredientDataStore {
    
    //MARK: - Properties
    
    var presenter: AddIngredientPresentationLogic?
    var saveData: AddBaseInformationModels.SaveData.Request?
    var saveIngredientData: AddIngredientModels.SaveData.Request?
    
    //MARK: - Fetch Data
    
    func fetchData() {
        guard let data = saveIngredientData?.ingredients else { return }
        let presenterModel = AddIngredientModels.FetchData.Response(ingredients: data)
        presenter?.presentData(data: presenterModel)
    }
    
    //MARK: - Save Data
    
    func saveData(text: String) {
        guard let saveData = saveData else { return }
        if saveIngredientData == nil {
            saveIngredientData = AddIngredientModels.SaveData.Request(name: saveData.name, category: saveData.category, imageData: saveData.image, ingredients: [text])
        } else {
            saveIngredientData?.ingredients.append(text)
        }
    }
}

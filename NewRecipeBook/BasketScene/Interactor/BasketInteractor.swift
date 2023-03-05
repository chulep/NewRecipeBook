// 
//  BasketInteractor.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 03.02.2023.
//

import Foundation

protocol BasketBusinessLogic {
    func fetchData()
    func clearAll()
    func deleteItem(indexPath: IndexPath)
}

protocol BasketDataStore {
    var data: String? { get set }
}

class BasketInteractor: BasketBusinessLogic, BasketDataStore {
    
    //MARK: - Properties
    
    var presenter: BasketPresentationLogic?
    var data: String?
    
    //MARK: - Fetch Data
    
    func fetchData() {
        let basketdata = UserDefaults.standard.object(forKey: ConstantHelper.basketKey) as? [String] ?? [String]()
        presenter?.presentData(data: BasketModels.FecthData.Response(ingredients: basketdata))
    }
    
    //MARK: - Delete Methods
    
    func clearAll() {
        UserDefaults.standard.set(nil, forKey: ConstantHelper.basketKey)
        presenter?.presentData(data: BasketModels.FecthData.Response(ingredients: [String]()))
    }
    
    func deleteItem(indexPath: IndexPath) {
        guard var basketdata = UserDefaults.standard.object(forKey: ConstantHelper.basketKey) as? [String] else { return }
        basketdata.remove(at: indexPath.row)
        UserDefaults.standard.set(basketdata, forKey: ConstantHelper.basketKey)
    }
}

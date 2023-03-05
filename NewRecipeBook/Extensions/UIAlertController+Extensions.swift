//
//  UIAlertController+Extensions.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 11.01.2023.
//

import UIKit

extension UIAlertController {
    func createCategoryAlert(name: [String], complation: @escaping (String) -> Void) -> UIAlertController {
        let alertController = UIAlertController(title: "Выберите категорию:", message: nil, preferredStyle: .actionSheet)
        for i in name {
            let button = UIAlertAction(title: i, style: .default) { action in
                complation(i)
            }
            alertController.addAction(button)
        }
        return alertController
    }
    
    func createIngredientController(completion: @escaping (String?) -> Void) -> UIAlertController {
        let alertController = UIAlertController(title: "Новый ингредиент", message: nil, preferredStyle: .alert)
        alertController.addTextField { name in
            name.placeholder = "Название"
        }
        alertController.addTextField { weight in
            weight.placeholder = "Вес (грамм)"
            weight.keyboardType = .numberPad
        }
        let confirmButton = UIAlertAction(title: "Добавить", style: .default) { tap in
            guard let textFields = alertController.textFields else { return }
            if textFields[0].text != "" && textFields[1].text != "" {
                completion(textFields[0].text! + " " + textFields[1].text!)
            }
        }
        alertController.addAction(confirmButton)
        return alertController
    }
    
    func basketCreateAlert(completion: @escaping () -> Void) -> UIAlertController {
        let alertController = UIAlertController(title: "Добавить в корзину?", message: nil, preferredStyle: .alert)
        let confirmButton = UIAlertAction(title: "OK", style: .default) { action in
            completion()
        }
        let cancelButton = UIAlertAction(title: "Отмена", style: .cancel)
        alertController.addAction(confirmButton)
        alertController.addAction(cancelButton)
        return alertController
    }
    
    func deleteAlert(completion: @escaping () -> Void) -> UIAlertController {
        let alertController = UIAlertController(title: "Удалить рецепт?", message: nil, preferredStyle: .alert)
        let confirmButton = UIAlertAction(title: "OK", style: .default) { action in
            completion()
        }
        let cancelButton = UIAlertAction(title: "Отмена", style: .cancel)
        alertController.addAction(confirmButton)
        alertController.addAction(cancelButton)
        return alertController
    }
}

//
//  NameHelper.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 03.03.2023.
//

import Foundation

struct NameHelper {
    
    //MARK: - Categories
    
    static let allCategories = [Category(name: "Напитки", imageName: "drink4"), Category(name: "Завтрак", imageName: "breakfast"), Category(name: "Обед", imageName: "lanch"), Category(name: "Ужин", imageName: "dinner"), Category(name: "Выпечка", imageName: "croissant")]
    
    struct Category {
        let name: String
        let imageName: String
    }
    
    //MARK: - Book scene
    
    struct BookScene {
        static let categoryLabelText = "Категории"
        static let allRecipeLabelText = "Все рецепты"
        static let helpLabelText = "Ничего не найдено"
    }
    
    //MARK: - Favorite scene
    
    struct FavoriteScene {
        static let helpLabelText = "Нет избранных рецептов"
    }
    
    //MARK: - Basket scene
    
    struct BasketScene {
        static let clearButtonText = "Очистить"
        static let helpLabelText = "Корзина пуста"
    }
    
    //MARK: - Add Module
    
    enum AddModule {
        struct BaseInformationScene {
            static let cancelButtonText = "Отмена"
            static let titleText = "Новый рецепт"
            static let nameTextFieldPlaceholderText = "Введите название"
            static let categoryLabelText = "Выберите категорию"
            static let confirmButtonText = "Продолжить"
        }
        
        struct IngredientScene {
            static let backButtonText = "Назад"
            static let titleText = "Ингредиенты"
            static let helpLabelText = "Добавьте ингредиенты нажав +"
            static let confirmButton = "Продолжить"
            
            struct NewIngredientView {
                static let cancelButtonText = "Отмена"
                static let nameTextFieldPlaceholderText = "Введите название"
                static let weightTextFieldPlaceholderText = "Кол-во"
                static let measureSegmentNames = ["Гр.", "Шт.", "Мл.", "Ст.л.", "Ч.л."]
                static let addButtonText = "Добавить"
            }
        }
        
        struct DescriptionScene {
            static let titleText = "Процесс"
            static let helpLabelText = "Добавьте этап нажав +"
            static let confirmButton = "Сохранить"
            
            struct NewDescriptionView {
                static let cancelButtonText = "Отмена"
                static let descriptionTextViewPlaceholderText = "Введите описание"
                static let addButtonText = "Добавить"
            }
        }
    }
    
    //MARK: - Detail scene
    
    struct DetailScene {
        static let backButtonText = "Закрыть"
        static let ingredientHeaderText = "Ингредиенты"
        static let basketButtonText = " В корзину"
        static let inBasketButtonText = " В корзине"
        static let calculatorButtonText = " Калькулятор"
        static let descriptionHeaderText = "Процесс приготовления"
        static let splashViewText = "Добавлено в корзину покупок"
    }
    
    //MARK: - Calculator scene
    
    struct CalculatorScene {
        static let backButtonText = "Назад"
        static let titleText = "Калькулятор"
        static let inputViewText = "Грамм"
        static let cupViewText = "Стаканы"
        static let spoonViewText = "Столовые ложки"
        static let productSegmentText = ["Мука", "Сахар", "Крупа"]
    }
    
    struct SelectCategoryScene {
        static let backButtonText = "Назад"
    }
}

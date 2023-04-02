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
    
    //MARK: - TabBar
    
    struct TabBar {
        static let bookTitle = "Рецепты"
        static let bookImage = "book"
        static let bookSelectImage = "book.fill"
        
        static let favotiteTitle = "Избранное"
        static let favoriteImage = "heart"
        static let favoriteSelectImage = "heart.fill"
        
        static let basketTitle = "Корзина"
        static let basketImage = "cart"
        static let basketSelectImage = "cart.fill"
    }
    
    //MARK: - Book scene
    
    struct BookScene {
        static let categoryLabelText = "Категории"
        static let allRecipeLabelText = "Все рецепты"
        static let noResultText = "Ничего не найдено\nВведите другое название"
        static let noRecipesText = "Добавьте свой первый рецепт"
    }
    
    //MARK: - Favorite scene
    
    struct FavoriteScene {
        static let helpLabelText = "Добавляйте любимые рецепты\nв избранное"
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
    
    //MARK: - Select Category scene
    struct SelectCategoryScene {
        static let backButtonText = "Назад"
        static let noRecipes = "Скоро тут будут рецепты..."
    }
    
    //MARK: - Alerts
    enum Alert {
        struct Category {
            static let titleText = "Выберите категорию:"
        }
        
        struct InBasket {
            static let titleText = "Добавить в корзину?"
            static let confirmButtonText = "OK"
            static let cancelButtonText = "Отмена"
        }
        
        struct Delete {
            static let titleText = "Удалить рецепт?"
            static let confirmButtonText = "OK"
            static let cancelButtonText = "Отмена"
        }
    }
}

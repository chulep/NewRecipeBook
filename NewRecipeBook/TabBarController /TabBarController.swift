//
//  TabBarController.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 05.01.2023.
//

import UIKit

class MyTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    //MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createControllers()
        tabBarApperanse()
    }

    //MARK: - VC for TabBar
    
    private func createControllers() {
        let bookViewController = BookViewController()
        bookViewController.tabBarItem.title = "Рецепты"
        bookViewController.tabBarItem.image = UIImage(systemName: "book")
        bookViewController.tabBarItem.selectedImage = UIImage(systemName: "book.fill")
        let bookNavController = UINavigationController(rootViewController: bookViewController)
        
        let favoriteViewController = FavoriteViewController()
        favoriteViewController.tabBarItem.title = "Избранное"
        favoriteViewController.tabBarItem.image = UIImage(systemName: "heart")
        favoriteViewController.tabBarItem.selectedImage = UIImage(systemName: "heart.fill")
        
        let basketViewController = BasketViewController()
        basketViewController.tabBarItem.title = "Корзина"
        basketViewController.tabBarItem.image = UIImage(systemName: "cart")
        basketViewController.tabBarItem.selectedImage = UIImage(systemName: "cart.fill")
        let basketNavController = UINavigationController(rootViewController: basketViewController)
        
        viewControllers = [
            bookNavController,
            favoriteViewController,
            basketNavController
        ]
    }
    
    //MARK: - TabBar style
    
    private func tabBarApperanse() {
        //прозрачный бэкграунд
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        tabBar.backgroundColor = .clear
        
        //основное оформление
        let positionOnX: CGFloat = 10
        let positionOnY: CGFloat = 14
        let width = tabBar.bounds.width - positionOnX * 2
        let heigth = tabBar.bounds.height + positionOnY * 2
        
        let roundRect = CGRect(x: positionOnX,
                               y: tabBar.bounds.minY - positionOnY,
                               width: width,
                               height: heigth)
        
        let bezierPath = UIBezierPath(roundedRect: roundRect,
                                      cornerRadius: heigth / 4)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezierPath.cgPath
        
        tabBar.layer.insertSublayer(shapeLayer, at: 0)
        tabBar.itemWidth = width / 5
        tabBar.itemPositioning = .centered
        
        shapeLayer.fillColor = UIColor.white.cgColor
        
        //бордер
        shapeLayer.lineWidth = 1
        shapeLayer.strokeColor = UIColor.gray.cgColor
        
        //цвет нажатой/отжатой кнопки
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .systemGray
    }
}

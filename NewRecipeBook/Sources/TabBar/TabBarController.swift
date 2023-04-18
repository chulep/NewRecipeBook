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
        bookViewController.tabBarItem.title = NameHelper.TabBar.bookTitle
        bookViewController.tabBarItem.image = UIImage(systemName: NameHelper.TabBar.bookImage)
        bookViewController.tabBarItem.selectedImage = UIImage(systemName: NameHelper.TabBar.bookSelectImage)
        let bookNavController = UINavigationController(rootViewController: bookViewController)
        
        let favoriteViewController = FavoriteViewController()
        favoriteViewController.title = NameHelper.TabBar.favotiteTitle
        favoriteViewController.tabBarItem.image = UIImage(systemName: NameHelper.TabBar.favoriteImage)
        favoriteViewController.tabBarItem.selectedImage = UIImage(systemName: NameHelper.TabBar.favoriteSelectImage)
        let favoriteNavController = UINavigationController(rootViewController: favoriteViewController)
        
        let basketViewController = BasketViewController()
        basketViewController.title = NameHelper.TabBar.basketTitle
        basketViewController.tabBarItem.image = UIImage(systemName: NameHelper.TabBar.basketImage)
        basketViewController.tabBarItem.selectedImage = UIImage(systemName: NameHelper.TabBar.basketSelectImage)
        let basketNavController = UINavigationController(rootViewController: basketViewController)
        
        viewControllers = [
            bookNavController,
            favoriteNavController,
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

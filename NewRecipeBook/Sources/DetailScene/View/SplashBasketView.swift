//
//  SplashBasketView.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 20.03.2023.
//

import UIKit

class SplashBasketView: UIView {
    
    //MARK: - UI Element
    
    private let label: UILabel = {
        $0.text = NameHelper.DetailScene.splashViewText
        $0.numberOfLines = 3
        $0.textAlignment = .center
        $0.textColor = ColorHelper.white
        return $0
    }(UILabel())
    
    //MARK: - Init
    
    convenience init(size: CGSize) {
        self.init(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        addSubview(label)
    }
    
    //MARK: - UI
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
        isHidden = true
        backgroundColor = ColorHelper.orange
        layer.cornerRadius = ConstantHelper.radius
        clipsToBounds = true
        alpha = 0
    }
    
    //MARK: - Animate Method
    
    func animate() {
        isHidden = false
        UIView.animate(withDuration: 0.2) {
            self.alpha = 1
        } completion: { _ in
            UIView.animate(withDuration: 1) {
                self.alpha = 0
            } completion: { _ in
                self.isHidden = true
            }
        }
    }
}

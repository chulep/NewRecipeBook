//
//  CategoryCollectionReusableView.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 17.01.2023.
//


import UIKit

class CategoryCollectionReusableView: UICollectionReusableView {
    
    static let identifire = "categoryView"
    
    weak var cellDelegate: TableViewCellDelegate?
    private var category = NameHelper.allCategories
    
    //MARK: - UI Elements
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: setupFlowLayout())
    
    private let titleLabel: UILabel = {
        $0.text = NameHelper.BookScene.categoryLabelText
        $0.font = UIFont.boldSystemFont(ofSize: 25)
        return $0
    }(UILabel())
    
    //MARK: - LayoutSubviews
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupCollectionView()
        createUI()
    }
    
    //MARK: - Create UI
    
    private func createUI() {
        addSubview(collectionView)
        addSubview(titleLabel)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifire)
    }
    
    private func setupFlowLayout() -> UICollectionViewFlowLayout {
        let cellSide = bounds.height - 55
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: cellSide / 1.2, height: cellSide)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        return flowLayout
    }
}

//MARK: - CollectionView Delegate & DataSourse

extension CategoryCollectionReusableView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifire, for: indexPath) as! CategoryCollectionViewCell
        let name = category[indexPath.row].name
        let imageData = UIImage(named: category[indexPath.row].imageName)?.pngData()
        cell.setData(text: name, imageData: imageData)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectCategory = category[indexPath.row]
        cellDelegate?.tapToCell(indexPath: indexPath, text: selectCategory.name)
    }
}

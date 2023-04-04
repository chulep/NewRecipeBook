// 
//  FavoriteViewController.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 02.02.2023.
//

import UIKit

protocol FavoriteDisplayLogic: AnyObject {
    func displaying(data: FavoriteModels.FecthData.ViewModel)
}

class FavoriteViewController: UIViewController {
    
    var interactor: FavoriteBusinessLogic?
    private(set) var router: (FavoriteRoutingLogic & FavoriteDataPassing)?
    private var data: FavoriteModels.FecthData.ViewModel?
    
    //MARK: - UI Elements
    
    lazy private var collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createFlowLayout())
    lazy private var warningView = WarningView(text: NameHelper.FavoriteScene.helpLabelText, image: ImageHelper.noFavorite, frame: view.bounds)
    
    
    // MARK: - Init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.fetchData()
    }
    
    //MARK: - setup VIP

    private func setup() {
        let interactor = FavoriteInteractor()
        let presenter = FavoritePresenter()
        let router = FavoriteRouter()

        interactor.presenter = presenter
        presenter.viewController = self
        router.viewController = self
        router.dataStore = interactor

        self.interactor = interactor
        self.router = router
    }
    
    //MARK: - Create UI

    private func createUI() {
        view.addSubview(collectionView)
        view.addSubview(warningView)
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FavoriteCollectionViewCell.self, forCellWithReuseIdentifier: FavoriteCollectionViewCell.identifire)
    }
    
    private func createFlowLayout() -> UICollectionViewFlowLayout {
        let cellSide = view.bounds.width / 2
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: cellSide - 30, height: cellSide * 1.2 - 28)
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
        flowLayout.minimumLineSpacing = 20
        return flowLayout
    }
}

//MARK: - Displaying Method

extension FavoriteViewController: FavoriteDisplayLogic {
    func displaying(data: FavoriteModels.FecthData.ViewModel) {
        self.data = data
        collectionView.reloadData()
        warningView.isHidden(count: data.displayRecipes.count)
    }
}

//MARK: - CollectionView Delegate & DataSuorse

extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.displayRecipes.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCollectionViewCell.identifire, for: indexPath) as! FavoriteCollectionViewCell
        let name = data?.displayRecipes[indexPath.row].name
        let image = data?.displayRecipes[indexPath.row].image
        cell.setData(title: name, imageData: image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router?.navigateToDetail(indexPath: indexPath)
    }
}

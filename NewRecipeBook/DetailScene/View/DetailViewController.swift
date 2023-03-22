// 
//  DetailViewController.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 17.01.2023.
//

import UIKit

protocol DetailDisplayLogic: AnyObject {
    func displaying(data: DetailModels.FecthData.ViewModel)
}

class DetailViewController: UIViewController {
    
    var interactor: DetailBusinessLogic?
    private(set) var router: (DetailRoutingLogic & DetailDataPassing)?
    private var viewModel: DetailModels.FecthData.ViewModel?
    
    //MARK: - UI Elements
    
    lazy private var tableView = UITableView(frame: view.bounds, style: .grouped)
    lazy private var splashView = SplashBasketView(size: CGSize(width: view.bounds.width / 2, height: view.bounds.width / 4))
    
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
        interactor?.fetchData()
        setupTableView()
        setupNavBar()
        createUI()
    }
    
    //MARK: - Setup VIP

    private func setup() {
        let interactor = DetailInteractor()
        let presenter = DetailPresenter()
        let router = DetailRouter()

        interactor.presenter = presenter
        presenter.viewController = self
        router.viewController = self
        router.dataStore = interactor

        self.interactor = interactor
        self.router = router
    }

    //MARK: - Create UI
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.alwaysBounceVertical = false
        tableView.separatorStyle = .none
        tableView.sectionHeaderTopPadding = -20
        tableView.register(PhotoTableViewHeader.self, forHeaderFooterViewReuseIdentifier: PhotoTableViewHeader.identifire)
        tableView.register(TitleTableViewHeader.self, forHeaderFooterViewReuseIdentifier: TitleTableViewHeader.identifire)
        tableView.register(ButtonsTableViewFooter.self, forHeaderFooterViewReuseIdentifier: ButtonsTableViewFooter.identifire)
        tableView.register(AddTableViewCell.self, forCellReuseIdentifier: AddTableViewCell.identifire)
        tableView.register(AddDescriptionTableViewCell.self, forCellReuseIdentifier: AddDescriptionTableViewCell.identifire)
    }
    
    private func setupNavBar() {
        title = viewModel?.name
        navigationController?.navigationBar.tintColor = ColorHelper.white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: NameHelper.DetailScene.backButtonText, image: nil, target: self, action: #selector(tapToCancel))
        let raightButtonsArray = [
            UIBarButtonItem(image: UIImage(isFavorite: viewModel?.isFavorite), style: .done, target: self, action: #selector(tapToFavorite)),
            UIBarButtonItem(image: UIImage(systemName: "trash"), style: .done, target: self, action: #selector(tapToDelete))
        ]
        navigationItem.rightBarButtonItems = raightButtonsArray
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.setBarColor(backgroundColor: ColorHelper.orange, itemsColor: ColorHelper.white)
    }
    
    private func createUI() {
        view.addSubview(splashView)
        splashView.center = view.center
    }
    
    //MARK: - Action Methods
    
    @objc private func tapToCancel() {
        router?.dismiss()
    }
    
    @objc private func tapToFavorite() {
        interactor?.addToFavorite()
    }
    
    @objc private func tapToDelete() {
        let alert = UIAlertController.Factory.deleteAlert {
            self.interactor?.deleteRecipe()
            self.router?.dismiss()
        }
        present(alert, animated: true)
    }
    
    @objc func tapToBasket(_ button: UIButton) {
        let alert = UIAlertController.Factory.basketCreateAlert { [weak self] in
            self?.interactor?.saveBasket(ingredients: self?.viewModel?.ingredients)
            button.setTitle(NameHelper.DetailScene.inBasketButtonText, for: .normal)
            button.setImage(UIImage(systemName: "cart.fill.badge.plus"), for: .normal)
            self?.splashView.animate()
        }
        present(alert, animated: true)
    }
    
    @objc func tapToCalculator() {
        router?.navigateToCalculator()
    }
}

//MARK: - Displaying Method

extension DetailViewController: DetailDisplayLogic {
    func displaying(data: DetailModels.FecthData.ViewModel) {
        self.viewModel = data
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(isFavorite: data.isFavorite), style: .done, target: self, action: #selector(tapToFavorite))
        tableView.reloadData()
    }
}

//MARK: - TableView Delegate & DataSourse

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:
            return viewModel?.ingredients?.count ?? 0
        case 2:
            return viewModel?.description?.count ?? 0
        default:
            return 0
        }
    }
    
    // set cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: AddTableViewCell.identifire, for: indexPath) as! AddTableViewCell
            cell.setData(text: viewModel?.ingredients?[indexPath.row])
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: AddDescriptionTableViewCell.identifire) as! AddDescriptionTableViewCell
            let descriptionCellData = viewModel?.description?[indexPath.row]
            cell.setData(text: descriptionCellData, indexPath: indexPath)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    // set header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: PhotoTableViewHeader.identifire) as? PhotoTableViewHeader
            header?.setImage(data: viewModel?.image)
            return header
        case 1:
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: TitleTableViewHeader.identifire) as? TitleTableViewHeader
            header?.setTitle(text: NameHelper.DetailScene.ingredientHeaderText, aligment: .justified)
            return header
        case 2:
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: TitleTableViewHeader.identifire) as? TitleTableViewHeader
            header?.setTitle(text: NameHelper.DetailScene.descriptionHeaderText, aligment: .natural)
            return header
        default:
            return nil
        }
    }
    
    // set footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        switch section {
        case 1:
            let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: ButtonsTableViewFooter.identifire) as? ButtonsTableViewFooter
            return footer
        default:
            return nil
        }
    }
    
    // hide photo hrader
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            if viewModel?.image == nil {
                return 0
            } else {
                return view.bounds.width / 1.5
            }
        default:
            return 40
        }
    }
    
    // size
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 1:
            return 55
        default:
            return 10
        }
    }
}

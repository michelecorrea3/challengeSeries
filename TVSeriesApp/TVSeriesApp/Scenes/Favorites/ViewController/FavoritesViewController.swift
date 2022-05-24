//
//  FavoritesViewController.swift
//  TVSeriesApp
//
//  Created by Michele de Olivio Corrêa on 24/05/22.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    // MARK: - UI Properties

    @IBOutlet weak var tableView: UITableView?
    
    private let emptyView = EmptyView()
    private let loadingView = LoadingView()
    private let searchController = UISearchController(searchResultsController: nil)

    // MARK: - Public properties
    
    var selectedCellIndex: Int?

    // MARK: - Private properties

    private let viewModel = FavoritesViewModel()

    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        viewModel.loadFavorites()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        emptyView.hideEmptyView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? SeriesDetailViewController,
              let index = selectedCellIndex  else { return }
        destination.seriesId = viewModel.getViewData(index: index).id
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
    }
    
    // MARK: - Private methods
    
    private func setupViews() {
        tabBarController?.tabBar.backgroundColor = .lightGray

        view.backgroundColor = .white

        setupTableView()
        setupDataBinding()
    }
    
    private func setupTableView() {
        tableView?.delegate = self
        tableView?.dataSource = self
    }
    
    private func setupDataBinding() {
        viewModel.state.bind { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .initial:
                break
            case .loading:
                self.loadingView.showIndicator(in: self.view)
            case .empty:
                self.loadingView.hideIndicator()
                self.emptyView.showEmptyView(in: self.view)
            case .data:
                self.tableView?.reloadData()
                self.loadingView.hideIndicator()
            case .none:
                break
            }
        }
    }
}

// MARK: - Extensions

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SeriesInfoCell.self), for: indexPath) as? SeriesInfoCell else {
            return UITableViewCell()
        }
        
        let viewData = viewModel.getViewData(index: indexPath.row)
        cell.setupCell(viewData: SeriesInfoCellViewData(title: viewData.title, urlImage: viewData.urlImage, id: viewData.id, isFavorited: viewData.isFavorite))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedCellIndex = indexPath.row
        performSegue(withIdentifier: "SeriesDetailViewControllerSegue", sender: nil)
    }
}

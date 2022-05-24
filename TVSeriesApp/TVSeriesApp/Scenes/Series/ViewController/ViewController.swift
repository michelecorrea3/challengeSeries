//
//  ViewController.swift
//  TVSeriesApp
//
//  Created by Michele de Olivio Corrêa on 20/05/22.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - UI Properties

    @IBOutlet weak var loadMoreView: UIActivityIndicatorView?
    @IBOutlet var tableView: UITableView?
    @IBOutlet weak var loadingMoreHeight: NSLayoutConstraint?
    
    private let errorView = ErrorView()
    private let loadingView = LoadingView()
    private let searchController = UISearchController(searchResultsController: nil)

    // MARK: - Public properties
    
    var selectedCellIndex: Int?
    
    // MARK: - Private properties

    private let viewModel = SeriesViewModel()

    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
                
        setupViews()
        
        viewModel.loadSeries()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? SeriesDetailViewController,
              let index = selectedCellIndex  else { return }
        destination.seriesId = viewModel.getViewData(index: index).id
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
    }
    
    // MARK: - Private methods
    
    private func setupViews() {
        view.backgroundColor = .white
        loadingMoreHeight?.constant = 0

        setupTableView()
        setupSearchBar()
        setupDataBinding()
    }
    
    private func setupSearchBar() {
        searchController.searchBar.placeholder = "Search for tv series"
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
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
            case .loadingMore:
                self.loadingMoreHeight?.constant = 40
                self.loadMoreView?.startAnimating()
            case .loading:
                self.loadingView.showIndicator(in: self.view)
            case .error:
                self.loadingView.hideIndicator()
                self.errorView.showError(in: self.view, delegate: self)
            case .data:
                self.loadingMoreHeight?.constant = 0
                self.loadMoreView?.stopAnimating()
                self.tableView?.reloadData()
                self.loadingView.hideIndicator()
            case .none:
                break
            }
        }
    }
}

// MARK: - Extensions

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if viewModel.displaySearchError() {
            let cell = UITableViewCell()
            let label = UILabel(frame: CGRect(x: 20, y: 20, width: cell.bounds.width, height: 100))
            label.text = "Ops, tv series not found!"
            cell.addSubview(label)
            cell.backgroundColor = .white
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SeriesInfoCell.self), for: indexPath) as? SeriesInfoCell else {
            return UITableViewCell()
        }
        
        let viewData = viewModel.getViewData(index: indexPath.row)
        cell.setupCell(viewData: viewData)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedCellIndex = indexPath.row

        performSegue(withIdentifier: "SeriesDetailViewControllerSegue", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !viewModel.isSearching && indexPath.row + 1 == viewModel.numberOfRowsInSection() {
            viewModel.loadSeries(resetPageCount: false)
        }
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        viewModel.searchSeries(for: searchBar.text ?? "")
        searchController.isActive = false
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchTextDidChange(searchText)
    }
}

extension ViewController: ErrorViewDelegate {
    func tryAgain() {
        viewModel.loadSeries()
    }
}

//
//  SeriesDetail.swift
//  TVSeriesApp
//
//  Created by Michele de Olivio Corrêa on 21/05/22.
//

import UIKit

class SeriesDetailViewController: UIViewController {
    
    // MARK: - UI Properties

    @IBOutlet weak var tableView: UITableView?
    
    private let errorView = ErrorView()
    private let loadingView = LoadingView()
    
    // MARK: - Public properties

    var seriesId: Int?
    
    // MARK: - Private properties

    private let viewModel: SeriesDetailViewModelProtocol
    private var selectedCellIndexPath: IndexPath?
    
    // MARK: - Initializers
    
    init(viewModel: SeriesDetailViewModelProtocol = SeriesDetailViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = SeriesDetailViewModel()
        super.init(coder: coder)
    }
    
    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        
        viewModel.loadSeriesDetails(with: seriesId)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? EpisodesDetailsViewController,
              let indexPath = selectedCellIndexPath else { return }
        let params = viewModel.getParamsDTO(indexPath: indexPath)
        destination.viewModel.setupParams(with: params)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
    }
    
    // MARK: - Private methods

    private func setupViews() {
        tabBarController?.tabBar.backgroundColor = .lightGray
        
        setupTableView()
        setupDataBinding()
    }
    
    private func setupTableView() {
        tableView?.delegate = self
        tableView?.dataSource = self
        
        tableView?.rowHeight = UITableView.automaticDimension
        tableView?.estimatedRowHeight = UITableView.automaticDimension
    }
    
    private func setupDataBinding() {
        viewModel.state.bind { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .initial:
                break
            case .loading:
                self.loadingView.showIndicator(in: self.view)
            case .error:
                self.loadingView.hideIndicator()
                self.errorView.showError(in: self.view, delegate: self)
            case .data:
                self.loadingView.hideIndicator()
                self.tableView?.reloadData()
            case .none:
                break
            }
        }
    }
    
}

// MARK: - Extensions

extension SeriesDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsForSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 && indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SeriesDetailHeaderCell.self), for: indexPath) as? SeriesDetailHeaderCell,
                  let viewData = viewModel.data else {
                return UITableViewCell()
            }
            
            cell.setupDetails(viewData: viewData)
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SeriesDetailEpisodeCell.self), for: indexPath) as? SeriesDetailEpisodeCell else {
            return UITableViewCell()
        }
        
        let text = viewModel.data?.episodeName(section: indexPath.section, index: indexPath.row) ?? ""
        cell.setupCell(viewData: SeriesDetailEpisodeViewData(name: text))
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.data?.seasonName(section: section)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedCellIndexPath = indexPath
        performSegue(withIdentifier: "EpisodesDetailsViewControllerSegue", sender: nil)
    }
}

extension SeriesDetailViewController: ErrorViewDelegate {
    func tryAgain() {
        viewModel.loadSeriesDetails(with: seriesId)
    }
}

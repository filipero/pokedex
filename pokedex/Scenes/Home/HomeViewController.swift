//
//  HomeViewController.swift
//  pokedex
//
//  Created by Filipe Rodrigues Oliveira on 07/02/24.
//

import UIKit

final class HomeViewController: UIViewController {
    private lazy var baseView: HomeView = {
        let view = HomeView()
        return view
    }()

    let viewModel: HomeViewModelProtocol
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: .main)
        viewModel.setHomeDelegate(self)
        baseView.tableView.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func loadView() {
        super.loadView()
        view = baseView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinds()
    }

    private func setupBinds() {
        title = viewModel.screenTitle
        viewModel.requestCharacters()
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = self.viewModel.characterDataSource.models.count - 1
        if indexPath.row == lastElement && !viewModel.isLoadingData {
            viewModel.requestCharacters()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCharacter = viewModel.characterDataSource.models[indexPath.row].character
        viewModel.goToDetailsScreen(character: selectedCharacter)
    }
}

extension HomeViewController: HomeDelegate {
    func scrollToTop() {
        let indexPath = IndexPath(row: 0, section: 0)
        self.baseView.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }

    func updateTableView() {
        DispatchQueue.main.async {
            self.baseView.tableView.dataSource = self.viewModel.characterDataSource
            self.baseView.tableView.reloadData()
        }
    }
}

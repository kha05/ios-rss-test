//
//  ViewController.swift
//  RssToilets
//
//  Created by Ha Kevin on 16/02/2024.
//

import UIKit

final class ToiletListViewController: UIViewController {
    enum Constant {
        static let cellIdentifier = "cellIdentifier"
    }
    // MARK: - Subviews

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionFooterHeight = 0
        tableView.register(ToiletViewCell.self, forCellReuseIdentifier: Constant.cellIdentifier)
        return tableView
    }()

    private lazy var filterButton: UIBarButtonItem = {
        return UIBarButtonItem(
            title: presenter.filterStatus.rawValue,
            style: .done,
            target: self,
            action: #selector(updateFilter)
        )
    }()

    // MARK: - Dependencies

    private var presenter: ToiletListPresenter

    // MARK: - Init

    init(presenter: ToiletListPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        bindToPresenter()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInterface()
        presenter.fetchToilets()
    }

    func bind(coordinator: ToiletsCoordinatorDelegate) {
        presenter.bindWith(coordinator: coordinator)
    }
}

// MARK: Table view datasource

extension ToiletListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.viewModelsFiltered.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.cellIdentifier, for: indexPath) as! ToiletViewCell
        guard indexPath.row < presenter.viewModelsFiltered.count  else { return cell }
        cell.configure(with: presenter.viewModelsFiltered[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

// MARK: Table view delegate

extension ToiletListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.showToiletDetail(index: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

private extension ToiletListViewController {
    func setupInterface() {
        navigationItem.rightBarButtonItem = filterButton
        navigationItem.title = "Toilet list"
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

    func bindToPresenter() {
        presenter.didUpdate = { [weak self] in
            self?.tableView.reloadData()
        }
    }

    @objc
    func updateFilter() {
        presenter.filter()
        filterButton.title = presenter.filterStatus.rawValue
    }
}

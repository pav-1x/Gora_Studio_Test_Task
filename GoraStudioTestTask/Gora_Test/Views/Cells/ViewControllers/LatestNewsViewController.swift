//
//  LatestNewsViewController.swift
//  Gora_Test
//
//  Created by Maksim Khlestkin on 13.03.2022
//

import UIKit
import SafariServices

class LatestNewsViewController: UIViewController {
    
    // MARK: - Properties
    private let networkManager = NetworkManager()
    private var news = [NewsCategories: News]()
    
    // MARK: - UITableView
    private let table: UITableView = {
        let table = UITableView(frame: CGRect.zero, style: .grouped)
        table.separatorStyle = .none
        table.backgroundColor = .systemGray5
        table.allowsSelection = false
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
       let indicator = UIActivityIndicatorView()
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        indicator.style = .medium
        return indicator
    }()
    
    // MARK: - UISearchController
    private lazy var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchResultsUpdater = self
        sc.obscuresBackgroundDuringPresentation = false
        sc.searchBar.placeholder = "Find news..."
        sc.searchBar.autocapitalizationType = .allCharacters
        return sc
    }()
    
    private func setupNavigationBar() {
        navigationItem.searchController = searchController
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: - Register UITableViewCells
    private func setupTableView() {
        table.register(NewTableViewCell.nib(), forCellReuseIdentifier: NewTableViewCell.identifier)
        table.dataSource = self
        table.delegate = self
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        view.addSubview(table)
        view.addSubview(activityIndicator)
        
        table.translatesAutoresizingMaskIntoConstraints = false
        table.heightAnchor.constraint(
            equalTo: view.heightAnchor).isActive = true
        table.widthAnchor.constraint(
            equalTo: view.widthAnchor).isActive = true
        
        activityIndicator.frame = view.bounds
    }
    
    // MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Last News"
        setupNavigationBar()
        setupConstraints()
        setupTableView()
        networkManager.fetchLastNews { [weak self] news in
            self?.news = news
            self?.table.reloadData()
        }
    }
    
}

// MARK: - Extension: UITableViewDataSource
extension LatestNewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: NewTableViewCell.identifier,
                for: indexPath) as? NewTableViewCell,
            let category = NewsCategories(
                rawValue: indexPath.section)
        else {
            return UITableViewCell()
        }
        cell.collectionView = nil
        cell.news = news[category]
        cell.delegate = self
        activityIndicator.stopAnimating()
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        news.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let category = NewsCategories(rawValue: section)
        return category?.name
    }
}

// MARK: - Extension: UITableViewDelegate
extension LatestNewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        250
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = UIColor.black
        header.textLabel?.font = UIFont(name: "Avenir Next", size: 19)
        header.textLabel?.frame = header.bounds
        header.textLabel?.textAlignment = .left
    }
    
}

// MARK: - Extension: UISearchResultsUpdating
extension LatestNewsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let _ = searchController.searchBar.text else { return }
    }
    
}

extension LatestNewsViewController: SafariDelegate {
    func openArticle(by url: URL) {
        let vc = SFSafariViewController(url: url)
        vc.delegate = self
        self.present(vc, animated: true)
    }
}

extension LatestNewsViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true)
    }
}

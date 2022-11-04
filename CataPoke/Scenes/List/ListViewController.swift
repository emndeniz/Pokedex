//
//  ListViewController.swift
//  CataPoke
//
//  Created by Emin on 3.11.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

final class ListViewController: UIViewController {

    // MARK: - Public properties -

    var presenter: ListPresenterInterface!
    
    // MARK: - Private properties -

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ListCell.self, forCellReuseIdentifier: ListCell.reuseIdentifier)
        tableView.backgroundColor = .defaultBackgroundColor
        tableView.separatorStyle = .none
        return tableView
    }()

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .defaultBackgroundColor
        title = "POKéMON"

        setupViews()
        presenter.getNewPokemons()

    }
    
    private func setupViews() {
        view.addSubview(tableView)

               NSLayoutConstraint.activate([
                   tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                   tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                   tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                   tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
               ])

        tableView.dataSource = self
        tableView.delegate = self
    }

}

// MARK: - Extensions -

extension ListViewController: ListViewInterface {
    func refreshList() {
        tableView.reloadData()
    }
    
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfCells
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.reuseIdentifier, for: indexPath) as! ListCell
        
        let data = presenter.cellForRowIndex(index: indexPath.row)
        cell.configureCel(specy: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100;
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        //let viewController = DetailsViewController(species: species[indexPath.row])
        //navigationController?.pushViewController(viewController, animated: true)
    }
}


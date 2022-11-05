//
//  DetailsViewController.swift
//  CataPoke
//
//  Created by Emin on 4.11.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit
import Kingfisher
import NVActivityIndicatorView

final class DetailsViewController: UIViewController {

    // MARK: - Public properties -

    var presenter: DetailsPresenterInterface!

    // MARK: - Private properties -
    
    

    
    private let indicator:NVActivityIndicatorView = {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let indicator = NVActivityIndicatorView(frame: frame, type: .ballRotateChase)
        indicator.color = .primaryColor
        indicator.startAnimating()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .cellBackgroundcolor
        return imageView
    }()
    
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .defaultBackgroundColor
        setupViews()
        
        presenter.viewDidLoad()
        indicator.startAnimating()
    }
    
    private func setupViews() {
        // TODO Feel free to set up the screen any way you like

        view.addSubview(imageView)
        view.addSubview(indicator)
        
        //nameLabel.text = "adasdasdasd"

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }


}

// MARK: - Extensions -

extension DetailsViewController: DetailsViewInterface {
    func updateUI(model: DetailsViewModel) {
        imageView.kf.setImage(with: model.imageURL,
                                 options: [
                                   .transition(.fade(1)),
                                   .cacheOriginalImage
                                 ])
        
        indicator.stopAnimating()
    }
    
}

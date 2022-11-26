//
//  DetailsPresenter.swift
//  Pokedex
//
//  Created by Emin on 4.11.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

final class DetailsPresenter {
    
    // MARK: - Private properties -
    
    private unowned let view: DetailsViewInterface
    private let interactor: DetailsInteractorInterface
    private let wireframe: DetailsWireframeInterface
    
    private let specyURL:URL
    // MARK: - Lifecycle -
    
    init(
        view: DetailsViewInterface,
        interactor: DetailsInteractorInterface,
        wireframe: DetailsWireframeInterface,
        specyURL:URL
    ) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        self.specyURL = specyURL
    }
}

// MARK: - Extensions -

extension DetailsPresenter: DetailsPresenterInterface {
    
    func viewDidLoad() {
        interactor.getDetails(url: specyURL) { [weak self] (result:Result<CompleteDetailResponse, APIError>) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.view.updateUI(model: response)
            case .failure(let err):
                self.showAlertToUser(error: err)
            }
        }
    }
    
    private func showAlertToUser(error:APIError) {
        if error == APIError.connectionProblem {
            self.wireframe.showAlert(with: "errorOoops".localized, message: "noInternetConnectionMessage".localized, completion: {
                self.view.dismissView()
            })
            
        }else {
            self.wireframe.showAlert(with: "errorOoops".localized, message: "failedToFetchDataMessage".localized, completion: {
                self.view.dismissView()
            })
        }
        
    }
}
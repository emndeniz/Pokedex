//
//  DetailsInterfaces.swift
//  Pokedex
//
//  Created by Emin on 4.11.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

protocol DetailsWireframeInterface: WireframeInterface {
}

protocol DetailsViewInterface: ViewInterface {
    func updateUI(model:CompleteDetailResponse)
    func dismissView()
}

protocol DetailsPresenterInterface: PresenterInterface {
    func viewDidLoad()
}

protocol DetailsInteractorInterface: InteractorInterface {
    func getDetails(url:URL, completion: @escaping DetailsInteractorCompletion)
}

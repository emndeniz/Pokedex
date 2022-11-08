//
//  PokemonDetailsComponent.swift
//  CataPoke
//
//  Created by Emin on 5.11.2022.
//

import UIKit

/// This component contains all UI elements in detail view controller except Pokemon image.
class PokemonDetailsComponent: UIView {

    private lazy var containerStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 36, weight: .heavy)
        label.textColor = .primaryTextColor
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    

    private lazy var typeComponent: TypeComponent = {
       let typeComp = TypeComponent()
        typeComp.translatesAutoresizingMaskIntoConstraints = false
        return typeComp
    }()

    
    private lazy var infoComponent: PokemonInfoComponent = {
        let abilities = PokemonInfoComponent()
        abilities.translatesAutoresizingMaskIntoConstraints = false
        return abilities
    }()
    
    private lazy var abilitiesComponent: PropertyListComponent = {
        let abilities = PropertyListComponent()
        abilities.translatesAutoresizingMaskIntoConstraints = false
        return abilities
    }()
    
    private lazy var movesComponent: PropertyListComponent = {
        let abilities = PropertyListComponent()
        abilities.translatesAutoresizingMaskIntoConstraints = false
        return abilities
    }()
    
    
    private lazy var evolutionChainComponent : EvolutionChainComponent = {
       let evolutionComp = EvolutionChainComponent()
        evolutionComp.translatesAutoresizingMaskIntoConstraints = false
        return evolutionComp
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    
    private func commonInit(){
        
        self.addSubview(containerStackView)
        containerStackView.addArrangedSubview(nameLabel)
        containerStackView.addArrangedSubview(typeComponent)
        containerStackView.addArrangedSubview(infoComponent)
        containerStackView.addArrangedSubview(abilitiesComponent)
        containerStackView.addArrangedSubview(evolutionChainComponent)
        containerStackView.addArrangedSubview(movesComponent)
        self.backgroundColor = .defaultBackgroundColor
        setupViewConstarints()
    }
    
    private func setupViewConstarints(){
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: self.topAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    func setData(data:CompleteDetailResponse){
        nameLabel.text = data.name.capitalized
        infoComponent.setData(data: data)
        abilitiesComponent.setData(title: "abilities".localized,
                                   sectionColor: UIColor.getMatchingColor(colorName: data.color),
                                   list: data.abilities)
        evolutionChainComponent.setData(data: data)
        typeComponent.setData(data: data)
        movesComponent.setData(title: "moves".localized,
                               sectionColor: UIColor.getMatchingColor(colorName: data.color),
                               list: data.moves)
    }
}

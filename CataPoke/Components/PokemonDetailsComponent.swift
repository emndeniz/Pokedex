//
//  PokemonDetailsComponent.swift
//  CataPoke
//
//  Created by Emin on 5.11.2022.
//

import UIKit

/// This component contains all UI elements in detail view controller except Pokemon image.
class PokemonDetailsComponent: UIView {

    private let containerStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 36, weight: .heavy)
        label.textColor = .primaryTextColor
        label.numberOfLines = 0
        return label
    }()

    private let pokedexId: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .light)
        label.textColor = .primaryTextColor
        label.numberOfLines = 0
        return label
    }()
    
    private let habitatLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .light)
        label.textColor = .primaryTextColor
        label.numberOfLines = 0
        return label
    }()
    
    
    private let imageContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.alignment = .leading
        view.distribution = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let mythicalImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "MythicalPokemon")
        return imageView
    }()
    
    private let legendaryImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "LegendaryPokemon")
        return imageView
    }()
    
    private let spacer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private let evolutionChainComponent : EvolutionChainComponent = {
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
        containerStackView.addArrangedSubview(pokedexId)
        containerStackView.addArrangedSubview(habitatLabel)
        containerStackView.addArrangedSubview(imageContainer)
        self.backgroundColor = .defaultBackgroundColor
        setupViewConstarints()
    }
    
    private func setupViewConstarints(){
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: self.topAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            legendaryImage.widthAnchor.constraint(equalToConstant: 48),
            legendaryImage.heightAnchor.constraint(equalToConstant: 48),
            mythicalImage.widthAnchor.constraint(equalToConstant: 48),
            mythicalImage.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
    
    func setData(data:CompleteDetailResponse){
        nameLabel.text = data.name.capitalized
        pokedexId.text = "idOfThePokemon".localized(data.id)
        habitatLabel.text = "habitatOfThePokemon".localized(data.habitat.capitalized)
        
        
        if data.isMytical {
            imageContainer.addArrangedSubview(mythicalImage)
        }
        
        if data.isLegendary{
            imageContainer.addArrangedSubview(legendaryImage)
        }
        
        imageContainer.addArrangedSubview(spacer)
        
        containerStackView.addArrangedSubview(evolutionChainComponent)
        evolutionChainComponent.setData(data: data)
        
    }
}

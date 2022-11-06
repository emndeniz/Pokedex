//
//  PokemonDetailsComponent.swift
//  CataPoke
//
//  Created by Emin on 5.11.2022.
//

import UIKit

/// This component contains all UI elements in detail view controller except Pokemon image.
class PokemonDetailsComponent: UIView {

    private let stackView: UIStackView = {
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
    
    
    private let habitatLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.textColor = .primaryTextColor
        label.numberOfLines = 0
        return label
    }()
    
    
    private let imageContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 12
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
    
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    
    private func commonInit(){
        
        self.addSubview(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(habitatLabel)
        stackView.addArrangedSubview(imageContainer)
        
        imageContainer.addArrangedSubview(mythicalImage)
        imageContainer.addArrangedSubview(legendaryImage)
        imageContainer.addArrangedSubview(spacer)
        self.backgroundColor = .defaultBackgroundColor
        setupViews()
    }
    
    private func setupViews(){
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            legendaryImage.widthAnchor.constraint(equalToConstant: 48),
            legendaryImage.heightAnchor.constraint(equalToConstant: 48),
            mythicalImage.widthAnchor.constraint(equalToConstant: 48),
            mythicalImage.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
    
    func setData(name:String,
                 habitat:String){
        nameLabel.text = name.capitalized
        habitatLabel.text = "habitatOfThePokemon".localized(habitat.capitalized)
    }
}

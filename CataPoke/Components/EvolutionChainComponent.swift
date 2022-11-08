//
//  EvolotiounChainComponent.swift
//  CataPoke
//
//  Created by Emin on 6.11.2022.
//

import UIKit
import Kingfisher

class EvolutionChainComponent: UIView {
    
    private lazy var sectionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.textColor = .primaryTextColor
        label.text = "evolutionChain".localized
        label.textAlignment = .center
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var containerStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 12
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
        
        self.addSubview(containerStackView)
        
        containerStackView.addArrangedSubview(sectionLabel)
        setupViewConstarints()
    }
    
    private func setupViewConstarints(){
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: self.topAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    private func generateImage() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        return imageView
    }
    
    private func generatePokemonWithTitle() -> PokemonWithTitleComponent {
        let component = PokemonWithTitleComponent()
        component.translatesAutoresizingMaskIntoConstraints = false
        return component
    }
    
    private func generateLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .primaryTextColor
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }
    
    private func generateArrow(color:UIColor) -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "arrow.down")
        imageView.tintColor = color
        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return imageView
    }
    
    
    func setData(data:CompleteDetailResponse){
        
        sectionLabel.backgroundColor = UIColor.getMatchingColor(colorName: data.color).withAlphaComponent(0.4)
        for specy in data.evolutionChain {
            let pokemonWithTitle = generatePokemonWithTitle()
            pokemonWithTitle.setData(name: specy.name,
                                     imageURL: StringUtilities.getBigPokemonImageFromSpecyUrl(urlStr: specy.url.absoluteString))
            containerStackView.addArrangedSubview(pokemonWithTitle)
            
            if specy.name != data.evolutionChain.last?.name{
                // This check prevents adding arrow to last image.
                containerStackView.addArrangedSubview(
                    generateArrow(color: UIColor.getMatchingColor(colorName: data.color))
                )
            }
        }
        
    }
}

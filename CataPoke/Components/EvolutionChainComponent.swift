//
//  EvolotiounChainComponent.swift
//  CataPoke
//
//  Created by Emin on 6.11.2022.
//

import UIKit
import Kingfisher

class EvolutionChainComponent: UIView {
    
    private let containerStackView: UIStackView = {
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
        imageView.image = UIImage(named: "MythicalPokemon")
        imageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        return imageView
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
        
        for specy in data.evolutionChain {
            let imagView = generateImage()
            let imageUrl = StringUtilities.getBigPokemonImageFromSpecyUrl(urlStr: specy.url.absoluteString)
            imagView.kf.setImage(with: imageUrl,
                                 options: [
                                    .cacheOriginalImage
                                 ])
            
            containerStackView.addArrangedSubview(imagView)
            
            if specy.name != data.evolutionChain.last?.name{
                // This check prevents adding arrow to last image.
                
                containerStackView.addArrangedSubview(
                    generateArrow(color: UIColor.getMatchingColor(colorName: data.color))
                )
            }
        }
        
    }
    
    
    
}

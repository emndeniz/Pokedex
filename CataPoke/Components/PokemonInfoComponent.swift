//
//  PokemonInfoComponent.swift
//  CataPoke
//
//  Created by Emin on 8.11.2022.
//

import UIKit

class PokemonInfoComponent: UIView {
    
    private lazy var containerStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var sectionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.textColor = .primaryTextColor
        label.textAlignment = .center
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.numberOfLines = 0
        return label
    }()
    
    
    private lazy var imageContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.alignment = .leading
        view.distribution = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var mythicalImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "MythicalPokemon")
        return imageView
    }()
    
    private lazy var legendaryImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "LegendaryPokemon")
        return imageView
    }()
    
    private func generateLabel(text:String) -> UILabel{
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .light)
        label.textColor = .primaryTextColor
        label.numberOfLines = 0
        label.text = text
        label.textAlignment = .natural
        return label
    }
    
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
        
        containerStackView.addArrangedSubview(imageContainer)
        containerStackView.addArrangedSubview(sectionLabel)
        
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
            mythicalImage.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    func setData(data:CompleteDetailResponse){
        sectionLabel.text = "information".localized
        
        sectionLabel.backgroundColor = UIColor.getMatchingColor(colorName: data.color).withAlphaComponent(0.4)
        
        let podexNo = generateLabel(text: "pokedexNo".localized(String(data.id)))
        let habitat = generateLabel(text: "habitatOfThePokemon".localized(data.habitat.capitalized))
        
        let weight =  generateLabel(text: "weight".localized(getSizeValue(value: data.weight)))
        let height =  generateLabel(text: "height".localized(getSizeValue(value: data.height)))
        
        containerStackView.addArrangedSubview(podexNo)
        containerStackView.addArrangedSubview(habitat)
        containerStackView.addArrangedSubview(weight)
        containerStackView.addArrangedSubview(height)
        
        
        if data.isMytical {
            imageContainer.addArrangedSubview(mythicalImage)
        }
        
        if data.isLegendary{
            imageContainer.addArrangedSubview(legendaryImage)
        }

    }
    
    /// Converts given weight and height to readable values
    /// - Parameter value: Height or weight
    /// - Returns: String represantation
    func getSizeValue(value:Int?) -> String{
        // Height provided as decimeter, weight provided as hectogram from api
        // Dividing it to 10 gives us Meter and Kilogram values
        if let val = value {
            return String(val / 10)
        }else {
            return String("notAvailable")
        }
    }
    
}

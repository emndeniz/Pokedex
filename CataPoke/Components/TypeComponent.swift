//
//  PokemonTypeComponent.swift
//  CataPoke
//
//  Created by Emin on 8.11.2022.
//

import UIKit

class TypeComponent: UIView {

    private lazy var containerStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 12
        view.alignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.layoutMargins = UIEdgeInsets(top: 8, left: 24, bottom: 8, right: 24)
        view.isLayoutMarginsRelativeArrangement = true
        return view
    }()
    
    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .light)
        label.textColor = .primaryTextColor
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var typeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
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
        
        containerStackView.addArrangedSubview(typeLabel)
        containerStackView.addArrangedSubview(typeImage)
        setupViewConstarints()
    }
    
    private func setupViewConstarints(){
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: self.topAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            containerStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            typeImage.heightAnchor.constraint(equalToConstant: 30),
            typeImage.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    
    func setData(data:CompleteDetailResponse){
        typeLabel.text = "type".localized( data.type[0].capitalized)
        typeImage.image = UIImage.getMatchingImageForType(type: data.type[0])
        containerStackView.backgroundColor = UIColor.getMatchingColor(colorName: data.color).withAlphaComponent(0.4)
    }
    
    
}

//
//  PokemonTypeComponent.swift
//  CataPoke
//
//  Created by Emin on 8.11.2022.
//

import UIKit

class TypeComponent: UIView {

    private lazy var rootStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 12
        view.alignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.layoutMargins = UIEdgeInsets(top: 8, left: 24, bottom: 8, right: 24)
        view.isLayoutMarginsRelativeArrangement = true
        return view
    }()
    
    private lazy var sectionLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .primaryTextColor
        label.numberOfLines = 0
        return label
    }()
    
    private func generateContainerView() -> UIStackView {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 12
        view.alignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.layoutMargins = UIEdgeInsets(top: 8, left: 24, bottom: 8, right: 24)
        view.isLayoutMarginsRelativeArrangement = true
        return view
    }
    
    
    private func generateLabel(text:String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .light)
        label.textColor = .primaryTextColor
        label.numberOfLines = 0
        label.text = text
        return label
    }
    
    private func generateImage(image:UIImage) -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return imageView
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
        
        self.addSubview(rootStackView)
        rootStackView.addArrangedSubview(sectionLabel)
        setupViewConstarints()
    }
    
    private func setupViewConstarints(){
        
        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(equalTo: self.topAnchor),
            rootStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            rootStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
    
    
    func setData(data:CompleteDetailResponse){
        sectionLabel.text = "type".localized
        rootStackView.backgroundColor = UIColor.getMatchingColor(colorName: data.color).withAlphaComponent(0.4)
        
        for type in data.types {
            let label = generateLabel(text:type.capitalized)
            let image = generateImage(image:UIImage.getMatchingImageForType(type: type))
        
            
            let container = generateContainerView()
            container.addArrangedSubview(image)
            container.addArrangedSubview(label)
            rootStackView.addArrangedSubview(container)
        }
    }
    
    
}

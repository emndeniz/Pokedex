//
//  AbilitiesComponent.swift
//  CataPoke
//
//  Created by Emin on 8.11.2022.
//

import UIKit

class PropertyListComponent: UIView {

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
    
    private func generateLabel(text:String) -> UILabel{
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .light)
        label.textColor = .primaryTextColor
        label.numberOfLines = 0
        label.text = text
        label.textAlignment = .center
        label.backgroundColor = .cellBackgroundcolor.withAlphaComponent(0.2)
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
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
    
    func setData(title:String, sectionColor:UIColor, list:[String]){
        sectionLabel.text = "abilities".localized
        
        sectionLabel.backgroundColor = sectionColor.withAlphaComponent(0.4)
        for item in list {
            
            let label = generateLabel(text: item.capitalized)
            containerStackView.addArrangedSubview(label)
        }
    }

}

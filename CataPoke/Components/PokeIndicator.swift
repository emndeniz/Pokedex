//
//  PokeIndicator.swift
//  CataPoke
//
//  Created by Emin on 6.11.2022.
//

import UIKit
import Lottie
class PokeIndicator: UIView {

    private let animationView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "pokeball-loading-animation.json")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        return animationView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        animationView.frame = frame
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
        self.addSubview(animationView)
        setupViews()
    }
    
    private func setupViews(){
        NSLayoutConstraint.activate([
            animationView.topAnchor.constraint(equalTo: self.topAnchor),
            animationView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            animationView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func startAnimating() {
        animationView.play()
    }
    
    func stopAnimating() {
        animationView.stop()
        self.removeFromSuperview()
    }

}

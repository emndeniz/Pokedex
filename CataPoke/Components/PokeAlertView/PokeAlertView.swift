//
//  PokeAlertView.swift
//  CataPoke
//
//  Created by Emin on 7.11.2022.
//

import UIKit
import Lottie




class PokeAlertView: UIViewController {
    
    private var alertTitle: String!
    private var message: String!
    private var axis: NSLayoutConstraint.Axis = .horizontal
    private var actions = [Action]()
    
    
    /// This is the top outer view that will be presented as presented as blur.
    private lazy var rootView: UIView = {
        let view = createASimpleView(with: .defaultBackgroundColor.withAlphaComponent(0.0))
        return view
    }()
    
    /// This is the view that contains ContainerStackView. Important for correct spacing
    private lazy var alertBackgroundView: UIView = {
        let view = createASimpleView(with: .defaultBackgroundColor,cornerRadius: 10.0)
        return view
    }()
    
    /// This the view that holds all sub views like animationView, titles and buttons
    private lazy var containerStackView: UIStackView = {
        let stackView = createSimpleStackViewWith(axis: .vertical, spacing: 20, color: .defaultBackgroundColor, cornerRadius: 10.0)
        return stackView
    }()
    
    private lazy var animationView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "error-animation.json")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.play()
        animationView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        return animationView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = createSimpleUILabelWith(textColor: .primaryTextColor, font: UIFont.boldSystemFont(ofSize: 17.0))
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = createSimpleUILabelWith(textColor:.primaryTextColor, font: UIFont.systemFont(ofSize: 15.0))
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var titleStackView: UIStackView = {
        let stackView = createSimpleStackViewWith(axis: .vertical, spacing: 5.0)
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private lazy var actionsStackView: UIStackView = {
        let stackView = createSimpleStackViewWith(axis: .horizontal, spacing: 10.0)
        return stackView
    }()
    

    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    /// Initialize  the alert view
    /// - Parameters:
    ///   - title: Title of  the pop up
    ///   - message: Message
    ///   - actions: Actions to be done
    ///   - axis: Orientation of buttons, whether to be arranged vertically or horizontally
    ///   - style: alertStyle default is normal
    init(withTitle title: String,
         message: String,
         actions: [Action],
         axis: NSLayoutConstraint.Axis = .horizontal) {
        super.init(nibName: nil, bundle: nil)
        self.actions = actions
        self.alertTitle = title
        self.message = message
        self.axis = axis
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        containerStackView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        perform(#selector(animateAlert), with: self, afterDelay: 0.2)
        
    }
    
    @objc private func animateAlert() {
        rootView.alpha = 0.0
        UIView.animate(withDuration: 0.1, animations: {
            self.rootView.alpha = 1.0
            self.rootView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            self.containerStackView.transform = .identity
        })
    }
    
    private func setUpUI() {
        view.addSubview(rootView)
        view.addSubview(alertBackgroundView)
        alertBackgroundView.addSubview(containerStackView)
        containerStackView.addArrangedSubview(animationView)
        containerStackView.addArrangedSubview(titleStackView)
        containerStackView.addArrangedSubview(actionsStackView)

        NSLayoutConstraint.activate([
            rootView.topAnchor.constraint(equalTo: view.topAnchor),
            rootView.leftAnchor.constraint(equalTo: view.leftAnchor),
            rootView.rightAnchor.constraint(equalTo: view.rightAnchor),
            rootView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            alertBackgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertBackgroundView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            alertBackgroundView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            alertBackgroundView.heightAnchor.constraint(equalToConstant: 250),
            
            containerStackView.topAnchor.constraint(equalTo: alertBackgroundView.topAnchor, constant: 8),
            containerStackView.leftAnchor.constraint(equalTo: alertBackgroundView.leftAnchor,constant: 8),
            containerStackView.rightAnchor.constraint(equalTo: alertBackgroundView.rightAnchor,constant: -8),
            containerStackView.bottomAnchor.constraint(equalTo: alertBackgroundView.bottomAnchor,constant: -8),
        
        ])
        
        for action in actions {
            let actionButton = ActionButton(withAction: action)
            actionsStackView.addArrangedSubview(actionButton)
        }
        setUpTitleLabels()
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(messageLabel)
    }
    
    
    private func setUpTitleLabels() {
        titleLabel.text = alertTitle
        messageLabel.text = message
        
        // If title or message is empty just hide that...
        titleLabel.isHidden = alertTitle == nil
        messageLabel.isHidden = message == nil
    }
    
    // MARK: Convenience functions
    private func createSimpleStackViewWith(axis: NSLayoutConstraint.Axis,
                                           spacing: CGFloat = 1,
                                           color:UIColor = .clear,
                                           cornerRadius:CGFloat = 0) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.layer.cornerRadius = cornerRadius
        stackView.backgroundColor = color
        return stackView
    }
    
    private func createSimpleUILabelWith(textColor: UIColor, font: UIFont) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = textColor
        label.textAlignment = .center
        label.font = font
        return label
    }
    
    private func createASimpleView(with backgroundColor: UIColor = UIColor.white, cornerRadius: CGFloat = 0.0) -> UIView {
        let newView = UIView()
        newView.translatesAutoresizingMaskIntoConstraints = false
        newView.backgroundColor = backgroundColor
        newView.layer.cornerRadius = cornerRadius
        return newView
    }
    
}

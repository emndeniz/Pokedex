import UIKit

protocol WireframeInterface: AnyObject {
    // MARK: - Generic Alert Functions -
    func showAlert(with title: String?, message: String?, completion: (() -> Void)?)
    func showAlert(with title: String?, message: String?, actions: [Action])
}

class BaseWireframe<ViewController> where ViewController: UIViewController {
    
    private unowned var _viewController: ViewController
    
    // We need it in order to retain the view controller reference upon first access
    private var temporaryStoredViewController: ViewController?
    
    init(viewController: ViewController) {
        temporaryStoredViewController = viewController
        _viewController = viewController
    }
    
}

extension BaseWireframe: WireframeInterface {
    
}

extension BaseWireframe {
    
    var viewController: ViewController {
        defer { temporaryStoredViewController = nil }
        return _viewController
    }
    
    var navigationController: UINavigationController? {
        return viewController.navigationController
    }
    
}

// MARK: - Wireframe Present Functions -
extension UIViewController {
    
    func presentWireframe<ViewController>(_ wireframe: BaseWireframe<ViewController>, animated: Bool = true, completion: (() -> Void)? = nil) {
        present(wireframe.viewController, animated: animated, completion: completion)
    }
    
}

// MARK: - Generic Alert Functions -
extension BaseWireframe {
    func showAlert(with title: String?, message: String?, completion: (() -> Void)?) {
        let okAction = Action(with: "OK".localized, style: .normal) { [weak self] in
            self?.navigationController?.dismiss(animated: true)
            completion?()
        }
        showAlert(with: title, message: message, actions: [okAction])
    }
    
    func showAlert(with title: String?, message: String?, actions:  [Action]) {
        let alertVC = PokeAlertView(withTitle: title ?? "",
                                    message: message ?? "",
                                    actions: actions)
        alertVC.modalPresentationStyle = .overCurrentContext
        alertVC.modalTransitionStyle = .crossDissolve
        navigationController?.present(alertVC, animated: true, completion: nil)
    }
}

// MARK: - UINavigationController Helper Functions -
extension UINavigationController {
    
    func pushWireframe<ViewController>(_ wireframe: BaseWireframe<ViewController>, animated: Bool = true) {
        pushViewController(wireframe.viewController, animated: animated)
    }
    
    func setRootWireframe<ViewController>(_ wireframe: BaseWireframe<ViewController>, animated: Bool = true) {
        setViewControllers([wireframe.viewController], animated: animated)
    }
    
}

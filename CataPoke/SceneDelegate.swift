import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // Start the logger
        Logger.startLogger()

        self.window = UIWindow(windowScene: windowScene)
        createInitialWireframe()
        
        ConnectionManager.instance.monitorNetworkConnection()
    }
    
    /// Creates Initial Wireframe to start VIPER Flow
    private func createInitialWireframe() {
        
        
        let initialViewController = UINavigationController()
        initialViewController.navigationBar.prefersLargeTitles = true

        initialViewController.setRootWireframe(ListWireframe())
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()

    }
}

extension UIApplication {

    class func getTopViewController(base: UIViewController? = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController) -> UIViewController? {

        
        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)

        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)

        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}

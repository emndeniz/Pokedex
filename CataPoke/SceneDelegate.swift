import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // Start the logger
        Logger.startLogger()

        self.window = UIWindow(windowScene: windowScene)
        createInitialWireframe()
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

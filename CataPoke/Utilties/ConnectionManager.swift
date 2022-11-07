//
//  Reachability.swift
//  CataPoke
//
//  Created by Emin on 7.11.2022.
//

import UIKit
import Network

/// This class monitors network and inform app about changes.
class ConnectionManager{
    
    static let instance = ConnectionManager()
    private let monitor = NWPathMonitor()
    
    
    private init() {}
    
    /// Starts monitring
    func monitorNetworkConnection(){
        monitor.pathUpdateHandler = { [weak self] path in
            if  path.status == .satisfied {
                Logger.log.debug("Device is connected to internet, isCelularConnection:", context: path.isExpensive)
            } else if !path.availableInterfaces.isEmpty{
                // In this case we shouldn't show any alert
                Logger.log.debug("Device has available networks but none of them satisfied yet.")
            }else {
                Logger.log.warning("Device is connected to the internet")
                self?.showWarningToUser()
            }
        }
        
        let queue = DispatchQueue(label: "Network")
        monitor.start(queue: queue)
    }
    
    /// Checks internet acces. If it is reachable returns true.
    /// - Returns: Boolen indicating connection
    func isNetworkAccessible() -> Bool{
        return monitor.currentPath.status == .satisfied
    }

    private func showWarningToUser(){
        DispatchQueue.main.async {
            let activeVC = UIApplication.getTopViewController()
            let okAction = Action(with: "OK", style: .normal) {
                activeVC?.navigationController?.dismiss(animated: true)
            }
            let alertVC = PokeAlertView(withTitle: "errorOoops".localized, message: "noInternetConnectionMessage".localized, actions: [okAction])
            alertVC.modalPresentationStyle = .overCurrentContext
            alertVC.modalTransitionStyle = .crossDissolve
            activeVC?.navigationController?.present(alertVC, animated: true, completion: nil)
        }
        
    }
}



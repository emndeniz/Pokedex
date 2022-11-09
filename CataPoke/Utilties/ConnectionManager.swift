//
//  Reachability.swift
//  CataPoke
//
//  Created by Emin on 7.11.2022.
//

import UIKit
import Network


protocol ConnectionMangerProtocol {
    func monitorNetworkConnection()
    func isNetworkAccessible() -> Bool
}

/// This class monitors network and inform app about changes.
class ConnectionManager : ConnectionMangerProtocol{
    
    static let instance = ConnectionManager()
    private let monitor = NWPathMonitor()
    // This variable prevent to show user redundant alert to shown
    private var isErrorAlertShown = false
    
    
    private init() {}
    
    /// Starts monitring
    func monitorNetworkConnection(){
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else {return}
            if  path.status == .satisfied {
                Logger.log.debug("Device is connected to internet, isCelularConnection:", context: path.isExpensive)
                self.isErrorAlertShown = false
            }else {
                Logger.log.warning("Device is not connected to the internet")
                if !self.isErrorAlertShown{
                    self.showWarningToUser()
                    self.isErrorAlertShown = true
                }
               
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



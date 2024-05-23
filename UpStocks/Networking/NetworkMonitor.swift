import Network
import UIKit

class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)
    private var isAlertPresented = false
    
    func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            if path.status == .unsatisfied {
                DispatchQueue.main.async {
                    self?.showNetworkAlert()
                }
            } else {
                self?.isAlertPresented = false
            }
        }
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
    
    private func showNetworkAlert() {
        if !isAlertPresented {
            isAlertPresented = true
            
            guard let rootViewController = self.getRootViewController() else {
                return
            }
            
            let alert = UIAlertController(title: "Network Unavailable",
                                          message: "Please check your internet connection.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            rootViewController.present(alert, animated: true, completion: nil)
        }
    }
    
    private func getRootViewController() -> UIViewController? {
        guard let windowScene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene else {
            return nil
        }
        
        return windowScene.windows.first(where: { $0.isKeyWindow })?.rootViewController
    }
}

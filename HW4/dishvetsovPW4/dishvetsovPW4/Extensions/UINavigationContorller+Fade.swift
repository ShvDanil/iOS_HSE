//
//  UINavigationContorller+Fade.swift
//  dishvetsovPW4
//
//  Created by Danil Shvetsov on 04.12.2022.
//

import UIKit

extension UINavigationController {
    
    /// This function pushes the controller with the fade.
    /// - Parameter viewController: View controller which is passed to be pushed.
    func fadeTo(_ viewController: UIViewController) {
        let transition: CATransition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.fade
        
        view.layer.add(transition, forKey: nil)
        pushViewController(viewController, animated: false)
    }
    
    /// This function pops the contorller with the fade.
    func fadeOut() {
        let transition: CATransition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.fade
        
        view.layer.add(transition, forKey: nil)
        popViewController(animated: false)
    }
    
}

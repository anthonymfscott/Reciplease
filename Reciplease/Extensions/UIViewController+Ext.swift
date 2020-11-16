//
//  UIViewController+Ext.swift
//  Reciplease
//
//  Created by anthonymfscott on 16/11/2020.
//

import UIKit

extension UIViewController {
    func presentRPAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = RPAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}

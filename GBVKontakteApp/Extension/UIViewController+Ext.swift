//
//  UIViewController+Ext.swift
//  GBVKontakteApp
//
//  Created by Dmitry on 09/09/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import UIKit

extension UIViewController {
    public func show(_ error: Error) {
        let alertVC = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
}

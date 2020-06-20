//
//  ViewControllerProtocol.swift
//  nyt-foil
//
//  Created by Luiz Felipe Aires Soares on 20/06/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import UIKit

protocol ViewControllerProtocol: AnyObject {
    
    func showError(with message: String, cancelButtonTitle: String, actionButtonTitle: String?, actionHandler: (() -> Void)?)
    
}

extension ViewControllerProtocol where Self: UIViewController {
    
    func showError(with message: String, cancelButtonTitle: String = "OK", actionButtonTitle: String?, actionHandler: (() -> Void)?) {
        let alert = UIAlertController(title: "NYT", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: nil))
        if let actionTitle = actionButtonTitle {
            alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { (action) in
                actionHandler?()
            }))
        }
        present(alert, animated: true, completion: nil)
    }
    
}

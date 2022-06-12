//
//  CustomService.swift
//  MigrationToCombine
//
//  Created by Shikha Budhiraja on 12/06/22.
//

import UIKit

enum AlertService {
    
    static func showAlert( with title:String?, _ message: String?, in viewController: UIViewController?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(
            .init(title: "Cool", style: .cancel)
        )
        viewController?.present(alert, animated: true)
    }
}


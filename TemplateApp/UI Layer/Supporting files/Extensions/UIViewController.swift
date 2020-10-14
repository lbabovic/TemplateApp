//
//  UIViewController.swift
//  TemplateApp
//
//  Created by Luka Babovic on 14/10/2020.
//  Copyright © 2020 lbabovic. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentNativePopUp(title: String, text: String, completion: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "U redu", style: .default, handler: completion))
        self.present(alert, animated: true, completion: nil)
    }
}

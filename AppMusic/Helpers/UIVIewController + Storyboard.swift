//
//  UIVIewController + Storyboard.swift
//  AppMusic
//
//  Created by Алексей Черанёв on 07.10.2021.
//

import UIKit

extension UIViewController {
    class func loadFromStoryboard<T: UIViewController> () -> T {
        let name = String(describing: T.self)
        let storyBoard = UIStoryboard(name: name, bundle: nil)
        if let viewController = storyBoard.instantiateInitialViewController() as? T {
            return viewController
        }
        else {
            fatalError("Error: No initial view controller in \(name) storyboard")
        }
    }
}

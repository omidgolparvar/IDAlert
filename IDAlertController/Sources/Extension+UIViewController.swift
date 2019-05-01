//
//  Extension+UIViewController.swift
//  IDAlertController
//
//  Created by Omid Golparvar on 4/30/19.
//  Copyright © 2019 Omid Golparvar. All rights reserved.
//

import Foundation
import UIKit

public extension UIViewController {
	
	public func present(_ idAlertController: IDAlertController, animated: Bool, completion: (() -> Void)?) {
		idAlertController.setupViewsBeforePresentation()
		self.present(idAlertController.alertController, animated: animated, completion: completion)
		idAlertController.setupViewsAfterPresentation()
	}
	
}

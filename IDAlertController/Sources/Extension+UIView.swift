//
//  Extension+UIView.swift
//  IDAlertController
//
//  Created by Omid Golparvar on 5/4/19.
//  Copyright © 2019 Omid Golparvar. All rights reserved.
//

import Foundation
import UIKit

internal extension UIView {
	
	internal func findAlertControllerContentLabel() -> UILabel? {
		if let label = self as? UILabel, label.text == "__CUSTOM_CONTENT_MARKER__" {
			return label
		}
		
		for subview in self.subviews {
			if let found = subview.findAlertControllerContentLabel() {
				return found
			}
		}
		
		return nil
	}
	
}

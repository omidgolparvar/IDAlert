import Foundation
import UIKit

extension UIView {
	
	func findAlertControllerContentLabel() -> UILabel? {
		if let label = self as? UILabel, label.text == "__CUSTOM_CONTENT_MARKER__" {
			return label
		}
		
		for subview in subviews {
			if let found = subview.findAlertControllerContentLabel() {
				return found
			}
		}
		
		return nil
	}
	
}

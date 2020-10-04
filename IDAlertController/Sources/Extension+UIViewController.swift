import Foundation
import UIKit

public extension UIViewController {
	
	func present(_ idAlertController: IDAlertController, animated: Bool, completion: (() -> Void)?) {
		idAlertController.setSourceViewController(self)
		idAlertController.setupViewsBeforePresentation()
		present(idAlertController.alertController, animated: animated, completion: completion)
		idAlertController.setupViewsAfterPresentation()
	}
	
}

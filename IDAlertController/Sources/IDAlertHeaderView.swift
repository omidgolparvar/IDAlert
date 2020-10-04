import Foundation
import UIKit

public struct IDAlertHeaderView {
	
	internal let contentView	: UIView
	internal let height			: CGFloat
	
	public init(contentView: UIView, height: CGFloat) {
		self.contentView	= contentView
		self.height			= height
		
		self.contentView.backgroundColor = .clear
		self.contentView.translatesAutoresizingMaskIntoConstraints = false
	}
	
	
}

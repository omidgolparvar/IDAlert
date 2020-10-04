import Foundation
import UIKit

public extension IDAlertAction {
	
	static func InitializeNormalAction(
		title		: String,
		alignment	: NSTextAlignment		= .center,
		color		: UIColor?				= nil,
		font		: UIFont?				= nil,
		leftImage	: UIImage?				= nil,
		rightImage	: UIImage?				= nil,
		actionStyle	: UIAlertAction.Style	= .default,
		handler		: Handler?) -> IDAlertAction {
		
		let content = NormalContent(
			title		: title,
			alignment	: alignment,
			color		: color,
			font		: font,
			leftImage	: leftImage,
			rightImage	: rightImage,
			actionStyle	: actionStyle
		)
		
		return IDAlertAction(actionContent: .normal(content), handler: handler)
	}
	
	static func InitializeTitleAndSubtitleAction(
		title			: String,
		titleColor		: UIColor?				= nil,
		titleFont		: UIFont?				= nil,
		subtitle		: String,
		subtitleColor	: UIColor?				= nil,
		subtitleFont	: UIFont?				= nil,
		actionStyle		: UIAlertAction.Style	= .default,
		actionHeight	: CGFloat?				= nil,
		handler			: Handler?) -> IDAlertAction {
		
		let content = IDAlertAction.TitleAndSubtitleContent(
			title			: title,
			titleColor		: titleColor,
			titleFont		: titleFont,
			subtitle		: subtitle,
			subtitleColor	: subtitleColor,
			subtitleFont	: subtitleFont,
			actionStyle		: actionStyle,
			actionHeight	: actionHeight
		)
		
		return IDAlertAction(actionContent: .titleAndSubtitle(content), handler: handler)
	}
	
}

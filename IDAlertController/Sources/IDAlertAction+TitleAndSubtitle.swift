import Foundation
import UIKit

extension IDAlertAction {
	
	struct TitleAndSubtitleContent {
		
		var title			: String
		var titleColor		: UIColor?
		var titleFont		: UIFont?
		var subtitle		: String
		var subtitleColor	: UIColor?
		var subtitleFont	: UIFont?
		var actionStyle		: UIAlertAction.Style
		var actionHeight	: CGFloat?
		
		init(title			: String,
			 titleColor		: UIColor?,
			 titleFont		: UIFont?,
			 subtitle		: String,
			 subtitleColor	: UIColor?,
			 subtitleFont	: UIFont?,
			 actionStyle	: UIAlertAction.Style,
			 actionHeight	: CGFloat?) {
			
			self.title			= title
			self.titleColor		= titleColor
			self.titleFont		= titleFont
			self.subtitle		= subtitle
			self.subtitleColor	= subtitleColor
			self.subtitleFont	= subtitleFont
			self.actionStyle	= actionStyle
			if actionStyle == .destructive {
				self.titleColor		= .red
				self.subtitleColor	= .red
			}
			self.actionHeight	= actionHeight
		}
	}
	
}

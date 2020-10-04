import Foundation
import UIKit

extension IDAlertAction {
	
	struct NormalContent {
		
		var title			: String
		var textAlignment	: NSTextAlignment
		var textColor		: UIColor?
		var textFont		: UIFont?
		var leftImage		: UIImage?
		var rightImage		: UIImage?
		var actionStyle		: UIAlertAction.Style
		
		var hasImage		: Bool {
			return leftImage != nil || rightImage != nil
		}
		
		init(title			: String,
			 alignment		: NSTextAlignment,
			 color			: UIColor?,
			 font			: UIFont?,
			 leftImage		: UIImage?,
			 rightImage		: UIImage?,
			 actionStyle	: UIAlertAction.Style) {
			
			self.title			= title
			self.textAlignment	= alignment
			self.textColor		= color
			self.textFont		= font
			self.leftImage		= leftImage
			self.rightImage		= rightImage
			self.actionStyle 	= actionStyle
			if actionStyle == .destructive {
				self.textColor = .red
			}
			
		}
		
	}

}



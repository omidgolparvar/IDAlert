//
//  IDAlertAction+Normal.swift
//  IDAlertController
//
//  Created by Omid Golparvar on 5/7/19.
//  Copyright © 2019 Omid Golparvar. All rights reserved.
//

import Foundation
import UIKit

internal extension IDAlertAction {
	
	internal struct NormalContent {
		
		internal var title			: String
		internal var textAlignment	: NSTextAlignment
		internal var textColor		: UIColor?
		internal var textFont		: UIFont?
		internal var leftImage		: UIImage?
		internal var rightImage		: UIImage?
		internal var actionStyle	: UIAlertAction.Style
		
		internal var hasImage		: Bool {
			return leftImage != nil || rightImage != nil
		}
		
		internal init(title			: String,
					  alignment		: NSTextAlignment,
					  color			: UIColor?,
					  font			: UIFont?,
					  leftImage		: UIImage?,
					  rightImage	: UIImage?,
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



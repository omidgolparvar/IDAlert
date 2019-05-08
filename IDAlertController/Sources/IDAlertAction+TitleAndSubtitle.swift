//
//  IDAlertAction+TitleAndSubtitle.swift
//  IDAlertController
//
//  Created by Omid Golparvar on 5/7/19.
//  Copyright © 2019 Omid Golparvar. All rights reserved.
//

import Foundation
import UIKit

internal extension IDAlertAction {
	
	internal struct TitleAndSubtitleContent {
		
		internal var title			: String
		internal var titleColor		: UIColor?
		internal var titleFont		: UIFont?
		internal var subtitle		: String
		internal var subtitleColor	: UIColor?
		internal var subtitleFont	: UIFont?
		internal var actionStyle	: UIAlertAction.Style
		internal var actionHeight	: CGFloat?
		
		internal init(title			: String,
					  titleColor	: UIColor?,
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

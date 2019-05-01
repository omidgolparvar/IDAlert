//
//  IDAlertAction.swift
//  IDAlertController
//
//  Created by Omid Golparvar on 4/30/19.
//  Copyright © 2019 Omid Golparvar. All rights reserved.
//

import Foundation
import UIKit

public struct IDAlertAction {
	
	public typealias Handler	= () -> Void
	
	public static var TextFont	: UIFont	= .systemFont(ofSize: 17, weight: .medium)
	
	internal var title			: String
	internal var handler		: Handler?				= nil
	internal var textAlignment	: NSTextAlignment		= .center
	internal var textColor		: UIColor?				= nil
	internal var textFont		: UIFont?				= nil
	internal var leftImage		: UIImage?				= nil
	internal var rightImage		: UIImage?				= nil
	internal var actionStyle	: UIAlertAction.Style	= .default
	
	internal var hasImage		: Bool {
		return leftImage != nil || rightImage != nil
	}
	
	public init(title: String, handler: Handler?) {
		self.title		= title
		self.handler	= handler
	}
	
	public mutating func setupText(alignment: NSTextAlignment, color: UIColor?, font: UIFont?) {
		self.textAlignment	= alignment
		self.textColor		= color
		self.textFont		= font
	}
	
	public mutating func setupImages(leftImage: UIImage?, rightImage: UIImage?) {
		self.leftImage	= leftImage
		self.rightImage	= rightImage
	}
	
	public mutating func setActionStyle(_ actionStyle: UIAlertAction.Style) {
		self.actionStyle = actionStyle
		if actionStyle == .destructive {
			self.textColor = .red
		}
	}
	
}

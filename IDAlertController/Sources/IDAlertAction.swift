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
	
	public static var TitleTextFont		: UIFont	= .systemFont(ofSize: 17, weight: .medium)
	public static var SubtitleTextFont	: UIFont	= .systemFont(ofSize: 14, weight: .regular)
	
	internal var actionContent	: IDAlertActionContent
	internal var handler		: Handler?	= nil
	
	internal init(actionContent: IDAlertActionContent, handler: Handler?) {
		self.actionContent	= actionContent
		self.handler		= handler
		
	}
	
	internal enum IDAlertActionContent {
		case normal(NormalContent)
		case titleAndSubtitle(TitleAndSubtitleContent)
	}
	
}

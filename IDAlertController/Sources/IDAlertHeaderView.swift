//
//  IDAlertHeaderView.swift
//  IDAlertController
//
//  Created by Omid Golparvar on 5/3/19.
//  Copyright © 2019 Omid Golparvar. All rights reserved.
//

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

//
//  CustomView.swift
//  IDAlertController
//
//  Created by Omid Golparvar on 5/3/19.
//  Copyright © 2019 Omid Golparvar. All rights reserved.
//

import UIKit

class CustomView: UIView {
	
	@IBOutlet weak var label_Title: UILabel!
	@IBOutlet weak var label_Message: UILabel!
	@IBOutlet weak var button_CopyToClipboard: UIButton!
	
	var view: UIView!
	
	private var valueToCopy: String = ""
	
	func xibSetup() {
		view = loadViewFromNib()
		view.frame = bounds
		view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		addSubview(view)
		view.backgroundColor = .clear
		button_CopyToClipboard.layer.cornerRadius = button_CopyToClipboard.frame.height / 2.0
		button_CopyToClipboard.clipsToBounds = true
	}
	
	func loadViewFromNib() -> UIView {
		let bundle = Bundle(for: type(of: self))
		let nib = UINib(nibName: "CustomView", bundle: bundle)
		let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
		return view
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		xibSetup()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		xibSetup()
	}
	
	func setup(title: String, message: String, valueToCopy: String) {
		label_Title.text = title
		label_Message.text = message
		self.valueToCopy = valueToCopy
		
	}
	
	@IBAction func actionCopyToClipboard(_ sender: UIButton) {
		UIView.transition(with: button_CopyToClipboard, duration: 0.2, options: [.transitionFlipFromTop], animations: {
			self.button_CopyToClipboard.setTitle("کپی شد!", for: .normal)
			self.button_CopyToClipboard.backgroundColor = .lightGray
			self.button_CopyToClipboard.setTitleColor(.black, for: .normal)
		}, completion: nil)
		print(#function)
	}
	
	
}

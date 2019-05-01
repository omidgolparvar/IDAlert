//
//  IDAlertController.swift
//  IDAlertController
//
//  Created by Omid Golparvar on 4/30/19.
//  Copyright © 2019 Omid Golparvar. All rights reserved.
//

import UIKit

public class IDAlertController: NSObject {
	
	internal var alertController	: UIAlertController!
	internal var idHeader			: IDAlertHeader?	= nil
	internal var idActions			: [IDAlertAction]	= []
	
	public init(header: IDAlertHeader?, actions: [IDAlertAction], preferredStyle style: UIAlertController.Style) {
		super.init()
		
		self.idHeader = header
		self.alertController = .init(title: nil, message: nil, preferredStyle: style)
		self.addIDActions(actions)
	}
	
	private func addIDAction(_ action: IDAlertAction) {
		let newAction = UIAlertAction(title: " ", style: action.actionStyle) { (_) in
			action.handler?()
		}
		alertController.addAction(newAction)
		idActions.append(action)
	}
	
	private func addIDActions(_ actions: [IDAlertAction]) {
		actions.forEach(self.addIDAction)
	}
	
	public func setupPopoverPresentationController(sourceView: UIView, permittedArrowDirections: UIPopoverArrowDirection) {
		alertController.popoverPresentationController?.sourceView = sourceView
		alertController.popoverPresentationController?.sourceRect = sourceView.bounds
		alertController.popoverPresentationController?.permittedArrowDirections = permittedArrowDirections
	}
	
	internal func setupViewsBeforePresentation() {
		setupIDHeaderRelatedViews()
	}
	
	internal func setupViewsAfterPresentation() {
		setupIDActionsRelatedViews()
	}
	
	public func setTintColor(_ color: UIColor) {
		self.alertController.view.tintColor = color
	}
	
}

extension IDAlertController {
	
	private func setupIDHeaderRelatedViews() {
		guard let idHeader = idHeader else { return }
		if let title = idHeader.title {
			let titleAttributedString = NSAttributedString(string: title, attributes: [
				.font: (idHeader.titleFont ?? IDAlertHeader.TitleFont),
				.foregroundColor: (idHeader.titleColor ?? IDAlertHeader.TitleColor)
				]
			)
			alertController.setValue(titleAttributedString, forKey: "attributedTitle")
		}
		
		if let message = idHeader.message {
			let messageAttributedString = NSAttributedString(string: message, attributes: [
				.font: (idHeader.messageFont ?? IDAlertHeader.MessageFont),
				.foregroundColor: (idHeader.messageColor ?? IDAlertHeader.MessageColor)
				]
			)
			alertController.setValue(messageAttributedString, forKey: "attributedMessage")
		}
		
	}
	
	private func setupIDActionsRelatedViews() {
		idActions
			.enumerated()
			.forEach { (index, action) in
				let alertAction = alertController.actions[index]
				guard
					let representer = alertAction.value(forKey: "__representer") as? NSObject,
					let label = representer.value(forKey: "label") as? UILabel,
					let holder = label.superview
					else { return }
				
				setupLabel(for: action, in: holder)
				setupImages(for: action, in: holder)
				
		}
	}
	
	private func setupLabel(for action: IDAlertAction, in holder: UIView) {
		let newLabel = UILabel(frame: .zero)
		newLabel.translatesAutoresizingMaskIntoConstraints = false
		newLabel.font = action.textFont ?? IDAlertAction.TextFont
		newLabel.text = action.title
		newLabel.textColor = action.textColor ?? alertController.view.tintColor
		newLabel.textAlignment = action.textAlignment
		
		let rightMargin	: CGFloat
		let leftMargin	: CGFloat
		
		if action.textAlignment == .center {
			rightMargin = action.hasImage ? -60 : -16
			leftMargin = action.hasImage ? 60 : 16
		} else {
			rightMargin = action.rightImage == nil ? -16 : -60
			leftMargin = action.leftImage == nil ? 16 : 60
		}
		
		let holderSuperView = holder.superview!
		holder.addSubview(newLabel)
		newLabel.topAnchor.constraint(equalTo: holderSuperView.topAnchor, constant: 4).isActive = true
		newLabel.rightAnchor.constraint(equalTo: holderSuperView.rightAnchor, constant: rightMargin).isActive = true
		newLabel.bottomAnchor.constraint(equalTo: holderSuperView.bottomAnchor, constant: -4).isActive = true
		newLabel.leftAnchor.constraint(equalTo: holderSuperView.leftAnchor, constant: leftMargin).isActive = true
	}
	
	private func setupImages(for action: IDAlertAction, in holder: UIView) {
		if let image = action.leftImage {
			setupImage(with: image, in: holder, isLeftImage: true)
		}
		if let image = action.rightImage {
			setupImage(with: image, in: holder, isLeftImage: false)
		}
	}
	
	private func setupImage(with image: UIImage, in holder: UIView, isLeftImage: Bool) {
		let imageView = UIImageView(frame: .zero)
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.image = image
		imageView.tintColor = alertController.view.tintColor
		imageView.contentMode = .scaleAspectFit
		
		let holderSuperView = holder.superview!
		holder.addSubview(imageView)
		
		if isLeftImage {
			imageView.leftAnchor.constraint(equalTo: holderSuperView.leftAnchor, constant: 16).isActive = true
		} else {
			imageView.rightAnchor.constraint(equalTo: holderSuperView.rightAnchor, constant: -16).isActive = true
		}
		imageView.centerYAnchor.constraint(equalTo: holderSuperView.centerYAnchor, constant: 0).isActive = true
		imageView.widthAnchor.constraint(equalToConstant: 28).isActive = true
		imageView.heightAnchor.constraint(equalToConstant: 28).isActive = true
	}
	
}

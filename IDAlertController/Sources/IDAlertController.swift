//
//  IDAlertController.swift
//  IDAlertController
//
//  Created by Omid Golparvar on 4/30/19.
//  Copyright © 2019 Omid Golparvar. All rights reserved.
//

import UIKit

public class IDAlertController: NSObject {
	
	internal var alertController			: UIAlertController!
	internal var idHeader					: IDAlertHeader?			= nil
	internal var idHeaderView				: IDAlertHeaderView?		= nil
	internal var idActions					: [IDAlertAction]			= []
	internal var sourceView					: UIView?					= nil
	internal var permittedArrowDirections	: UIPopoverArrowDirection	= [.down, .up]
	internal var sourceViewController		: UIViewController!
	
	public init(header: IDAlertHeader?, actions: [IDAlertAction], preferredStyle: UIAlertController.Style) {
		super.init()
		
		self.idHeader = header
		self.alertController = .init(title: nil, message: nil, preferredStyle: preferredStyle)
		self.addIDActions(actions)
	}
	
	public init(headerView: IDAlertHeaderView, actions: [IDAlertAction], preferredStyle: UIAlertController.Style) {
		super.init()
		
		self.idHeaderView = headerView
		self.alertController = .init(title: "__CUSTOM_CONTENT_MARKER__", message: nil, preferredStyle: preferredStyle)
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
	
	internal func setSourceViewController(_ viewController: UIViewController) {
		self.sourceViewController = viewController
	}
	
	internal func setupViewsBeforePresentation() {
		setupPopoverPresentationController()
		setupIDHeaderRelatedViews()
	}
	
	internal func setupViewsAfterPresentation() {
		setupIDActionsRelatedViews()
	}
	
	public func setTintColor(_ color: UIColor) {
		self.alertController.view.tintColor = color
	}
	
	public func setupPopoverPresentationController(sourceView: UIView, permittedArrowDirections: UIPopoverArrowDirection) {
		self.sourceView = sourceView
		self.permittedArrowDirections = permittedArrowDirections
	}
	
}

extension IDAlertController {
	
	private func setupIDHeaderRelatedViews() {
		if let _ = idHeader {
			setupIDAlertTitleAndMessage()
		} else if let _ = idHeaderView {
			setupIDAlertHeaderView()
		}
	}
	
	private func setupIDAlertTitleAndMessage() {
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
	
	private func setupIDAlertHeaderView() {
		guard let idHeaderView = idHeaderView else { return }
		
		guard
			let label = alertController.view.findAlertControllerContentLabel(),
			let superView = label.superview
			else { return }
		
		let contentView = idHeaderView.contentView
		
		superView.addSubview(contentView)
		
		contentView.translatesAutoresizingMaskIntoConstraints = false
		contentView.topAnchor.constraint(equalTo: superView.topAnchor, constant: 0).isActive = true
		contentView.rightAnchor.constraint(equalTo: superView.rightAnchor, constant: 0).isActive = true
		contentView.leftAnchor.constraint(equalTo: superView.leftAnchor, constant: 0).isActive = true
		contentView.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: 0).isActive = true
		contentView.heightAnchor.constraint(equalToConstant: idHeaderView.height).isActive = true
		
		label.text = ""
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
		let tintColor: UIColor? = action.actionStyle == .destructive ? .red : nil
		if let image = action.leftImage {
			setupImage(with: image, in: holder, isLeftImage: true, tintColor: tintColor)
		}
		if let image = action.rightImage {
			setupImage(with: image, in: holder, isLeftImage: false, tintColor: tintColor)
		}
	}
	
	private func setupImage(with image: UIImage, in holder: UIView, isLeftImage: Bool, tintColor: UIColor?) {
		let imageView = UIImageView(frame: .zero)
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.image = image
		imageView.tintColor = tintColor ?? alertController.view.tintColor
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
	
	private func setupPopoverPresentationController() {
		let view = sourceView ?? sourceViewController.view!
		let permittedArrowDirections = sourceView == nil ? [] : self.permittedArrowDirections
		alertController.popoverPresentationController?.sourceView = view
		alertController.popoverPresentationController?.sourceRect = view.bounds
		alertController.popoverPresentationController?.permittedArrowDirections = permittedArrowDirections
	}
	
}

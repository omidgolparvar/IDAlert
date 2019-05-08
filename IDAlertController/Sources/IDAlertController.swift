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
		let actionStyle: UIAlertAction.Style
		switch action.actionContent {
		case .normal(let content):
			actionStyle = content.actionStyle
		case .titleAndSubtitle(let content):
			actionStyle = content.actionStyle
		}
		let newAction = UIAlertAction(title: " ", style: actionStyle) { (_) in
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
		switch action.actionContent {
		case .normal(let content):
			let newLabel = UILabel(frame: .zero)
			newLabel.translatesAutoresizingMaskIntoConstraints = false
			newLabel.font = content.textFont ?? IDAlertAction.TitleTextFont
			newLabel.text = content.title
			newLabel.textColor = content.textColor ?? alertController.view.tintColor
			newLabel.textAlignment = content.textAlignment
			
			let rightMargin	: CGFloat
			let leftMargin	: CGFloat
			
			if content.textAlignment == .center {
				rightMargin = content.hasImage ? -60 : -16
				leftMargin = content.hasImage ? 60 : 16
			} else {
				rightMargin = content.rightImage == nil ? -16 : -60
				leftMargin = content.leftImage == nil ? 16 : 60
			}
			
			let holderSuperView = holder.superview!
			holder.addSubview(newLabel)
			newLabel.topAnchor.constraint(equalTo: holderSuperView.topAnchor, constant: 4).isActive = true
			newLabel.rightAnchor.constraint(equalTo: holderSuperView.rightAnchor, constant: rightMargin).isActive = true
			newLabel.bottomAnchor.constraint(equalTo: holderSuperView.bottomAnchor, constant: -4).isActive = true
			newLabel.leftAnchor.constraint(equalTo: holderSuperView.leftAnchor, constant: leftMargin).isActive = true
		case .titleAndSubtitle(let content):
			let finalAttributedString = NSMutableAttributedString(string: "", attributes: nil)
			
			let paragraphStyle = NSMutableParagraphStyle()
			paragraphStyle.alignment = .right
			
			let titleAttributedString = NSAttributedString(string: content.title + "\n", attributes: [
				.font: (content.titleFont ?? IDAlertAction.TitleTextFont),
				.foregroundColor: (content.titleColor ?? .black),
				.paragraphStyle: paragraphStyle
				]
			)
			let subtitleAttributedString = NSAttributedString(string: content.subtitle, attributes: [
				.font: (content.subtitleFont ?? IDAlertAction.SubtitleTextFont),
				.foregroundColor: (content.subtitleColor ?? .darkGray),
				.paragraphStyle: paragraphStyle
				]
			)
			
			finalAttributedString.append(titleAttributedString)
			finalAttributedString.append(subtitleAttributedString)
			
			let newLabel = UILabel(frame: .zero)
			newLabel.translatesAutoresizingMaskIntoConstraints = false
			newLabel.numberOfLines = 0
			newLabel.attributedText = finalAttributedString
			
			
			let holderSuperView = holder.superview!
			holder.addSubview(newLabel)
			newLabel.topAnchor.constraint(equalTo: holderSuperView.topAnchor, constant: 8).isActive = true
			newLabel.rightAnchor.constraint(equalTo: holderSuperView.rightAnchor, constant: -16).isActive = true
			newLabel.bottomAnchor.constraint(equalTo: holderSuperView.bottomAnchor, constant: -8).isActive = true
			newLabel.leftAnchor.constraint(equalTo: holderSuperView.leftAnchor, constant: 16).isActive = true
			newLabel.heightAnchor.constraint(equalToConstant: content.actionHeight ?? 80).isActive = true
		}
	}
	
	private func setupImages(for action: IDAlertAction, in holder: UIView) {
		guard case let .normal(content) = action.actionContent else { return }
		
		let tintColor: UIColor? = content.actionStyle == .destructive ? .red : nil
		if let image = content.leftImage {
			setupImage(with: image, in: holder, isLeftImage: true, tintColor: tintColor)
		}
		if let image = content.rightImage {
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

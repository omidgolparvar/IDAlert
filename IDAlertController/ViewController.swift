//
//  ViewController.swift
//  IDAlertController
//
//  Created by Omid Golparvar on 4/30/19.
//  Copyright © 2019 Omid Golparvar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var segment_AlertStyle					: UISegmentedControl!
	@IBOutlet weak var button_PresentWithTitleAndMessage	: UIButton!
	@IBOutlet weak var button_PresentWithCustomHeaderView	: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		[button_PresentWithTitleAndMessage!, button_PresentWithCustomHeaderView!].forEach {
			$0.layer.cornerRadius = 6
			$0.clipsToBounds = true
			$0.layer.borderColor = $0.tintColor.cgColor
			$0.layer.borderWidth = 1.0
		}
	}
	
	@IBAction func actionPresentIDAlertController(_ sender: UIButton) {
		switch sender {
		case button_PresentWithTitleAndMessage:
			presentIDAlertController(customViewAsHeader: false, sourceView: sender)
		case button_PresentWithCustomHeaderView:
			presentIDAlertController(customViewAsHeader: true, sourceView: sender)
		default:
			break
		}
	}
	
	
	private func presentIDAlertController(customViewAsHeader: Bool, sourceView: UIButton) {
		var idAlertAction = IDAlertAction(title: "گزینه نمایشی باحال") {
			print("Ok.")
		}
		
		idAlertAction.setupImages(leftImage: #imageLiteral(resourceName: "Image1"), rightImage: #imageLiteral(resourceName: "Image0"))
		idAlertAction.setupText(alignment: .center, color: nil, font: nil)
		
		var idAlertAction_Delete = IDAlertAction(title: "یک گزینه خطرناک!") {
			print("Deleted.")
		}
		idAlertAction_Delete.setupText(alignment: .right, color: .red, font: nil)
		idAlertAction_Delete.setupImages(leftImage: #imageLiteral(resourceName: "Image0"), rightImage: nil)
		idAlertAction_Delete.setActionStyle(.destructive)
		
		var idAlertAction_Cancel = IDAlertAction(title: "بازگشت", handler: nil)
		idAlertAction_Cancel.setActionStyle(.cancel)
		
		let alertControllerStyle: UIAlertController.Style
		switch segment_AlertStyle.selectedSegmentIndex {
		case 0	: alertControllerStyle = .alert
		case 1	: alertControllerStyle = .actionSheet
		default	: fatalError("WTF?!")
		}
		
		let idAlertActions = [idAlertAction, idAlertAction_Delete, idAlertAction_Cancel]
		
		let idAlertController: IDAlertController
		
		if customViewAsHeader {
			let customView = CustomView(frame: .zero)
			customView.setup(
				title		: "عنوان نمونه",
				message		: "این یک متن نمونه است که می‌تواند دارای بیشتر از یک خط نیز باشد. و باید بدرستی نمایش داده شود.",
				valueToCopy	: "12345"
			)
			
			let idAlertHeaderView = IDAlertHeaderView(contentView: customView, height: 140)
			
			idAlertController = IDAlertController(
				headerView		: idAlertHeaderView,
				actions			: idAlertActions,
				preferredStyle	: alertControllerStyle
			)
		} else {
			let idAlertHeader = IDAlertHeader(
				title	: "عنوان نمونه",
				message	: "این یک متن نمونه است که می‌تواند دارای بیشتر از یک خط نیز باشد. و باید بدرستی نمایش داده شود."
			)
			
			idAlertController = IDAlertController(
				header			: idAlertHeader,
				actions			: idAlertActions,
				preferredStyle	: alertControllerStyle
			)
		}
		
		
		idAlertController.setupPopoverPresentationController(
			sourceView					: sourceView,
			permittedArrowDirections	: [.up, .down]
		)
		
		self.present(idAlertController, animated: true, completion: nil)
	}
	
}


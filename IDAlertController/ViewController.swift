//
//  ViewController.swift
//  IDAlertController
//
//  Created by Omid Golparvar on 4/30/19.
//  Copyright © 2019 Omid Golparvar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var segment_AlertStyle		: UISegmentedControl!
	@IBOutlet weak var switch_HasTitle			: UISwitch!
	@IBOutlet weak var switch_HasMessage		: UISwitch!
	@IBOutlet weak var switch_HasLeftImage		: UISwitch!
	@IBOutlet weak var switch_HasRightImage		: UISwitch!
	@IBOutlet weak var segment_TextAlignment	: UISegmentedControl!
	@IBOutlet weak var button_Present			: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		button_Present.layer.cornerRadius = button_Present.frame.height / 2.0
		button_Present.clipsToBounds = true
		button_Present.layer.borderColor = button_Present.tintColor.cgColor
		button_Present.layer.borderWidth = 2.0
		
		segment_TextAlignment.setTitleTextAttributes([.font: UIFont(name: "Vazir", size: 13)!], for: .normal)
	}
	
	@IBAction func actionPresentIDAlertController(_ sender: UIButton) {
		
		let idAlertHeader = IDAlertHeader(
			title	: switch_HasTitle.isOn ? "یک عنوان نمونه" : nil,
			message	: switch_HasMessage.isOn ? "این یک پیام نمونه است که می‌تواند دارای بیشتر از یک خط نیز باشد." : nil
		)
		
		
		var idAlertAction = IDAlertAction(title: "گزینه نمایشی مورد نظر ما") {
			print("Ok.")
		}
		idAlertAction.setupImages(
			leftImage	: switch_HasLeftImage.isOn ? #imageLiteral(resourceName: "Image0") : nil,
			rightImage	: switch_HasRightImage.isOn ? #imageLiteral(resourceName: "Image1") : nil
		)
		
		var idAlertAction_Cancel = IDAlertAction(title: "بازگشت", handler: nil)
		idAlertAction_Cancel.setActionStyle(.cancel)
		
		let textAlignment: NSTextAlignment
		switch segment_TextAlignment.selectedSegmentIndex {
		case 0	: textAlignment = .left
		case 1	: textAlignment = .center
		case 2	: textAlignment = .right
		default	:fatalError("WTF?!")
		}
		idAlertAction.setupText(alignment: textAlignment, color: nil, font: nil)
		
		let alertControllerStyle: UIAlertController.Style
		switch segment_AlertStyle.selectedSegmentIndex {
		case 0	: alertControllerStyle = .alert
		case 1	: alertControllerStyle = .actionSheet
		default	: fatalError("WTF?!")
		}
		let idAlertController = IDAlertController(
			header			: idAlertHeader,
			actions			: [idAlertAction, idAlertAction_Cancel],
			preferredStyle	: alertControllerStyle
		)
		idAlertController.setupPopoverPresentationController(sourceView: button_Present, permittedArrowDirections: [.up, .down])
		
		self.present(idAlertController, animated: true, completion: nil)
	}
	
}


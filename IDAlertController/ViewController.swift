import UIKit

final class ViewController: UIViewController {
	
	@IBOutlet weak var segment_AlertStyle					: UISegmentedControl!
	@IBOutlet weak var button_PresentWithTitleAndMessage	: UIButton!
	@IBOutlet weak var button_PresentWithCustomHeaderView	: UIButton!
	@IBOutlet weak var button_PresentWithTitleAndSubtitle	: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let buttons = [
			button_PresentWithTitleAndMessage!,
			button_PresentWithCustomHeaderView!,
			button_PresentWithTitleAndSubtitle!
		]
		buttons.forEach { button in
			button.layer.cornerRadius = 6
			button.clipsToBounds = true
			button.layer.borderColor = button.tintColor.cgColor
			button.layer.borderWidth = 1.0
		}
	}
	
	@IBAction func actionPresentIDAlertController(_ sender: UIButton) {
		switch sender {
		case button_PresentWithTitleAndMessage:
			presentIDAlertController(customViewAsHeader: false, sourceView: sender)
		case button_PresentWithCustomHeaderView:
			presentIDAlertController(customViewAsHeader: true, sourceView: sender)
		case button_PresentWithTitleAndSubtitle:
			presentIDAlertControllerForActionsWithTitleAndSubtitle(sourceView: sender)
		default:
			break
		}
	}
	
	
	private func presentIDAlertController(customViewAsHeader: Bool, sourceView: UIButton) {
		
		let idAlertAction_0 = IDAlertAction.InitializeNormalAction(
			title		: "گزینه نمایشی باحال",
			alignment	: .center,
			leftImage	: #imageLiteral(resourceName: "Image1"),
			rightImage	: #imageLiteral(resourceName: "Image0")) {
				print("Ok.")
		}
		
		let idAlertAction_1 = IDAlertAction.InitializeNormalAction(
			title		: "یک گزینه خطرناک!",
			alignment	: .right,
			leftImage	: #imageLiteral(resourceName: "Image0"),
			actionStyle	: .destructive) {
				print("Deleted.")
		}
		
		let idAlertAction_2 = IDAlertAction.InitializeNormalAction(
			title		: "بازگشت",
			actionStyle	: .cancel,
			handler		: nil)
		
		
		let alertControllerStyle: UIAlertController.Style
		switch segment_AlertStyle.selectedSegmentIndex {
		case 0	: alertControllerStyle = .alert
		case 1	: alertControllerStyle = .actionSheet
		default	: fatalError("WTF?!")
		}
		
		let idAlertActions = [idAlertAction_0, idAlertAction_1, idAlertAction_2]
		
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
		
		present(idAlertController, animated: true, completion: nil)
		
	}
	
	private func presentIDAlertControllerForActionsWithTitleAndSubtitle(sourceView: UIButton) {
		
		let idAlertAction_0 = IDAlertAction.InitializeTitleAndSubtitleAction(
			title			: "یک گزینه زیبا",
			titleColor		: self.view.tintColor,
			subtitle		: "با زدن این گزینه، هیچ اتفاق خاصی نمیوفته! ولی زدنش خالی از لطف نیست!!",
			subtitleColor	: self.view.tintColor) {
				print("OK.")
		}
		
		let idAlertAction_1 = IDAlertAction.InitializeTitleAndSubtitleAction(
			title		: "یک گزینه خطرناک!!",
			titleColor	: .red,
			subtitle	: "ترس نداره که!! با زدن اینم هیچ اتفاقی نمیوفته. ولی بزنین؛ طوری نمیشه.",
			actionStyle	: .destructive) {
				print("Deleted.")
		}
		
		let idAlertAction_2 = IDAlertAction.InitializeNormalAction(
			title		: "بازگشت",
			actionStyle	: .cancel,
			handler		: nil)
		
		
		let alertControllerStyle: UIAlertController.Style
		switch segment_AlertStyle.selectedSegmentIndex {
		case 0	: alertControllerStyle = .alert
		case 1	: alertControllerStyle = .actionSheet
		default	: fatalError("WTF?!")
		}
		
		let idAlertActions = [idAlertAction_0, idAlertAction_1, idAlertAction_2]
		
		let idAlertHeader = IDAlertHeader(
			title	: "عنوان نمونه",
			message	: "این یک متن نمونه است که می‌تواند دارای بیشتر از یک خط نیز باشد. و باید بدرستی نمایش داده شود."
		)
		
		let idAlertController = IDAlertController(
			header			: idAlertHeader,
			actions			: idAlertActions,
			preferredStyle	: alertControllerStyle
		)
		
		idAlertController.setupPopoverPresentationController(
			sourceView					: sourceView,
			permittedArrowDirections	: [.up, .down]
		)
		
		present(idAlertController, animated: true, completion: nil)
		
	}
	
}


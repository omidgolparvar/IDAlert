import Foundation
import UIKit

public struct IDAlertHeader {
	
	public static var TitleFont		: UIFont	= .systemFont(ofSize: 16, weight: .bold)
	public static var TitleColor	: UIColor	= .black
	public static var MessageFont	: UIFont	= .systemFont(ofSize: 14, weight: .regular)
	public static var MessageColor	: UIColor	= .darkGray
	
	internal var title			: String?	= nil
	internal var titleFont		: UIFont?	= nil
	internal var titleColor		: UIColor?	= nil
	internal var message		: String?	= nil
	internal var messageFont	: UIFont?	= nil
	internal var messageColor	: UIColor?	= nil
	
	public init(title: String?, message: String?) {
		self.title		= title
		self.message	= message
	}
	
	public mutating func setupTitle(font: UIFont?, color: UIColor?) {
		self.titleFont = font
		self.titleColor = color
	}
	
	public mutating func setupMessage(font: UIFont?, color: UIColor?) {
		self.messageFont = font
		self.messageColor = color
	}
	
	
}

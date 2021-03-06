import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		IDAlertHeader.TitleFont			= UIFont(name: "Vazir-Bold", size: 16)!
		IDAlertHeader.MessageFont		= UIFont(name: "Vazir", size: 14)!
		
		IDAlertAction.TitleTextFont		= UIFont(name: "Vazir-Medium", size: 18)!
		IDAlertAction.SubtitleTextFont	= UIFont(name: "Vazir", size: 14)!
		
		return true
	}
	
}


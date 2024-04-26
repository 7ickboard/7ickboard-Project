
import UIKit
import SnapKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setUpTabBar()
        setUpVCs()
    }

    func setUpTabBar() {
        tabBar.backgroundColor = .white
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        tabBar.clipsToBounds = true
    }

    func setUpVCs() {
        let storyboard = UIStoryboard(name: "MyPageStoryboard", bundle: .main)
        let myPageViewController = storyboard.instantiateViewController(withIdentifier: "MyPageStoryboard") as! MyPageViewController

        viewControllers = [
            createNavController(for: MapViewController(), title: NSLocalizedString("메인홈", comment: ""), image: UIImage(systemName: "circle")!),
            createNavController(for: RegisterViewController(), title: NSLocalizedString("등록", comment: ""), image: UIImage(systemName: "triangle")!),
            createNavController(for: myPageViewController, title: NSLocalizedString("등록", comment: ""), image: UIImage(systemName: "triangle")!),
        ]
    }

    private func createNavController(for rootViewController: UIViewController,
                                     title: String,
                                     image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image

        return navController
    }
}

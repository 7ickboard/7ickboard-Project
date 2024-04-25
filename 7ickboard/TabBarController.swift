
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
//        tabBar.unselectedItemTintColor = MySpecialColors.gray
//        tabBar.tintColor = MySpecialColors.tabBarTint
        tabBar.backgroundColor = .white
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        tabBar.clipsToBounds = true
    }

    func setUpVCs() {
        viewControllers = [
            createNavController(for: MapViewController(), title: NSLocalizedString("메인홈", comment: ""), image: UIImage(systemName: "circle")!),
            createNavController(for: RegisterViewController(), title: NSLocalizedString("등록", comment: ""), image: UIImage(systemName: "triangle")!),
        ]
    }

    private func createNavController(for rootViewController: UIViewController,
                                     title: String,
                                     image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image

//        navController.navigationBar.backgroundColor = MySpecialColors.cellGray
//        navController.navigationBar.prefersLargeTitles = true
//        rootViewController.navigationItem.title = title
        return navController
    }
}


import UIKit
import SnapKit
import MapKit
import CoreLocation


class RegisterViewController: UIViewController {

    var mapView = MKMapView()

    let locationManager = CLLocationManager()

    lazy var registerButton: UIButton = {
        let btn = UIButton()

        btn.setTitle("현 위치에 등록하기", for: .normal)
        btn.backgroundColor = .lightGray
        btn.addAction(registerAction, for: .touchUpInside)

        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        registerButton.translatesAutoresizingMaskIntoConstraints = false

        self.navigationController?.navigationBar.isHidden = true

        view.addSubview(mapView)
        view.addSubview(registerButton)

        mapView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }

        registerButton.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.height.equalTo(28)
        }

        setupMapView()
    }

    lazy var registerAction = UIAction { action in
        KickBoard.kickboards.append(KickBoard(name: "1", latitude: self.locationManager.location!.coordinate.latitude, longitude: self.locationManager.location!.coordinate.longitude))
    }
}

extension RegisterViewController: MKMapViewDelegate, CLLocationManagerDelegate {

    func setupMapView() {
        mapView.delegate = self
        locationManager.delegate = self

        mapView.isScrollEnabled = false
        mapView.isZoomEnabled = false

        let coordinate = locationManager.location?.coordinate
        let region = MKCoordinateRegion(center: coordinate!, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)

        mapView.showsUserLocation = true
    }


    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !annotation.isKind(of: MKUserLocation.self) else {
            return nil
        }

        let annotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: "Custom")

        return annotationView
    }
}

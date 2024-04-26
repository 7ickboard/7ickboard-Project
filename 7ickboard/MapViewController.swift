import UIKit
import MapKit
import SnapKit
import CoreLocation


class MapViewController: UIViewController {

    var address = ""

    var isRiding = false {
        willSet(newValue) {
            newValue ?
            containerStackView.addArrangedSubview(returnBicycleButton) :
            returnBicycleButton.removeFromSuperview()
        }
    }

    var ridingTime: (Date?, Date?)

    var occupiedAnnotation: KickBoardAnnotation?

    var mapView = MKMapView()

    let locationManager = CLLocationManager()

    let containerStackView: UIStackView = {
        let stackView = UIStackView()

        stackView.backgroundColor = .darkGray

        return stackView
    }()

    let goToMyLocationButton: UIButton = {
        let btn = UIButton()

        btn.setImage(UIImage(systemName: "scope"), for: .normal)
        btn.backgroundColor = .lightGray

        return btn
    }()

    lazy var returnBicycleButton: UIButton = {
        let btn = UIButton()

        btn.setTitle("반납하기", for: .normal)
        btn.backgroundColor = .gray
        btn.addTarget(self, action: #selector(returnMyBicycle), for: .touchUpInside)

        return btn
    }()

    lazy var occupyingBicycleButton: UIButton = {
        let btn = UIButton()

        btn.setTitle("이용하기", for: .normal)
        btn.backgroundColor = .gray
        btn.addTarget(self, action: #selector(occupyingBicycle), for: .touchUpInside)

        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        setConstraints()

        setupMapView()
        findMyLocation()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        createAnnotaions()
    }

    private func setUpUI() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        goToMyLocationButton.translatesAutoresizingMaskIntoConstraints = false
        returnBicycleButton.translatesAutoresizingMaskIntoConstraints = false
        occupyingBicycleButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(mapView)
        view.addSubview(goToMyLocationButton)
        view.addSubview(containerStackView)

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "주소검색", style: .done, target: self, action: #selector(getAddress))

        goToMyLocationButton.addTarget(self, action: #selector(findMyLocation), for: .touchUpInside)
    }

    private func setConstraints() {
        mapView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        goToMyLocationButton.snp.makeConstraints {
            $0.height.equalTo(28)
            $0.width.equalTo(28)
            $0.trailing.equalToSuperview().offset(-10)
            $0.bottom.equalTo(containerStackView.snp.top).offset(-10)
        }

        containerStackView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.height.greaterThanOrEqualTo(0)
        }
    }

    @objc
    func getAddress() {
        let nextVC = KakaoZipCodeViewController()
        nextVC.completioHandler = { str in
            Task {
                var address: KakaoLocation?

                await address = self.getLocationByAddress(str)
                await self.setSearchedRegion(address: address!)
            }

        }
        present(nextVC, animated: true)
    }

    @objc
    func findMyLocation() {
        debugPrint(#function)
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(.follow, animated: true)
    }

    @objc
    func returnMyBicycle() {
        debugPrint(#function)

        let annotation = KickBoardAnnotation(id: occupiedAnnotation!.id, coordinate: locationManager.location!.coordinate)
        KickBoard.kickboards.append(KickBoard(id: occupiedAnnotation!.id, name: "", latitude: locationManager.location!.coordinate.latitude, longitude: locationManager.location!.coordinate.longitude))
        isRiding = false
        ridingTime.1 = Date()

        //adding ridingTime to User
        print(ridingTime)
        UserModel.updateRidingTime(forUserId: UserModel.users[0].id, startTime: ridingTime.0, endTime: ridingTime.1)

        occupiedAnnotation = nil

        mapView.addAnnotation(annotation)
    }

    @objc
    func occupyingBicycle() {
        debugPrint(#function)
        occupyingBicycleButton.removeFromSuperview()
        isRiding = true

        ridingTime.0 = Date()

        KickBoard.kickboards.remove(at: KickBoard.kickboards.firstIndex(where: { kickboard in
            kickboard.id == occupiedAnnotation!.id
        })!)
        mapView.removeAnnotation(occupiedAnnotation!)
    }

    func createAnnotaions() {
        mapView.removeAnnotations(mapView.annotations)

        KickBoard.kickboards.forEach { kickboard in
            let annotation = KickBoardAnnotation(id: kickboard.id, coordinate: kickboard.coordinate2D)

            mapView.addAnnotation(annotation)
        }
    }

    //Network
    func getLocationByAddress(_ str: String) async -> KakaoLocation? {
        // URLComponents를 사용하여 URL 구성
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "dapi.kakao.com"
        urlComponents.path = "/v2/local/search/address"
        urlComponents.queryItems = [
            URLQueryItem(name: "query", value: str)
        ]

        print(urlComponents.url!)

        // URLRequest 인스턴스 생성
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET" // 요청에 사용할 HTTP 메서드 설정

        // HTTP 헤더 설정
        request.setValue("KakaoAK 624f6f4ad5f7f29ddc4ec56b4a6a4f3d", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            //디코딩까지 묶어서 작업한 뒤 리턴
            let (data, _) = try await URLSession.shared.data(for: request)
            print(data)
            let address = try JSONDecoder().decode(KakaoLocation.self, from: data)

            return address
        }
        catch {
            debugPrint("Error loading : \(String(describing: error))")
            return nil
        }
    }

    func setSearchedRegion(address: KakaoLocation) async {
        let coordinate = CLLocationCoordinate2D(latitude: Double(address.latitude!)!,
                                                longitude: Double(address.longitude!)!)
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }
}

// MARK: - 권한 설정
extension MapViewController {

    func checkCurrentLocationAuthorization(authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        case .restricted:
            print("restricted")
            goSetting()
        case .denied:
            print("denided")
            goSetting()
        case .authorizedAlways:
            print("always")
        case .authorizedWhenInUse:
            print("wheninuse")
            locationManager.startUpdatingLocation()
        @unknown default:
            print("unknown")
        }
        if #available(iOS 15.0, *) {
            let accuracyState = locationManager.accuracyAuthorization
            switch accuracyState {
            case .fullAccuracy:
                print("full")
            case .reducedAccuracy:
                print("reduced")
            @unknown default:
                print("Unknown")
            }
        }
    }

    func goSetting() {

        let alert = UIAlertController(title: "위치권한 요청", message: "위치 권한이 필요합니다.", preferredStyle: .alert)
        let settingAction = UIAlertAction(title: "설정", style: .default) { action in
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { UIAlertAction in

        }

        alert.addAction(settingAction)
        alert.addAction(cancelAction)

        present(alert, animated: true, completion: nil)
    }

    func checkUserLocationServicesAuthorization() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                let authorization: CLAuthorizationStatus

                if #available(iOS 15.0, *) {
                    authorization = self.locationManager.authorizationStatus
                } else {
                    authorization = CLLocationManager.authorizationStatus()
                }

                print("현재 사용자의 authorization status: \(authorization)")

            } else {
                print("위치 권한 허용 꺼져있음")
            }
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkUserLocationServicesAuthorization()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function)
        checkUserLocationServicesAuthorization()
    }
}


extension MapViewController: MKMapViewDelegate, CLLocationManagerDelegate {

    func setupMapView() {
        mapView.delegate = self
        locationManager.delegate = self

        let coordinate = CLLocationCoordinate2D(latitude: 37.27543611,
                                                longitude: 127.4432194)
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !annotation.isKind(of: MKUserLocation.self) else {
            return nil
        }

        var annotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: "Custom")


        let markerView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "Custom")
        markerView.markerTintColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        markerView.glyphTintColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)

        markerView.glyphImage = UIImage(systemName: "bicycle.circle.fill")


        annotationView = markerView
        annotationView?.canShowCallout = false


        return annotationView
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView)
    {
        if !isRiding {
            occupiedAnnotation = (view.annotation as! KickBoardAnnotation)
            containerStackView.addArrangedSubview(occupyingBicycleButton)
        }
        debugPrint("annotaion selected")
    }

    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView)
    {
        occupyingBicycleButton.removeFromSuperview()

        debugPrint("annotaion deselected")
    }

}

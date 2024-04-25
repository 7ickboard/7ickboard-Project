
import Foundation
import CoreLocation

struct KickBoard {
    var id: UUID
    var name: String
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees

    var coordinate2D: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    init(id: UUID = UUID(), name: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        self.id = id
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
}

extension KickBoard {
    static var kickboards: [KickBoard] = [KickBoard(name: "자전거", latitude: 37.51818789942772, longitude: 126.88541765534976)]
}

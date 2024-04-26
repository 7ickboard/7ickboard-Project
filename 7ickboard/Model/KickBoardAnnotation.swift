
import UIKit
import MapKit

class KickBoardAnnotation: NSObject, MKAnnotation {
    let id: UUID
    let coordinate: CLLocationCoordinate2D

    init(id: UUID, coordinate: CLLocationCoordinate2D) {
        self.id = id
        self.coordinate = coordinate

        super.init()
    }
}

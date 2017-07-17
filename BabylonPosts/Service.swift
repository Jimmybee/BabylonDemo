import Foundation
import RxSwift
import ObjectMapper

final class Service<T: Mappable> {
    static func get(target: JsonPlaceholder) -> Observable<NetworkResult> {
        return NetworkProvider.performArrayRequest(with: Mapper<T>(), target: target)
    }
}

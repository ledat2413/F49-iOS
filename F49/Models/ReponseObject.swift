
import UIKit

public protocol ResponseObjectSerializable {
    init?(representation: Any)
}

public extension ResponseObjectSerializable {
    static func collection(representation: Any?) -> [Self] {
        var collection: [Self] = []
        
        if let array = representation as? [Any] {
            for itemRepresentation in array {
                if let item = Self(representation: itemRepresentation) {
                    collection.append(item)
                }
            }
        }
        
        return collection
    }
}

struct EmptyModel: ResponseObjectSerializable {
    
    init?(representation: Any) {
        
    }
}

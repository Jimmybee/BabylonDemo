//
//  IntTransform.swift
//  MyWarmup
//
//  Created by leonstaszak on 22/07/2016.
//  Copyright © 2016 Warmup Plc. All rights reserved.
//

import Foundation
import ObjectMapper

/// Custom tranform which implements TransformType. Used to convert a string int to an Int
/// Use by adding the IntTranform to the map conversion: intObject <- (map["intAsString"], IntTransform())
open class IntTransform: TransformType {
 
    public typealias Object = Int
    public typealias JSON = String
    
    public init() {}
    
    open func transformFromJSON(_ value: Any?) -> Int? {
        if let string = value as? String {
            return Int(string)
        }
        if let int = value as? Int {
            return Int(int)
        }
        return nil
    }
    
    open func transformToJSON(_ value: Int?) -> JSON? {
        guard let value = value else { return nil }
        return value.description
    }
    
   
}

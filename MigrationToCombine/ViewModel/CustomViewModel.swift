//
//  CustomViewModel.swift
//  MigrationToCombine
//
//  Created by Shikha Budhiraja on 12/06/22.
//

import Foundation
import  Combine

enum CustomViewModel {
    
    //Without Using Combine
    static func fetchData(compHandler: @escaping (Result<[CustomModel], Error>) -> Void) {
        
        // runs after 3 sec just to mock a service call
        DispatchQueue.global().asyncAfter(deadline: .now() + 3.0) {
            let customData = [CustomModel(protocolDelegateData: "Protocol1", closureData: "Closure1", combineData: "Combine1"),
                              CustomModel(protocolDelegateData: "Protocol2", closureData: "Closure2", combineData: "Combine2"),
                              CustomModel(protocolDelegateData: "Protocol3", closureData: "Closure3", combineData: "Combine3"),
                              CustomModel(protocolDelegateData: "Protocol4", closureData: "Closure4", combineData: "Combine4"),
                              CustomModel(protocolDelegateData: "Protocol5", closureData: "Closure5", combineData: "Combine5"),
                              CustomModel(protocolDelegateData: "Protocol6", closureData: "Closure6", combineData: "Combine6")
            ]
            compHandler(.success(customData))
        }
    }
    
    // Using Combine
    static func fetchDataUsingCombine() -> Future<[CustomModel], Error> {
        
        return Future { promise in
            
            // runs after 3 sec just to mock a service call
            DispatchQueue.global().asyncAfter(deadline: .now() + 3.0) {
                let customData = [CustomModel(protocolDelegateData: "Protocol1", closureData: "Closure1", combineData: "Combine1"),
                                  CustomModel(protocolDelegateData: "Protocol2", closureData: "Closure2", combineData: "Combine2"),
                                  CustomModel(protocolDelegateData: "Protocol3", closureData: "Closure3", combineData: "Combine3"),
                                  CustomModel(protocolDelegateData: "Protocol4", closureData: "Closure4", combineData: "Combine4"),
                                  CustomModel(protocolDelegateData: "Protocol5", closureData: "Closure5", combineData: "Combine5"),
                                  CustomModel(protocolDelegateData: "Protocol6", closureData: "Closure6", combineData: "Combine6")
                ]
                promise(.success(customData))
            }
        }
    }
    
}

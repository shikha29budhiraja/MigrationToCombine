//
//  Custom.swift
//  MigrationToCombine
//
//  Created by Shikha Budhiraja on 12/06/22.
//

import UIKit
import Combine

//Enum to diffrenciate diffrent kind of binding
enum BindingType {
    case protocolBind(CustomModel?)
    case closureBind(CustomModel?)
    case combineBind(CustomModel?)
}

protocol CustomCellAction {
    func sendDataUsingProtocol(bindType:BindingType )
}

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var usingProtocol: UIButton!
    @IBOutlet weak var usingClosure: UIButton!
    @IBOutlet weak var usingCombine: UIButton!
    
    var dataUsingClosure : ((_ type: BindingType ) -> Void)?
    var delegate: CustomCellAction?
    var dataUsingCombine = PassthroughSubject<BindingType,Never>()
    
    var customModel: CustomModel?
    
    func configure(with data: CustomModel) {
        customModel = data
        usingProtocol.setTitle(data.protocolDelegateData, for: .normal)
        usingClosure.setTitle(data.closureData, for: .normal)
        usingCombine.setTitle(data.combineData, for: .normal)
    }
    
    @IBAction func usingProtocolTapped(_ sender: Any) {
        //Sending Data Using Protocol
        delegate?.sendDataUsingProtocol(bindType: .protocolBind(customModel))
    }
    
    @IBAction func usingClosureTapped(_ sender: Any) {
        //Sending Data Using Closure
        dataUsingClosure?(.closureBind(customModel))
    }
    
    @IBAction func usingCombineTapped(_ sender: Any) {
        //Sending Data Using Combine
        dataUsingCombine.send(.combineBind(customModel))
    }
    
}

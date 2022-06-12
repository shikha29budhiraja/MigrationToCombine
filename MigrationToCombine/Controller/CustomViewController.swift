//
//  ViewController.swift
//  MigrationToCombine
//
//  Created by Shikha Budhiraja on 12/06/22.
//

import UIKit
import Combine

class CustomViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    static let tableIdentifier = "custom"
    var customModels = [CustomModel]()
    var tokens = Set<AnyCancellable>()
    var token: AnyCancellable?
    
    //MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //MARK: - Custom
    
    private func setUpUI() {
        activityIndicator.startAnimating()
        //fetchDataNormally()
        fetchDataUsingCombine()
    }
    
    private func fetchDataNormally() {
        CustomViewModel.fetchData { [weak self] (result) in
            switch result {
            
            case .success(let customModels):
                self?.customModels = customModels
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                    self?.tableView.reloadData()
                }
            case .failure(_):
                print("Error fetching data")
            }
        }
        
    }
    
    private func fetchDataUsingCombine() {
        
        token = CustomViewModel.fetchDataUsingCombine()
            .receive(on: DispatchQueue.main)
            .sink { (completion) in
            switch completion {
            case .finished:
                print("Publisher stopped observing")
            case .failure(_):
                print("Error fetching data")
            }
        } receiveValue: { [weak self] (customModels) in
            self?.customModels = customModels
                self?.activityIndicator.stopAnimating()
                self?.tableView.reloadData()
        }

    }
    func showAlertView(bindtype: BindingType) {
        
        var title: String?
        var message: String?
        
        switch bindtype {
        case .protocolBind(let customModel):
            title = customModel?.protocolDelegateData
            message = "Data Binded and Sent Via Protocol"
        case .closureBind(let customModel):
            title = customModel?.closureData
            message = "Data Binded and Sent Via Closure"
        case .combineBind(let customModel):
            title = customModel?.combineData
            message = "Data Binded and Sent Via Combine"
        }
        
        AlertService.showAlert(with: title, message, in: self)
    }
    
    func bindDataUsingClosure(_ cell: CustomTableViewCell) {
        cell.dataUsingClosure  = { [weak self] (bindType) in
            self?.showAlertView(bindtype: bindType)
        }
    }
    
    func bindDataUsingCombine(_ cell: CustomTableViewCell) {
        cell.dataUsingCombine.sink { [weak self] (bindType) in
            self?.showAlertView(bindtype: bindType)
        }.store(in: &tokens)
        
    }
    
}

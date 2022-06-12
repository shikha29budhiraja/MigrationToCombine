//
//  CustomViewController+Extension.swift
//  MigrationToCombine
//
//  Created by Shikha Budhiraja on 12/06/22.
//

import UIKit

//MARK: - TableView DataSource
extension CustomViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Self.tableIdentifier) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: customModels[indexPath.row])
        cell.delegate = self
        
        //Binding Using Closure
        self.bindDataUsingClosure(cell)
        
        //Binding Using Combine
        self.bindDataUsingCombine(cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 100
       }
}


//MARK: - CustomCellAction

//Binding Using Protocol
extension CustomViewController: CustomCellAction {
    func bindDataUsingProtocol(bindType: BindingType) {
        showAlertView(bindtype: bindType)
    }
}

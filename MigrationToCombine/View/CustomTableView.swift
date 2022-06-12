//
//  CustomTableView.swift
//  MigrationToCombine
//
//  Created by Shikha Budhiraja on 12/06/22.
//

import UIKit

class CustomTableView: UITableView {

    override var contentSize:CGSize {
           didSet {
               invalidateIntrinsicContentSize()
           }
       }

       override var intrinsicContentSize: CGSize {
           layoutIfNeeded()
           return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
       }
}

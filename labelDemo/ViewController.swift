//
//  ViewController.swift
//  labelDemo
//
//  Created by Vijendra kr. on 19/03/19.
//  Copyright © 2019 EL Group. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, refreshTVCDelegate {

    @IBOutlet weak var lblMore: CollapsibleLabel!
    @IBOutlet weak var tblView: UITableView!
    var str: String!
    var arr = [Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.str = "A quick brown fox jumps over a lazy dog  and story begins It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like). "
        self.tblView.tableFooterView = UIView()

        //Label from Storyboard with autoExpand
        lblMore.moreTitle = "Read more"
        lblMore.lessTitle = "Read less"
        lblMore.autoExpand = true
        lblMore.wrapAfterIndex = 75
        lblMore.moreClicked = {
            print("More taped")
        }
        lblMore.lessClicked = {
            print("Less taped")
        }
        lblMore.noneClicked = {
            print("-- None taped")
        }
        
        self.initArray()
        
    }
    
    func initArray() {
        for i in 0..<10 {
            self.arr.insert(false, at: i)
        }
        self.tblView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TVCell = tblView.dequeueReusableCell(withIdentifier: "lblCell") as! TVCell
        cell.lblCollaps.text = self.str
        cell.lblCollaps.tag = indexPath.row
        
        if self.arr.count > indexPath.row {
            if self.arr[indexPath.row] {
                cell.lblCollaps.isExpanded = true
            }
            else {
                cell.lblCollaps.isExpanded = false
            }
        }
        
        cell.lblCollaps.moreClicked = {
            self.arr[indexPath.row] = true
        }
        cell.lblCollaps.lessClicked = {
            self.arr[indexPath.row] = false
        }
        cell.lblCollaps.delegate = self
        cell.selectionStyle = .none
        cell.updateConstraintsIfNeeded()
        return cell
    }
    
    func refreshCellAction(index: Int) {
        self.tblView.beginUpdates()
        self.tblView.endUpdates()
    }

}

class TVCell: UITableViewCell {
    
    @IBOutlet weak var lblCollaps: CollapsibleLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblCollaps.isUserInteractionEnabled = true
        lblCollaps.moreTitle = "Read more"
        lblCollaps.lessTitle = "Read less"
        lblCollaps.autoExpand = true
        lblCollaps.wrapAfterIndex = 75
    }
}




//
//  FDFeedViewController.swift
//  testTableViewHeightCache
//
//  Created by apple on 17/4/27.
//  Copyright © 2017年 XGHL. All rights reserved.
//

import UIKit
import UITableView_FDTemplateLayoutCell

class FDFeedViewController: UITableViewController {

    var prototypeEntitiesFromJSON=[FDFeedEntity]()
    var feedEntitySections=[[FDFeedEntity]]()// 2d array
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.fd_debugLogEnabled=true
        
        self.buildTestDataThen {
            self.feedEntitySections.append(self.prototypeEntitiesFromJSON)
            self.tableView.reloadData()
        }
        
    }

    func buildTestDataThen(then:@escaping ()->()){
        DispatchQueue.global(qos: .userInitiated).async {
            
            // Data from `data.json`
            let dataFilePath = Bundle.main.path(forResource: "data", ofType: "json")
            let data = NSData(contentsOfFile: dataFilePath!) as! Data
            let rootDict = try? JSONSerialization.jsonObject(with: data , options:JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
            let feedDicts = rootDict?["feed"] as! NSArray
            
            // Convert to `FDFeedEntity`
            
            var entities = [FDFeedEntity]()
            feedDicts.enumerateObjects({ object, index, stop in
                entities.append(FDFeedEntity.init(dictionary: object as! Dictionary<String, String> ))
            })
            self.prototypeEntitiesFromJSON = entities 
            
            // Callback
            DispatchQueue.main.async {
                then();
            }
        }
    }
}

extension FDFeedViewController{
    
    //datasource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return (self.feedEntitySections.count)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.feedEntitySections[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FDFeedCellID",for: indexPath) as! FDFeedCell
        cell.fd_enforceFrameLayout=false
        self.configCell(cell: cell,atIndexPath: indexPath )
        return cell
    }
    
    func configCell(cell:FDFeedCell,atIndexPath indexPath:IndexPath){
        if (indexPath.row % 2 == 0) {
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        } else {
            cell.accessoryType = UITableViewCellAccessoryType.checkmark
        }
        let temp = self.feedEntitySections[indexPath.section][indexPath.row]
        cell.setEntity(entity: temp)
    }
    
    //delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
//        return tableView.fd_heightForCell(withIdentifier: "FDFeedCellID", configuration: { (make) -> Void in
//            let scell = make as! FDFeedCell
//            self.configCell(cell: scell, atIndexPath: indexPath)
//        
//        })
        
        return tableView.fd_heightForCell(withIdentifier: "FDFeedCellID", cacheBy: indexPath, configuration: { (make) -> Void in
            let scell = make as! FDFeedCell
            self.configCell(cell: scell, atIndexPath: indexPath)
        })
        
//        let entity = self.feedEntitySections[indexPath.section][indexPath.row];
//        return tableView.fd_heightForCell(withIdentifier: "FDFeedCellID", cacheByKey: entity.identifier as NSCopying!, configuration:{ (make) -> Void in
//                let scell = make as! FDFeedCell
//                self.configCell(cell: scell, atIndexPath: indexPath)
//            })

    }
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == UITableViewCellEditingStyle.delete{
//            var mutableEntities = self.feedEntitySections[indexPath.section]
//            mutableEntities.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
//        }
//    }

}

//
//  AppSoViewController.swift
//  ifanr
//
//  Created by sys on 16/7/7.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit
import Alamofire

class AppSoViewController: BasePageController {

    override func viewDidLoad() {

        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        pullToRefresh.delegate = self
        
        tableView.sectionHeaderHeight = tableHeaderView.height
        tableView.tableHeaderView = tableHeaderView
        
        getData()
    }
    
    
    func getData(_ page: Int = 1) {
        isRefreshing = true
        
        let type: CommonModel? = CommonModel(dict: [:])
        IFanrService.shareInstance.getData(APIConstant.appSo_latest(page), t: type, keys: ["data"], successHandle: { (modelArray) in
            
            if page == 1 {
                self.page = 1
                self.appSoModelArray.removeAll()
            }
            // 添加数据
            modelArray.forEach {
                self.appSoModelArray.append($0)
            }
            self.page += 1
            self.isRefreshing = false
            self.tableView.reloadData()
            self.pullToRefresh.endRefresh()
            
            }) { (error) in
        }
        
//        IFanrService.shareInstance.getLatesModel(APIConstant.AppSo_latest(page), successHandle: { (modelArray) in
//            if page == 1 {
//                self.page = 1
//                self.appSoModelArray.removeAll()
//            }
//            // 添加数据
//            modelArray.forEach {
//                self.appSoModelArray.append($0)
//            }
//            self.page += 1
//            self.isRefreshing = false
//            self.tableView.reloadData()
//            self.pullToRefresh.endRefresh()
//        }) { (error) in
//            print(error)
//        }
    }
    //MARK: --------------------------- Getter and Setter --------------------------
     /// 这个属性放到ScrollViewControllerReusable协议， 会初始化两次。所以放到这里好了
    var tableHeaderView: UIView! = {
        return TableHeaderView(model: TableHeaderModelArray[2])
    }()
    
    var appSoModelArray = Array<CommonModel>()
}

// MARK: - 下拉刷新回调
// MARK: - 下拉刷新回调
extension AppSoViewController: PullToRefreshDelegate {
    func pullToRefreshViewDidRefresh(_ pulllToRefreshView: PullToRefreshView) {
        getData()
    }
}

// MARK: - 上拉加载更多
extension AppSoViewController {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        super.scrollViewDidScroll(scrollView)
        if differY < happenY {
            if !isRefreshing {
                // 这里处理上拉加载更多
                getData(page)
            }
        }
    }
}

// MARK: - tableView代理和数据源
extension AppSoViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = nil
        let curModel = self.appSoModelArray[indexPath.row];
        
        debugPrint(curModel.app_icon_url)
        
        if curModel.app_icon_url != "" {
            cell    = AppSoTableViewCell.cellWithTableView(tableView)
            (cell as! AppSoTableViewCell).model = curModel
        } else {
            cell    = PlayingZhiTableViewCell.cellWithTableView(tableView)
            (cell as! PlayingZhiTableViewCell).appSoModel = curModel
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.appSoModelArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AppSoTableViewCell.estimateCellHeight(self.appSoModelArray[indexPath.row].title!) + 20
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let appSoModel: CommonModel = self.appSoModelArray[indexPath.row]
        let ifDetailController = IFDetailsController(model: appSoModel, naviTitle: "AppSo")
        self.navigationController?.pushViewController(ifDetailController, animated: true)
    }
}

//
//  NewsViewController.swift
//  NewsApp
//
//  Created by RAC INFRA RENTAL LLP on 14/09/19.
//  Copyright © 2019 RAC INFRA RENTAL LLP. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
   
    let viewModel = NewsViewModel()
    var refreshControl = UIRefreshControl()
    
    @IBOutlet var tblNewsList: UITableView!
    private final let kPullToRefresh = "Pull to refresh"
    private final let kError = "Error"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "News List"
        callNewsApi()
        setupRefreshControl()
        // Do any additional setup after loading the view.
    }
    
    //MARK: Refresh Method
    private func setupRefreshControl() {
        
        refreshControl.attributedTitle = NSAttributedString(string: kPullToRefresh)
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        tblNewsList.addSubview(refreshControl)
    }
    
    @objc func refresh(sender:AnyObject) {
        callNewsApi()
    }
    
     //MARK: API Call
    private func callNewsApi() {
        
        Utility.shared.showActivityIndicator()
        
        viewModel.getNewsListApi { [weak self] (data) in
            
            guard let weakSelf = self else { return }
            
            DispatchQueue.main.async {
                
                Utility.shared.hideActivityIndicator()
                weakSelf.refreshControl.endRefreshing()
                weakSelf.tblNewsList.isHidden = false
                
                guard data != nil else {
                    weakSelf.presentAlert(withTitle: weakSelf.kError, message: weakSelf.viewModel.errorMessage ?? "")
                    return
                }
                weakSelf.tblNewsList.reloadData()
            }
        }
    }
    
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: Tableview Delegate Method

extension NewsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsListTableViewCell", for: indexPath) as? NewsListTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.cellViewModel = NewsCellViewModel()
        cell.cellViewModel?.news = viewModel.newsList[indexPath.row]
        cell.configureCell()
        return cell
    }
}

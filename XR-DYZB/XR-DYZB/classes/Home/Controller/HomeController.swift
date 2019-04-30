//
//  HomeController.swift
//  XR-DYZB
//
//  Created by xueranit on 2019/4/29.
//  Copyright © 2019 xr. All rights reserved.
//

import UIKit

private var titleViewH : CGFloat = 40

class HomeController: UIViewController {

    
//    懒加载
    //头部
    private lazy var pageTitleView:PageTitleView = {
       
        let titles = ["推荐","游戏","娱乐","趣玩"]
        
        let titleView = PageTitleView(frame: CGRect(x: 0, y: kNavigationH+kStatusBarH, width: kScreenW, height: titleViewH), titles: titles)
  
        
        return titleView
        
    }()
    
// 内容
    private lazy var pageContentView : pageContentview = {[weak self] in
        
        let frame = CGRect(x: 0, y: kNavigationH + kStatusBarH + titleViewH, width: kScreenW, height: kScreenH - kStatusBarH - kNavigationH - titleViewH - kTabbarH )
        
        var viewControlls = [UIViewController]()
        
        for _ in 0..<4 {
            
            let ViewController = UIViewController()
            viewControlls.append(ViewController)
            ViewController.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            
        }
        
        
        
        let pagecontentView = pageContentview(frame: frame, viewControllers: viewControlls, parentViewController: self)
            pagecontentView.backgroundColor = UIColor .purple
        
        
        
        return pagecontentView
        }()
    
    
    
//    系统f的回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
    }

}

//设置UI界面
extension HomeController {
    
    private func setUI(){
        
        setupNavgationBar()
        // 添加titleview
        view.addSubview(pageTitleView)
//        添加contentView
        view.addSubview(pageContentView)
        
    }
    private func setupNavgationBar(){
        
        let btn = UIButton()
        btn.setImage(UIImage(named: "chat_getyw"), for: .normal)
        btn.sizeToFit()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        navigationItem.title = "首页"
        
    }
    
}

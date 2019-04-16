//
//  RootPageViewController.swift
//  annotation_app_6
//
//  Created by Braun, Annika on 1/22/19.
//  Copyright © 2019 Braun, Annika. All rights reserved.
//

import UIKit

class RootPageViewController: UIPageViewController, UIPageViewControllerDataSource, UISearchBarDelegate {
    
    lazy var viewControllerList:[UIViewController] = {
    
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let VC1 = storyBoard.instantiateViewController(withIdentifier: "VC1")
        let VC2 = storyBoard.instantiateViewController(withIdentifier: "VC2")
        let VC3 = storyBoard.instantiateViewController(withIdentifier: "VC3")
        
        return [VC1, VC2, VC3]
    }()
    
    let searchButton = UIButton(type: .custom)
    let trianglePath = UIBezierPath()
    let triangleLayer = CAShapeLayer()
    
    
    var mySearchBar: UISearchBar!
    var myLabel : UILabel!
    
    
    let backButton = UIButton()
    
    //let navigator: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 65))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //programmatically create UINavigationController
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navView = UINavigationController()
        let mainView = ViewController(nibName: nil, bundle: nil) //ViewController = Name of your controller
        navView.viewControllers = [mainView]
        window.rootViewController = navView
        window.makeKeyAndVisible()
        
        self.dataSource = self
        if let firstViewController = viewControllerList.first {
            self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        
        //create custom triangle for searchButton
        //make color show up !!!!
        /*
        trianglePath.move(to: CGPoint(x: UIScreen.main.bounds.width, y: UIScreen.main.bounds.height))
        trianglePath.addLine(to: CGPoint(x: UIScreen.main.bounds.width, y: UIScreen.main.bounds.height - 60))
        trianglePath.addLine(to: CGPoint(x: UIScreen.main.bounds.width - 60, y: UIScreen.main.bounds.height))
        */
        trianglePath.move(to: CGPoint(x: self.view.frame.size.width, y: self.view.frame.size.height))
        trianglePath.addLine(to: CGPoint(x: self.view.frame.size.width, y: self.view.frame.size.height - 60))
        trianglePath.addLine(to: CGPoint(x: self.view.frame.size.width - 60, y: self.view.frame.size.height))
        
        triangleLayer.path = trianglePath.cgPath 
        triangleLayer.fillColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
 
        searchButton.frame = CGRect(x: UIScreen.main.bounds.width - 60, y: UIScreen.main.bounds.height - 60, width: 60, height: 60)
        //searchButton.frame = CGRect(x:self.view.frame.size.width - 60, y:self.view.frame.size.width - 60, width: 60, height: 60)
        searchButton.layer.addSublayer(triangleLayer)
        //searchButton.layer.cornerRadius = 0.5 * searchButton.bounds.size.width
        searchButton.backgroundColor = #colorLiteral(red: 1, green: 0.838031277, blue: 0.9886808511, alpha: 1)
        //searchButton.setImage(UIImage(named:"thumbsUp.png"), for: .normal)
        searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
        view.addSubview(searchButton)
        
        let navBar = navView.navigationBar
        navBar.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        //navBar.title
        view.addSubview(navBar)
        
        /*
        let navItem = UINavigationItem(title: "SomeTitle");
        //let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: #selector("selectorName"));
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(backButtonTapped));
        //init(barButtonSystemItem: UIBarButtonSystemItem, target: Any?, action: Selector?)
        navItem.rightBarButtonItem = doneItem;
        navBar.setItems([navItem], animated: false);
         */
        
        //make UISearchBar instance
        mySearchBar = UISearchBar()
        mySearchBar.delegate = self
        //mySearchBar.frame = CGRect(x:0, y:UIScreen.main.bounds.height - 60, width:UIScreen.main.bounds.width, height:60)
        mySearchBar.frame = CGRect(x:0, y:0, width:UIScreen.main.bounds.width, height:80)
        mySearchBar.layer.position = CGPoint(x: self.view.bounds.width/2, y: UIScreen.main.bounds.height - 40)
        
        //set Default bar status.
        mySearchBar.searchBarStyle = UISearchBarStyle.default
        
        //set title
        //mySearchBar.prompt = "Find Text"
        
        // set placeholder
        mySearchBar.placeholder = "Input text"
        
        // change the color of cursor and cancel button.
        mySearchBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        // hide the search result.
        mySearchBar.showsSearchResultsButton = false
        
        backButton.frame = CGRect(x:10, y:10, width: 30, height: 30)
        backButton.backgroundColor = #colorLiteral(red: 1, green: 0.6532897008, blue: 0.978418284, alpha: 1)
        backButton.addTarget(self, action: #selector(backButtonClicked), for: UIControlEvents.touchUpInside)
        self.view.addSubview(backButton)
    }
    
    // called whenever text is changed.
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        mySearchBar.text = searchText
    }
    
    // called when cancel button is clicked
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        mySearchBar.text = ""
    }
    
    // called when search button is clicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        mySearchBar.text = "..."
        self.view.endEditing(true)
    }
    
    @objc func backButtonTapped(sender: UIBarButtonItem) {
        print("add the previous view here")
    }
    
    // add searchBar to the view.
    @objc func searchButtonClicked() {
        self.view.addSubview(mySearchBar)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
            
    //declare required page view functions
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = viewControllerList.index(of: viewController) else {return nil}
        let previousIndex = vcIndex - 1
        guard previousIndex >= 0 else {return nil}
        guard viewControllerList.count > previousIndex else {return nil}
        
        return viewControllerList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = viewControllerList.index(of: viewController) else {return nil}
        let nextIndex = vcIndex + 1
        guard viewControllerList.count != nextIndex else {return nil}
        guard viewControllerList.count > nextIndex else {return nil}
        
        return viewControllerList[nextIndex]
    }
    
    //add back button functionality
    @objc func backButtonClicked() {
        dismiss(animated: true, completion: nil)
    }
    
}

//creating back button in navigation bar
extension UIBarButtonItem {
    //override convenience init()
    //convenience init(barButtonSystemItem: UIBarButtonSystemItem, target: Any?, action: #selector(backButtonTapped))
    //convenience init(barButtonSystemItem: UIBarButtonSystemItem, target: Any?, action: backButtonTapped)
    //searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
    //convenience init(title: String?, style: UIBarButtonItemStyle, target: Any?, action: Selector?)
}


//
//  TableOfContents.swift
//  annotation_app_6
//
//  Created by Braun, Annika on 3/14/19.
//  Copyright © 2019 Braun, Annika. All rights reserved.
//

import UIKit

class TableOfContents: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    let testBook = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2 - 60, height: 200)
        
        let myCollectionView:UICollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        myCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        myCollectionView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.view.addSubview(myCollectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath)
        myCell.backgroundColor = #colorLiteral(red: 0.6007444089, green: 0.7034982115, blue: 1, alpha: 1)
        return myCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        //print("User tapped on item \(indexPath.row)")
        performSegue(withIdentifier: "segueOne", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//
//  HomeViewController.swift
//  AutoLayoutDemo
//
//  Created by najmeh nasiriyani on 2019-08-29.
//  Copyright © 2019 najmeh nasiriyani. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    var profiles: [Profile] = Array()
    @IBOutlet weak var profileTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = profileTableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell
        cell.setValues(profile: profiles[indexPath.row])
        
        return cell
    }
    func loadProfiles(){
        var myCell = Profile(myname: "Nora", myimage: UIImage(named: "nora")!)
        profiles.append(myCell)
        myCell = Profile(myname: "Parmis", myimage: UIImage(named: "parmis")!)
        profiles.append(myCell)
        myCell = Profile(myname: "Mohammad", myimage: UIImage(named: "mohammad")!)
        profiles.append(myCell)
        myCell = Profile(myname: "Dheeraj", myimage: UIImage(named: "dheeraj")!)
        profiles.append(myCell)
        myCell = Profile(myname: "Mary", myimage: UIImage(named: "mary")!)
        profiles.append(myCell)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileTableView.delegate = self
        profileTableView.dataSource = self
        loadProfiles()
        // Do any additional setup after loading the view.
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

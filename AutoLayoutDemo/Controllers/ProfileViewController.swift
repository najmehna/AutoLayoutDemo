//
//  HomeViewController.swift
//  AutoLayoutDemo
//
//  Created by najmeh nasiriyani on 2019-08-29.
//  Copyright © 2019 najmeh nasiriyani. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    var profiles: [Profile] = []{
        didSet{
            profileRules = profiles.count > courses.count
            min = profiles.count < courses.count ? profiles.count : courses.count
            print("From profile didset: \(min)")
        }
    }
    var courses: [Course] = []{
        didSet{
            profileRules = profiles.count > courses.count
            min = profiles.count < courses.count ? profiles.count : courses.count
            print("From courses didset: \(min)")
        }
    }
    var min = 0
    var profileRules = false
    
    @IBOutlet weak var profileTableView: UITableView!
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profiles.count + courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var myCell : UITableViewCell
        print(min)
        if indexPath.row / 2 < min{
            if indexPath.row % 2 == 0 {
                let cell = profileTableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell
                cell.setValues(profile: profiles[indexPath.row / 2])
                myCell = cell
            }else {
                let cell = profileTableView.dequeueReusableCell(withIdentifier: "courseCell") as! CoursesTableViewCell
                cell.setValues(course: courses[indexPath.row / 2])
                myCell = cell
                
            }} else if profileRules {
            let cell = profileTableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell
            cell.setValues(profile: profiles[indexPath.row / 2])
            myCell = cell
        } else{
            let cell = profileTableView.dequeueReusableCell(withIdentifier: "courseCell") as! CoursesTableViewCell
            cell.setValues(course: courses[indexPath.row / 2])
            myCell = cell
        }
        return myCell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let myManager = FirebaseAuthManager()
            if tableView.cellForRow(at: indexPath) is CustomTableViewCell{
                myManager.deleteProfile(dataDict: profiles[indexPath.row / 2].getDict()) { success in
                    if success{
                        print("Item deleted in firebase")
                        self.profiles.remove(at: indexPath.row / 2)
                    }else{
                        print("failed to delete item in firebase")
                    }
                }
            }else{
                myManager.deleteCourse(dataDict: profiles[indexPath.row / 2].getDict()) { success in
                    if success{
                        print("Item deleted in firebase")
                        self.courses.remove(at: indexPath.row / 2)
                    }else{
                        print("failed to delete item in firebase")
                    }
                }
            }
            profileTableView.reloadData()
        }
    }
    func loadProfiles(){
        let myManager = FirebaseAuthManager()
        var myCell = Profile(name: "",email: "",phone: "", gender: true)
        myManager.getUsersData(completionBlock: {success , myDict in
            print(myDict)
            for i in myDict.keys{
                if let values = myDict[i] as? Dictionary<String, Any>{
                let myName = values["name"] as! String
                let myEmail = values["email"] as! String
                let myPhone = values["phoneNumber"] as! String
                let myGender = values["gender"] as! Bool
                myCell = Profile(name: myName, email: myEmail, phone: myPhone, gender: myGender)
                self.profiles.append(myCell)
                }
            }
            self.profileTableView.reloadData()
        
        })
    }
    func loadCourses(){
        let myManager = FirebaseAuthManager()
        var myCell = Course(courseName: "", credits: "", finalMark: "")
        myManager.getCoursesData(completionBlock: {success , myDict in
            print(myDict)
            for i in myDict.keys{
                if let values = myDict[i] as? Dictionary<String, Any>{
                    let courseName = values["courseName"] as! String
                    let courseCredits = values["courseCredit"] as! String
                    let finalMark = values["finalMark"] as! String
                    myCell = Course(courseName: courseName, credits: courseCredits, finalMark: finalMark)
                    self.courses.append(myCell)
                }
            }
            self.profileTableView.reloadData()
            
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        profileTableView.delegate = self
        profileTableView.dataSource = self
        loadProfiles()
        loadCourses()
        
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

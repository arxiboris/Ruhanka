//
//  AvailableCoursesVC.swift
//  Ruhanka
//
//  Created by Oleksandr Borysenko on 07.07.2023.
//

import UIKit
import FirebaseAuth

class AvailableCoursesVC: UIViewController {
    
    var selectedButtonBar: UIView? = nil
    var filteredCourses: [Course] = []
    
    var availableCourses: [Course] {                        //computed variable
        return  [AvailableCourses.marafonNog,
                 AvailableCourses.RuhankaBitsepsa.main,
                 AvailableCourses.MarafonNog2.main,
                 AvailableCourses.MarafonPlechey.main,
                 AvailableCourses.RuhankaKopchic.main]
    }
    

    
    @IBOutlet weak var menuAllButtonOutlet: UIButton!
    @IBOutlet weak var menuMarafonButtonOutlet: UIButton!
    @IBOutlet weak var menuRuhankaButtonOutlet: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var buttonConstaintTop: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectButton(for: menuAllButtonOutlet,deselectButtons: [menuMarafonButtonOutlet,menuRuhankaButtonOutlet], selectedButtonBar: &selectedButtonBar)
        // Do any additional setup after loading the view.
        filteredCourses = availableCourses
        navigationItem.setHidesBackButton(true, animated: true) // hides back button
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.reusableCell)
    }
    

    
    //MARK: -  Top menu Buttons
    

    @IBAction func allButton(_ sender: UIButton) {
        filteredCourses = availableCourses
        tableView.reloadData()
        selectButton(for: menuAllButtonOutlet, deselectButtons: [menuMarafonButtonOutlet,menuRuhankaButtonOutlet], selectedButtonBar: &selectedButtonBar)
    }
    
    @IBAction func marafonButton(_ sender: UIButton) {
        filterCourses(courseStructure: .marafon)
        selectButton(for: menuMarafonButtonOutlet,deselectButtons: [menuAllButtonOutlet,menuRuhankaButtonOutlet], selectedButtonBar: &selectedButtonBar)
    }
    
    @IBAction func ruhankaButton(_ sender: UIButton) {
        filterCourses(courseStructure: .ruhanka)
        selectButton(for: menuRuhankaButtonOutlet,deselectButtons: [menuAllButtonOutlet,menuMarafonButtonOutlet], selectedButtonBar: &selectedButtonBar)
    }
    

    
    func filterCourses(courseStructure type: Course.CourseStructure) {
        filteredCourses = availableCourses.filter { $0.courseStructure == type }
        tableView.reloadData()
    }
    

    
    @IBAction func logOutBtn(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)// go to firsrt VC in stack
        } catch let signOutError as NSError {
            createAlert(from: self, errorText: signOutError.localizedDescription)
        }
        
    }
    
}

//MARK: -  extensions

extension AvailableCoursesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCourses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell  {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.reusableCell, for: indexPath) as! CourseCellVC //create reusable cell with all properties of custom cell
      
            cell.courseTitle.text = filteredCourses[indexPath.row].courseTitle
            cell.courseMainImage.image = filteredCourses[indexPath.row].courseImage
            cell.courseAuthor.text = filteredCourses[indexPath.row].courseAuthor
            cell.courseLevel.text = ""
            for (index,element) in filteredCourses[indexPath.row].courseLevel.enumerated() {
                cell.courseLevel.text! += "\(element.level) "
                if index+1 < filteredCourses[indexPath.row].courseLevel.count {
                    cell.courseLevel.text! += "/ "
                } else {
                    cell.courseLevel.text! += "  "
                }
            }
            
            cell.courseType.text = ""
            for (index, element) in filteredCourses[indexPath.row].courseType.enumerated() {
                cell.courseType.text! += "\(element.type)  "
                if index+1 < filteredCourses[indexPath.row].courseType.count {
                    cell.courseType.text! += "·  "
                }
            }
            cell.courseLength.text = "·   \(filteredCourses[indexPath.row].courseLength)"
            cell.courseMainImage.makeRoundCorners(byRadius: 20)
           
        return cell
    }
    
    
}

extension AvailableCoursesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { //tells the delegate that the current row is selected
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "PartOfCourseIdentifier") as? PartOfCourseVC {
            if let indexPath = tableView.indexPathForSelectedRow {
                let courseTitle = filteredCourses[indexPath.row].courseTitle
                vc.courseTitle = courseTitle
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}


extension UIImageView {
    func makeRoundCorners(byRadius rad: CGFloat) {
        self.layer.cornerRadius = rad
        self.clipsToBounds = true
    }
}

extension UIViewController {
    func selectButton(for button: UIButton, deselectButtons: [UIButton], selectedButtonBar:inout UIView?) {
        
        for deselectButton in deselectButtons {
            deselectButton.isSelected = false
        }
        
        button.isSelected = true
        selectedButtonBar?.removeFromSuperview()
        selectedButtonBar = UIView.init(frame: CGRect(x: 0.0, y: button.frame.size.height , width: button.frame.size.width, height: 3.0))
        selectedButtonBar?.backgroundColor = UIColor(named: K.Colors.Pink)
        button.addSubview(selectedButtonBar!)
        

    }
    
    
}

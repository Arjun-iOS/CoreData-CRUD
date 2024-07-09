//
//  DetailViewContoller.swift
//  DemoCoreData
//
//  Created by Arjun on 10/02/21.
//  Copyright © 2021 Arjun. All rights reserved.
//

import UIKit
import CoreData

class DetailViewContoller: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtDepartment: UITextField!
    @IBOutlet weak var txtDepartmentType: UITextField!

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var viewAdd: UIView!

    var managedContext = NSManagedObjectContext()
    
    var arrAllData = [Category]()
    var objCategory : Category?
    var selectedObject = Category()
    var objEmployee = Employee()
    var isFromAdd : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewAdd.isHidden = true
        self.tblView.delegate = self
        self.tblView.dataSource = self
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        managedContext = appDelegate.persistentContainer.viewContext
        
        self.arrAllData.removeAll()
        self.fetchStudentData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func saveData(){
        self.txtName.text = self.txtName.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        self.txtDepartment.text = self.txtDepartment.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        self.txtDepartmentType.text = self.txtDepartmentType.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // MARK: create an object of an entity
        let objEmp = Employee(context: self.managedContext)

        // MARK: set values
        var objC : Category?
        
        for obj in self.arrAllData{
            if obj.categoryType == self.txtDepartmentType.text{
                objC = obj
            }
        }
        
        if objC != nil{
            objEmp.name = self.txtName.text
            objEmp.department = self.txtDepartment.text
            objC?.addToEmployees(objEmp)
        }else{
            let objCat = Category(context: self.managedContext)
            objEmp.name = self.txtName.text
            objEmp.department = self.txtDepartment.text
            objCat.categoryType = self.txtDepartmentType.text
            objCat.addToEmployees(objEmp)
        }

        // MARK: for save Data
        do {
            print("name is :\(objEmp.name ?? "")")
            print("department is :\(objEmp.department ?? "")")
            print("department Type is :\(objCategory?.categoryType ?? "")")

            try managedContext.save()
            self.fetchStudentData()
        } catch {
            print("Data failed to save")
      }
    }
    
    func updateData(){
        
        var objC : Category?
        
        for obj in self.arrAllData{
            if obj.categoryType == self.txtDepartmentType.text{
                objC = obj
            }
        }
        
        if objC == nil{
            let objNew = Category(context: self.managedContext)
            self.objEmployee.name = self.txtName.text
            self.objEmployee.department = self.txtDepartment.text
            objNew.categoryType = self.txtDepartmentType.text
            objNew.addToEmployees(objEmployee)
        }else{
            self.objEmployee.name = self.txtName.text
            self.objEmployee.department = self.txtDepartment.text
            objC?.categoryType = self.txtDepartmentType.text
            objC?.addToEmployees(self.objEmployee)
        }
        
        do{
            try managedContext.save()
            self.fetchStudentData()
        }catch{
            print("failed to update Data")
        }
    }
    
    func fetchStudentData(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
        request.returnsObjectsAsFaults = false
        do {
            if let result = try managedContext.fetch(request) as? [Category]{
            self.arrAllData.removeAll()
            for data in result as? [Category] ?? [] {
                self.arrAllData.append(data)
              }
            }
        } catch {
            print("Failed to fetchData")
        }
         self.tblView.reloadData()
    }
    
    @IBAction func btnAdd(_ sender: Any) {
        self.isFromAdd = true
        self.txtName.text = ""
        self.txtDepartment.text = ""
        self.txtDepartmentType.text = ""
        self.viewAdd.isHidden = false
    }
    
    @IBAction func btnSave(_ sender: Any) {
        self.viewAdd.isHidden = true

        if self.isFromAdd == true{
            isFromAdd = false
            self.saveData()
        }else{
            self.updateData()
        }
    }
    
    @IBAction func btnCancelPop(_ sender: Any) {
        self.viewAdd.isHidden = true
    }
}

extension DetailViewContoller: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.arrAllData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let arrDevelopers = self.arrAllData[section].mutableSetValue(forKey: #keyPath(Category.employees))
        
        print(arrDevelopers.count)
        return arrDevelopers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell{
            
            self.objCategory = self.arrAllData[indexPath.section]
            
            let setDevelopers = self.objCategory?.mutableSetValue(forKey: #keyPath(Category.employees))
            
            let arrDevelopers = Array(setDevelopers!) as? [Employee] ?? []
            
            let objDev = arrDevelopers[indexPath.row]
            cell.lblName.text = objDev.name
            cell.lbDepartment.text = objDev.department
            
            return cell
        }else{
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return arrAllData[section].categoryType
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let objAllData = self.arrAllData[indexPath.section]
        
        let entityCat = "Category"
        
        let editAction = UITableViewRowAction(style: .default, title: "Edit") { (rowAction, indexPath) in
            self.tblView.isEditing = false
            self.viewAdd.isHidden = false
            
            self.objCategory = objAllData
            let setDevelopers = self.objCategory?.mutableSetValue(forKey: #keyPath(Category.employees))
            
            let arrDevelopers = Array(setDevelopers!) as? [Employee] ?? []
            let objShowData = arrDevelopers[indexPath.row]
            self.objEmployee = objShowData
            
            self.txtName.text = objShowData.name
            self.txtDepartment.text = objShowData.department
            self.txtDepartmentType.text = objShowData.category?.categoryType
            
        }
            editAction.backgroundColor = .lightGray
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (rowAction, indexPath) in
            self.objCategory = objAllData
            let setDevelopers = self.objCategory?.mutableSetValue(forKey: #keyPath(Category.employees))
            
            let arrDevelopers = Array(setDevelopers!) as? [Employee] ?? []
            let objShowData = arrDevelopers[indexPath.row]
            
            self.managedContext.delete(objShowData)
            do {
                try self.managedContext.save()
            } catch let error as NSError {
                print("Error While Deleting Note: \(error.userInfo)")
            }
            let fetchReqCat = NSFetchRequest<NSFetchRequestResult>(entityName: entityCat)
            do {
                self.arrAllData = try self.managedContext.fetch(fetchReqCat) as! [Category]

            } catch let error as NSError {
                print("Error While Fetching Data From DB: \(error.userInfo)")
            }
            self.tblView.reloadData()
        }
        deleteAction.backgroundColor = .red
        
        return [editAction,deleteAction]
    }
}

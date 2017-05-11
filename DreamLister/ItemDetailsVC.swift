//
//  ItemDetailsVC.swift
//  DreamLister
//
//  Created by Ruslan Negrei on 5/11/17.
//  Copyright © 2017 Ruslan Negrei. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var titleField: CustomTextField!
    @IBOutlet weak var priceField: CustomTextField!
    @IBOutlet weak var detailsField: CustomTextField!
    var stores = [Store]()
    var itemToEdit: Item?
    var imagePicker: UIImagePickerController!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        storePicker.dataSource=self
        storePicker.delegate=self
        if let topItem = self.navigationController?.navigationBar.topItem{
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
//        let store = Store(context: context)
//        store.name = "best buy"
//        let store2 = Store(context: context)
//        store2.name = "Amazon"
//        let store3 = Store(context: context)
//        store3.name = "Mata"
//        let store4 = Store(context: context)
//        store4.name = "Ebay"
//        let store5 = Store(context: context)
//        store5.name = "Other"
//        ad.saveContext()
        getStores()
        
        if itemToEdit != nil {
            loadItemData()
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let store = stores[row]
        return store.name
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //update later
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func getStores(){
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        
        do{
            self.stores = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
        }catch {
        
        }
    }
    @IBAction func savePressed(_ sender: Any) {
        
        var item:Item!
        let picture = Image(context:context)
        picture.image = thumbImage.image
        if itemToEdit == nil {
            item = Item(context:context)
        }

        else{
            item=itemToEdit
        }
        item.toImage = picture

        if let title = titleField.text {
            item.title = title
        }
        if let price = priceField.text {
            item.price = (price as NSString).doubleValue
        }
        if let details = detailsField.text {
            item.details = details
        }
        item.toStore = stores[storePicker.selectedRow(inComponent: 0)]
        ad.saveContext()
        _ = navigationController?.popViewController(animated: true)
    }
    
    func loadItemData() {
        if let item = itemToEdit {
            titleField.text = item.title
            priceField.text = "\(item.price)"
            detailsField.text = item.details
            thumbImage.image = item.toImage?.image as? UIImage 
            
            if let store = item.toStore{
                var index = 0
                repeat {
                    let s = stores[index]
                    if s.name == store.name {
                        storePicker.selectRow(index, inComponent: 0, animated: false)
                        break
                    }
                    index += 1
                    
                }while (index<stores.count)
            }
        }
    }
    @IBAction func deletePressed(_ sender: Any) {
        if itemToEdit != nil {
            context.delete(itemToEdit!)
            ad.saveContext()
        }
        navigationController?.popViewController(animated: true)
    }
    @IBAction func addImage(_ sender: Any) {
        present(imagePicker, animated: false, completion: nil )
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo: [String:Any]){
        if let img = didFinishPickingMediaWithInfo[UIImagePickerControllerOriginalImage] as? UIImage{
            thumbImage.image = img
        }
        imagePicker.dismiss(animated: true, completion: nil)

    }
    
    
    
    
    
    
    
    
    
    
    

}

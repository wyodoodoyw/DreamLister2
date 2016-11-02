//
//  ItemDetailsVC.swift
//  DreamLister
//
//  Created by Matthew Wood on 2016-11-01.
//  Copyright © 2016 Matthew. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var typePicker: UIPickerView!
    @IBOutlet weak var titleField: CustomTextField!
    @IBOutlet weak var priceField: CustomTextField!
    @IBOutlet weak var detailsField: CustomTextField!
    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var selectStoreButton: UIButton!
    @IBOutlet weak var selectTypeButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    var stores = [Store]()
    var types = [ItemType]()
    
    // optional because we're not always editing in this view
    var itemToEdit: Item?
    var imagePicker: UIImagePickerController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // replaces default navigation bar style
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        storePicker.delegate = self
        storePicker.dataSource = self
        
        typePicker.delegate = self
        typePicker.dataSource = self
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        ////////////////////////////////////////////////
        // Stores
        ////////////////////////////////////////////////
        
        let store1 = Store(context: context)
        store1.name = "Best Buy"
        
        let store2 = Store(context: context)
        store2.name = "Tesla Dealership"
        
        let store3 = Store(context: context)
        store3.name = "Walmart"
        
        let store4 = Store(context: context)
        store4.name = "Amazon.ca"
        
        let store5 = Store(context: context)
        store5.name = "EB Games"
        
        let store6 = Store(context: context)
        store6.name = "Apple Store"
        
        ////////////////////////////////////////////////
        // Types
        ////////////////////////////////////////////////
        
        let type1 = ItemType(context: context)
        type1.type = "Books"
        
        let type2 = ItemType(context: context)
        type2.type = "Music"
        
        let type3 = ItemType(context: context)
        type3.type = "Movies & TV"
        
        let type4 = ItemType(context: context)
        type4.type = "Electronics"
        
        let type5 = ItemType(context: context)
        type5.type = "Software"
        
        let type6 = ItemType(context: context)
        type6.type = "Video Games"
        
        let type7 = ItemType(context: context)
        type7.type = "Home"
        
        let type8 = ItemType(context: context)
        type8.type = "Pets"
        
        let type9 = ItemType(context: context)
        type9.type = "Yard & Garden"
        
        let type10 = ItemType(context: context)
        type10.type = "Health & Beauty"
        
        let type11 = ItemType(context: context)
        type11.type = "Toys"
        
        let type12 = ItemType(context: context)
        type12.type = "Baby"
        
        let type13 = ItemType(context: context)
        type13.type = "Clothing"
        
        let type14 = ItemType(context: context)
        type14.type = "Jewels"
        
        let type15 = ItemType(context: context)
        type15.type = "Sports"
        
        let type16 = ItemType(context: context)
        type16.type = "Outdoors"
        
        let type17 = ItemType(context: context)
        type17.type = "Automotive"
        
        //ad.saveContext()
        getStores()
        getItemTypes()
        
        if itemToEdit != nil {
            loadItemData()
        }
        
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == storePicker {
            let store = stores[row]
            return store.name
        } else {
            let itemType = types[row]
            return itemType.type
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == storePicker {
            return stores.count
        } else {
            return types.count
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        // number of columns
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == storePicker {
            selectStoreButton.titleLabel?.text = stores[row].name
            storePicker.isHidden = true
            typePicker.isHidden = true
            saveButton.isHidden = false
        } else {
            selectTypeButton.titleLabel?.text = types[row].type
            typePicker.isHidden = true
            storePicker.isHidden = true
            saveButton.isHidden = false
        }
    }
    
    func getStores() {
        // create fetch request
        
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        
        do {
            self.stores = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
        }
        catch {
            let error = error as NSError
            print("\(error)")
        }
        
    }
    
    func getItemTypes() {
        let fetchRequest: NSFetchRequest<ItemType> = ItemType.fetchRequest()
        
        do {
            self.types = try context.fetch(fetchRequest)
            self.typePicker.reloadAllComponents()
        } catch {
            let error = error as NSError
            print("\(error)")
        }
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        
        var item: Item!
        
        let picture = Image(context: context)
        picture.image = thumbImage.image
        
        if itemToEdit == nil {
            item = Item(context: context)
        } else {
            item = itemToEdit
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
        item.toItemType = types[typePicker.selectedRow(inComponent: 0)]
        ad.saveContext()
        _ = navigationController?.popViewController(animated: true)
    }
    
    func loadItemData() {
        if let item = itemToEdit {
            titleField.text = item.title
            priceField.text = "\(item.price)"
            detailsField.text = item.details
            selectStoreButton.setTitle(item.toStore?.name, for: .normal)
            selectTypeButton.setTitle(item.toItemType?.type, for: .normal)
            
            thumbImage.image = item.toImage?.image as? UIImage
            
//            if let store = item.toStore {
//                var index = 0
//                
//                repeat {
//                    let s = stores[index]
//                    if s.name == store.name {
//                        storePicker.selectRow(index, inComponent: 0, animated: false)
//                        break
//                    }
//                    index += 1
//                } while (index < stores.count)
//            }
        }
    }
    
    @IBAction func deletePressed(_ sender: Any) {
        
        if itemToEdit != nil {
            context.delete(itemToEdit!)
            ad.saveContext()
        }
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addImage(_ sender: UIButton) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            thumbImage.image = image
        }
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func selectStoreButtonPressed(_ sender: UIButton) {
        saveButton.isHidden = true
        storePicker.isHidden = false
    }
    
    @IBAction func selectTypeButtonPressed(_ sender: UIButton) {
        saveButton.isHidden = true
        typePicker.isHidden = false
    }
    
    
}

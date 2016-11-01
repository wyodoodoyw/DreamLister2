//
//  ItemDetailsVC.swift
//  DreamLister
//
//  Created by Matthew Wood on 2016-11-01.
//  Copyright © 2016 Matthew. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var titleField: CustomTextField!
    @IBOutlet weak var priceField: CustomTextField!
    @IBOutlet weak var detailsField: CustomTextField!
    
    var stores = [Store]()
    
    // optional because we're not always editing in this view
    var itemToEdit: Item?

    override func viewDidLoad() {
        super.viewDidLoad()

        // replaces default navigation bar style
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        storePicker.delegate = self
        storePicker.dataSource = self
        
//        let store1 = Store(context: context)
//        store1.name = "Best Buy"
//        
//        let store2 = Store(context: context)
//        store2.name = "Tesla Dealership"
//        
//        let store3 = Store(context: context)
//        store3.name = "Walmart"
//        
//        let store4 = Store(context: context)
//        store4.name = "Amazon.ca"
//        
//        let store5 = Store(context: context)
//        store5.name = "EB Games"
//        
//        let store6 = Store(context: context)
//        store6.name = "Apple Store"
//
//        stores.append(store1)
//        stores.append(store2)
//        stores.append(store3)
//        stores.append(store4)
//        stores.append(store5)
//        stores.append(store6)
        
        //ad.saveContext()
        getStores()
        
        if itemToEdit != nil {
            loadItemData()
        }
        
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let store = stores[row]
        return store.name
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return stores.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        // number of columns
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // update when selected
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
    
    @IBAction func savePressed(_ sender: UIButton) {
        
        var item: Item!
        
        if itemToEdit == nil {
            item = Item(context: context)
        } else {
            item = itemToEdit
        }
        
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
            
            if let store = item.toStore {
                var index = 0
                
                repeat {
                    let s = stores[index]
                    if s.name == store.name {
                        storePicker.selectRow(index, inComponent: 0, animated: false)
                        break
                    }
                    index += 1
                } while (index < stores.count)
            }
        }
    }
}

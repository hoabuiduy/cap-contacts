import Foundation
import Capacitor
import ContactsUI

extension UIApplication {
    class func topViewController(viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = viewController as? UINavigationController {
            return topViewController(viewController: nav.visibleViewController)
        }
        if let tab = viewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(viewController: selected)
            }
        }
        if let presented = viewController?.presentedViewController {
            return topViewController(viewController: presented)
        }
        return viewController
    }
}


@objc(CapContactsPlugin)
public class CapContactsPlugin: CAPPlugin, CNContactPickerDelegate  {
    private let implementation = CapContacts()

    var vc: CNContactPickerViewController?
    var id: String?
    
    @objc func echo(_ call: CAPPluginCall) {
        let value = call.getString("value") ?? ""
        call.resolve([
            "value": implementation.echo(value)
        ])
    }
    
    @objc func getContacts(_ call: CAPPluginCall){
        let _name = call.getString("name") ?? "";
        let _contacts = implementation.getContacts(name: _name)
        call.resolve([
            "contacts": _contacts
        ])
    }
    
    @objc func pickContact(_ call: CAPPluginCall){
        id = call.callbackId
        call.keepAlive = true;
               DispatchQueue.main.async {
                   self.vc = CNContactPickerViewController()
                   self.vc!.delegate = self
                UIApplication.topViewController()?.present(self.vc!, animated: true, completion: {
                    call.resolve()
                })
               }
    }
    
    @objc override public func requestPermissions(_ call: CAPPluginCall) {
        self.checkPermissions(call)
    }
    

    
    @objc override public func checkPermissions(_ call: CAPPluginCall) {
        switch implementation.contactPermission() {
        case .denied:
            call.resolve([
                "granted": false
            ]);
            break;
        default:
            call.resolve([
                "granted": true
            ]);
        }
     }
    
    func makeContact(_ contact: CNContact) -> JSObject {
           var res = JSObject()
        res["name"] = contact.givenName;
        res["phone"] = contact.phoneNumbers[0].value.stringValue;
            return res
    }

    public func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        picker.dismiss(animated: true, completion: nil)
        let call = self.bridge!.savedCall(withID: self.id!)
           if (call != nil) {
               var object = JSObject()
            object["value"] = makeContact(contact);
               call?.resolve(object);
           }
    }

    public func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        picker.dismiss(animated: true, completion: nil)
    }

}

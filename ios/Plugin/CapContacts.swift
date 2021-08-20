import Foundation
import ContactsUI

 
@objc public class CapContacts: NSObject {
    @objc public func echo(_ value: String) -> String {
        return value
    }
    
    public func contactPermission() -> CNAuthorizationStatus {
         return CNContactStore.authorizationStatus(for: .contacts);
          
    }

    public func getContacts(name: String = "") -> [Any] { //  ContactsFilter is Enum find it below

        let contactStore = CNContactStore()
        let keysToFetch = [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactPhoneNumbersKey,
            CNContactEmailAddressesKey,
            CNContactThumbnailImageDataKey] as [Any]

        var allContainers: [CNContainer] = []
        do {
            allContainers = try contactStore.containers(matching: nil)
        } catch {
            print("Error fetching containers")
        }

    var results: [Any] = [];

        for container in allContainers {
            let fetchPredicate = CNContact.predicateForContactsInContainer(withIdentifier: container.identifier)

            do {
                let containerResults = try contactStore.unifiedContacts(matching: fetchPredicate, keysToFetch: keysToFetch as! [CNKeyDescriptor])
                for contact in containerResults{
                    var o = [
                        "name": "",
                        "phone":""];
                    if(contact.givenName.contains(name)){
                        o["name"] = contact.givenName;
                        o["phone"]  = contact.phoneNumbers.count > 0 ? contact.phoneNumbers[0].value.stringValue : "";
                        results.append(o);
                    }
         
                }
            } catch {
                print("Error fetching containers")
            }
        }
    return results;
    }
    
}

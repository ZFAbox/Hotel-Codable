
import UIKit

class AddRegistrationTableViewController: UITableViewController {
    
    private var checkInDatePickerVisibale: Bool = false {
        didSet {
            checkInDatePicker.isHidden = !checkInDatePickerVisibale
        }
    }
    private var checkOutDatePickerVisible: Bool = false {
        didSet {
            checkOutDatePicker.isHidden = !checkOutDatePickerVisible
        }
    }
    
    private var roomType: RoomType?
    
    var registration: Registration? {
        guard let roomType = self.roomType else { return nil }
        
        let firstName = firstNameTextField.text ?? ""
        let lastName = seconfNameTextField.text ?? ""
        let emailAdress = emailTextField.text ?? ""
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
        let numberOfAdults = Int(adultsLabelCount.text ?? "0") ?? 0
        let numbersOfChildren = Int(childrenLabelCount.text ?? "0") ?? 0
        let wifi = wifiSwitch.isOn
        
        return Registration(
            firstName: firstName,
            lastName: lastName,
            emailAdress: emailAdress,
            checkInDate: checkInDate,
            checkOutDate: checkOutDate,
            numberOfAdults: numberOfAdults,
            numberOfChildren: numbersOfChildren,
            wifi: wifi,
            roomType: roomType
        )
    }
    
    private let checkInDatePickerIndexPath = IndexPath(row: 1, section: 1)
    private let checkOutDatePickerIndexPath = IndexPath(row: 3, section: 1)
    private let checkInLabelIndexPath = IndexPath(row: 0, section: 1)
    private let checkOutLabelIndexPath = IndexPath(row: 2, section: 1)
    //Section 1
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var seconfNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    //Section 2
    @IBOutlet weak var checkInDateLabel: UILabel!
    @IBOutlet weak var checkInDatePicker: UIDatePicker!
    @IBOutlet weak var checkOutDateLabel: UILabel!
    @IBOutlet weak var checkOutDatePicker: UIDatePicker!
    
    //Section 3
    @IBOutlet weak var adultsLabelCount: UILabel!
    @IBOutlet weak var adultsStepper: UIStepper!
    @IBOutlet weak var childrenLabelCount: UILabel!
    @IBOutlet weak var childrenStepper: UIStepper!
    
    // Section 4
    @IBOutlet weak var wifiSwitch: UISwitch!
    
    // Section 5
    @IBOutlet weak var roomTypeLabel: UILabel!
    // Section 6
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let midnightTodayDate = Calendar.current.startOfDay(for: Date())
        checkInDatePicker.minimumDate = midnightTodayDate
        checkInDatePicker.date = midnightTodayDate
        
        checkOutDatePicker.minimumDate = Calendar.current.date(byAdding: .day, value: 1, to: midnightTodayDate)
        updateDateViews()
        updateNumberOfGuests()
        updateRoomTypeLabel()
        updateTotalPrice()
        updateDoneButtonState()
    }
    
    private func updateDateViews() {
        checkInDateLabel.text = checkInDatePicker.date.formatted(date: .abbreviated, time: .omitted)
        checkOutDateLabel.text = checkOutDatePicker.date.formatted(date: .abbreviated, time: .omitted)
    }
    
    private func updateRoomTypeLabel() {
        if let  roomType = roomType {
            roomTypeLabel.text = roomType.name
        } else {
            roomTypeLabel.text = "Not set"
        }
    }
    
    private func updateTotalPrice(){
        let roomPrice = roomType?.price ?? 0
        let wifiPrice = wifiSwitch.isOn ? 10 : 0
        let totalPrice = roomPrice + wifiPrice
        totalPriceLabel.text = "$\(totalPrice)"
    }
    
    private func doneButtonAvailable() -> Bool {
        let firstName = firstNameTextField.text ?? ""
        let lastNmae = seconfNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let roomTypeSelected = roomType != nil ? true : false
        let adultsSelected = Int(adultsStepper.value) >= 1 ? true : false
        
        return !firstName.isEmpty &&
        !lastNmae.isEmpty &&
        !email.isEmpty && roomTypeSelected && adultsSelected
    }
    
    private func updateDoneButtonState() {
        doneButton.isEnabled = doneButtonAvailable()
    }
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateDoneButtonState()
    }
    
    @IBAction func doneBarButton(_ sender: Any) {
        
        let firstName = firstNameTextField.text ?? ""
        let secondName = seconfNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let checkInDate = checkInDateLabel.text ?? ""
        let checkOutDate = checkOutDateLabel.text ?? ""
        let adultsNumber = adultsLabelCount.text ?? ""
        let childrenNumber = childrenLabelCount.text ?? ""
        let selectedRoomType = self.roomType?.name ?? ""
        
        print("Done button tapped!")
        print("First Name: \(firstName)")
        print("Second Name: \(secondName)")
        print("Email: \(email)")
        print("Check-In Date: \(checkInDate)")
        print("Check-OUt Date: \(checkOutDate)")
        print("Adults number: \(adultsNumber)")
        print("Children number: \(childrenNumber)")
        print("Wi-Fi switch is on: \(wifiSwitch.isOn)")
        print("Selected room type: \(selectedRoomType)")
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        updateDateViews()
    }
    
    @IBAction func stepperValueChanged(_ sender: Any) {
        updateNumberOfGuests()
        updateDoneButtonState()
    }
    
    @IBAction func wifiSwitchChanged(_ sender: Any) {
        updateTotalPrice()
    }
    
    
    @IBSegueAction func selectRoomType(_ coder: NSCoder) -> SelectRoomTypeTableViewController? {
        let selectRoomTypeTableViewController = SelectRoomTypeTableViewController(coder: coder)
        selectRoomTypeTableViewController?.delegate = self
        selectRoomTypeTableViewController?.roomType = roomType
        return selectRoomTypeTableViewController
    }
    
    
    private func updateNumberOfGuests() {
        adultsLabelCount.text = String(Int(adultsStepper.value))
        childrenLabelCount.text = String(Int(childrenStepper.value))
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath {
        case checkInLabelIndexPath where checkOutDatePickerVisible == false:
            checkInDatePickerVisibale.toggle()
        case checkOutLabelIndexPath where checkInDatePickerVisibale == false:
            checkOutDatePickerVisible.toggle()
        case checkInLabelIndexPath, checkOutLabelIndexPath:
            checkInDatePickerVisibale.toggle()
            checkOutDatePickerVisible.toggle()
        default:
            return
        }
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case checkInDatePickerIndexPath where checkInDatePickerVisibale == false :
            return 0
        case checkOutDatePickerIndexPath where checkOutDatePickerVisible == false :
            return 0
        default:
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case checkInDatePickerIndexPath:
            return 190
        case checkOutDatePickerIndexPath:
            return 190
        default:
            return UITableView.automaticDimension
        }
    }
    
}

extension AddRegistrationTableViewController: SelecyRoomTyperTableViewControllerDelegate {
    func selectRoomTypeTableViewController(_ controller: SelectRoomTypeTableViewController, didSelect roomType: RoomType) {
        self.roomType = roomType
        updateRoomTypeLabel()
        updateTotalPrice()
        updateDoneButtonState()
    }
    
    
}

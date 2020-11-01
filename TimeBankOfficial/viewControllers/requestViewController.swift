import UIKit

class requestViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var jobTitleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var locationTextView: UITextView!
    @IBOutlet weak var timeToOfferTextField: UITextField!
    @IBOutlet weak var jobDateAndTimeTextField: UITextField!
    
    private var datePicker: UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .dateAndTime
        datePicker?.addTarget(self, action: #selector(requestViewController.dateChanged(datePicker:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(requestViewController.viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
        
        jobDateAndTimeTextField.inputView = datePicker
        
        jobTitleTextField.delegate = self
        descriptionTextView.delegate = self
        locationTextView.delegate = self
        timeToOfferTextField.delegate = self
        jobDateAndTimeTextField.delegate = self
        
        //listen for keyboard event
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        
        view.endEditing(true)
        
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yyyy, hh:mma"
        
        jobDateAndTimeTextField.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    
    @IBAction func useCurrentLocationPressed(_ sender: Any) {
    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
    }
    
    deinit {
        // stop listening
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    func hideKeyboard() {
        jobTitleTextField.resignFirstResponder()
        descriptionTextView.resignFirstResponder()
        locationTextView.resignFirstResponder()
        timeToOfferTextField.resignFirstResponder()
        jobDateAndTimeTextField.resignFirstResponder()
    }
    
    @objc func keyboardWillChange(notification: Notification) {
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification {
            
            //view.frame.origin.y = -keyboardRect.height
            view.frame.origin.y = -80
            
        }
        else {
            view.frame.origin.y = 0
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        jobTitleTextField.resignFirstResponder()
        descriptionTextView.resignFirstResponder()
        locationTextView.resignFirstResponder()
        timeToOfferTextField.resignFirstResponder()
        jobDateAndTimeTextField.resignFirstResponder()
        hideKeyboard()
        return true
    }
    
}

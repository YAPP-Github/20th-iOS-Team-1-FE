//
//  DatePicker.swift
//  App
//
//  Created by 김나희 on 7/25/22.
//

import UIKit

final class TextFieldWithDatePicker: UITextField {
    enum PickerType {
        case dateWithCreateGather
        case timeWithCreateGather
        case dateWithAddPet
    }
    
    private lazy var dateText: String = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.string(from: Date())
        
        return date
    }()
    
    private lazy var timeText: String = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:s"
        let date = formatter.string(from: Date())
        
        return date
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.backgroundColor = UIColor.Togaether.background
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.addTarget(self, action: #selector(datePickerValueDidChange(_:)), for: .valueChanged)
        datePicker.maximumDate = Date()
        
        endEditing(true)

        return datePicker
    }()
    
    
    private lazy var timePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.backgroundColor = UIColor.Togaether.background
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .time
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.addTarget(self, action: #selector(timePickerValueDidChange(_:)), for: .valueChanged)
        endEditing(true)
        
        return datePicker
    }()
    

    init(frame: CGRect, type: PickerType) {
        super.init(frame: frame)
        configureUI(type)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func datePickerValueDidChange(_ datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        text = dateFormatter.string(from: datePicker.date)
    }
    
    @objc private func timePickerValueDidChange(_ datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:s"
        text = dateFormatter.string(from: datePicker.date)
    }
    
    func configurePeriod(datePicker: UIDatePicker) {
        let calendar = Calendar(identifier: .gregorian)
        let currentDate = Date()
        var components = DateComponents()
        components.calendar = calendar
        components.year = 100
        components.month = 12
        let maxDate = calendar.date(byAdding: components, to: currentDate)!
        components.year = -1
        let minDate = calendar.date(byAdding: components, to: currentDate)!
        datePicker.minimumDate = minDate
        datePicker.maximumDate = maxDate
    }
    
    private func configureUI(_ type: PickerType) {
        textAlignment = .center
        backgroundColor = .Togaether.background
        switch type {
        case .dateWithCreateGather:
            text = dateText
            let datePicker = datePicker
            configurePeriod(datePicker: datePicker)
            inputView = datePicker
        case .timeWithCreateGather:
            text = timeText
            inputView = timePicker
        case .dateWithAddPet:
            inputView = datePicker
        }
    }
    
}

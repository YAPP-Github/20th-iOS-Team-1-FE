//
//  DatePicker.swift
//  App
//
//  Created by 김나희 on 7/25/22.
//

import UIKit

final class TextFieldWithDatePicker: UITextField {
    enum PickerType {
        case date
        case time
    }
    
    private lazy var dateText: String = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM월 dd일"
        let date = formatter.string(from: Date())
        
        return date
    }()
    
    private lazy var timeText: String = {
        let formatter = DateFormatter()
        formatter.dateFormat = "a hh:mm"
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
        dateFormatter.dateFormat = "MM월 dd일"
        text = dateFormatter.string(from: datePicker.date)
    }
    
    @objc private func timePickerValueDidChange(_ datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a hh:mm"
        text = dateFormatter.string(from: datePicker.date)
    }
    
    private func configureUI(_ type: PickerType) {
        textAlignment = .center
        backgroundColor = .Togaether.background
        switch type {
        case .date:
            text = dateText
            inputView = datePicker
        case .time:
            text = timeText
            inputView = timePicker
        }
    }
    
}

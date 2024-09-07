//
//  StatementViewModel.swift
//  Cora
//
//  Created by Fabricio Pujol on 06/09/24.
//

import Foundation

protocol StatementViewModelProtocol: AnyObject {
    func success()
    func error(message: String)
}

class StatementViewModel {
    
    private var service: StatementService = StatementService()
    private weak var delegate: StatementViewModelProtocol?
    
    public var statementList: StatementListReponse?
    
    public var numberOfSections: Int {
        return statementList?.itemsTotal ?? 0
    }
    
    public var numberOfSectionsTemplate: Int {
        return 2
    }
    
    public var numberOfRowsTemplate: Int {
        return 5
    }
    
    public var isLoading: Bool = true
    
    public func delegate(delegate: StatementViewModelProtocol?) {
        self.delegate = delegate
    }
    
    public func fetchStatementList(token: String) {
        
        service.getStatementList(token: token) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                statementList = response
                delegate?.success()
            case .failure(let failure):
                delegate?.error(message: failure.errorDescription ?? "")
            }
        }
    }
    
    public func getNumberOfRowsinSection(section: Int) -> Int {
        return statementList?.results[section].items.count ?? 0
    }
    
    public func formatAmount(_ amount: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "R$ "
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.locale = Locale(identifier: "pt_BR")

        let decimalAmount = Double(amount) / 100.0
        if let formattedAmount = formatter.string(from: NSNumber(value: decimalAmount)) {
            return formattedAmount
        }
        return "R$ 0,00"
    }
    
    func formatTime(from dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "HH:mm"
            
            let timeString = dateFormatter.string(from: date)
            return timeString
        }
        
        return nil
    }
    
    func formatDate(from dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = inputFormatter.date(from: dateString) else {
            return "Data inválida"
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "d 'de' MMMM"
        outputFormatter.locale = Locale(identifier: "pt_BR")
        
        let dayOfWeekFormatter = DateFormatter()
        dayOfWeekFormatter.dateFormat = "EEEE"
        dayOfWeekFormatter.locale = Locale(identifier: "pt_BR")
        
        var dayOfWeek = dayOfWeekFormatter.string(from: date)
        var monthName = outputFormatter.string(from: date)
        
        dayOfWeek = dayOfWeek.capitalized
        monthName = monthName.capitalized
        
        let calendar = Calendar.current
        let isToday = calendar.isDateInToday(date)
        
        if isToday {
            return "Hoje - \(monthName)"
        } else {
            return "\(dayOfWeek) - \(monthName)"
        }
    }
}

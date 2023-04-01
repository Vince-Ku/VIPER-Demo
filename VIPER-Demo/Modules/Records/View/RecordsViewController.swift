//
//  RecordsViewController.swift
//  VIPER-Demo
//
//  Created by 辜敬閎 on 2023/4/1.
//

import UIKit

protocol RecordsViewControllerDelegate: AnyObject {
    func reloadRecords(records: [RecordCellViewObject])
}

class RecordsViewController: UIViewController {
    
    private let recordsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var recordsViewObject: [RecordCellViewObject] = []
    
    private let presenter: RecordsPresenter!
    
    init(presenter: RecordsPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupDelegate()
        
        presenter.viewDidLoad()
    }
    
    private func setupTableView() {
        view.addSubview(recordsTableView)
        
        NSLayoutConstraint.activate([
            recordsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            recordsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            recordsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            recordsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        recordsTableView.separatorStyle = .none
        recordsTableView.register(RecordTableViewCell.self, forCellReuseIdentifier: "RecordTableViewCell")
        recordsTableView.delegate = self
        recordsTableView.dataSource = self
    }
    
    private func setupDelegate() {
        presenter.viewDelegate = self
    }
}

extension RecordsViewController: UITableViewDelegate {}

extension RecordsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recordsViewObject.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordTableViewCell", for: indexPath) as! RecordTableViewCell
        let recordCellViewObject = recordsViewObject[indexPath.row]
        cell.setup(viewObject: recordCellViewObject)
        return cell
    }
    
}

extension RecordsViewController: RecordsViewControllerDelegate {
    func reloadRecords(records: [RecordCellViewObject]) {
        recordsViewObject = records
        recordsTableView.reloadData()
    }
}

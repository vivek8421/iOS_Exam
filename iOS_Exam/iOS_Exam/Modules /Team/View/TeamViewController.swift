//
//
//  HomeVC.swift
//  iOS_Exam
//


import UIKit


class TeamViewController: UIViewController {
// MARK: - Outlets
    @IBOutlet weak var playersTableView: UITableView!
    @IBOutlet weak var floatingBtn: UIButton!
    
    private let searchBar = UISearchBar()
    private var viewModel: TeamViewModelProtocol = TeamViewModel()
    
// MARK: - ViewLifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBlocks()
        setupTableView()
        setupSearchBar()
        setupFloatingButton()
        viewModel.fetchData()
    }
    
// MARK: - Configuration Methods
    private func setupBlocks() {
        viewModel.successBlock = { [weak self] in
            guard let self else { return }
            DispatchQueue.main.async {
                self.playersTableView.reloadData()
            }
        }
        
        viewModel.failureBlock = { [weak self] errorMessage in
            guard let self else { return }
            DispatchQueue.main.async {
                self.playersTableView.addNoDataView(message: errorMessage)
                self.searchBar.isHidden = true
                self.title = ""
            }
        }
    }
    
    private func setupTableView() {
        playersTableView.dataSource = self
        playersTableView.delegate = self
        let countryFlagCellNib = UINib(nibName: Constants.countryFlagCell,
                                          bundle: nil)
        playersTableView.register(countryFlagCellNib,
                                   forCellReuseIdentifier: Constants.countryFlagCell)
        let teamPlayerCellNib = UINib(nibName: Constants.teamPlayerCell,
                                      bundle: nil)
        playersTableView.register(teamPlayerCellNib,
                                   forCellReuseIdentifier: Constants.teamPlayerCell)
    }
    
    private func setupSearchBar() {
        searchBar.placeholder = "Search Player"
        searchBar.searchBarStyle = .prominent
        searchBar.delegate = self
        searchBar.showsCancelButton = false
        searchBar.sizeToFit()
    }
    
    private func setupFloatingButton() {
        floatingBtn.layer.shadowColor = UIColor.black.cgColor
        floatingBtn.layer.shadowOffset = CGSize(width: 0, height: 4)
        floatingBtn.layer.shadowOpacity = 0.5
        floatingBtn.layer.shadowRadius = 4.0
    }
    
    
    @IBAction func presentBottomSheet(_ sender: Any) {
        if let bottomSheetVC = self.storyboard?.instantiateViewController(withIdentifier: Constants.bottomSheetViewController) as? BottomSheetViewController {
            bottomSheetVC.viewModel.player = viewModel.selectedPlayers
            self.presentBottomSheet(height: 180, viewController: bottomSheetVC)
        }
    }
    
}

// MARK: - UITableViewDataSource Methods
extension TeamViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : viewModel.filterTeamPlayers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = playersTableView.dequeueReusableCell(withIdentifier: Constants.countryFlagCell, for: indexPath) as? CountryFlagCell else {
                return UITableViewCell()
            }
            cell.teams = viewModel.teams
            cell.didChangeTeam = { [weak self] index in
                guard let self else { return }
                let searchText = self.searchBar.text ?? ""
                self.viewModel.didChangeTeam(index: index, searchText: searchText)
                self.title = self.viewModel.teams[index].country
            }
            return cell
        } else {
            guard let cell = playersTableView.dequeueReusableCell(withIdentifier: Constants.teamPlayerCell, for: indexPath) as? TeamPlayerCell else {
                return UITableViewCell()
            }
            cell.player = self.viewModel.filterTeamPlayers[indexPath.row]
            return cell
        }
    }
}


// MARK: - UITableViewDelegate Methods
extension TeamViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (indexPath.section == 0) ? CGFloat(tableView.frame.width * 0.65) : UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        section == 1 ? searchBar : nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        section == 1 ? 50 : 0
    }
}


// MARK: - UISearchBarDelegate Methods
extension TeamViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.didSearchPlayer(text: searchText)
        searchBar.showsCancelButton = !searchText.isEmpty
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.filterTeamPlayers = viewModel.selectedPlayers
        searchBar.text = ""
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

//
//  NewsListViewController.swift
//  dishvetsovPW4
//
//  Created by Danil Shvetsov on 03.12.2022.
//

import UIKit

// Final class of News list controller which shows all the latest news.
final class NewsListViewController: UIViewController {
    
    // Main component of controller.
    private var tableView = UITableView(frame: .zero, style: .plain)
    
    // The state for the load of data to UI components.
    private var isLoading = false
    
    // Models list.
    private var newsViewModels = [NewsViewModel]()
    
    // Refresher for the application news.
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupRefreshControl()
        fetchNews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /// This function sets the UI.
    private func setupUI() {
        view.backgroundColor = CustomColors.set(to: .majorBackgroundDarkGray)
        
        setupNavBar()
        
        configureTableView()
    }
    
    /// This function sets the navigation bar.
    private func setupNavBar() {
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barStyle = .black

        setGoBackButton()
        setNavBarTitle()
    }
    
    /// This function sets the appearance for the go back button.
    private func setGoBackButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(goBack)
        )
        navigationItem.leftBarButtonItem?.tintColor = CustomColors.set(to: .minorBackgroundLightOrange)
        
        setGoBackActionWithRightSwipe()
    }
    
    /// This function sets up the action of right swipe for returning to the previous contorller.
    private func setGoBackActionWithRightSwipe() {
        let rightGesture = UISwipeGestureRecognizer(
            target: self,
            action: #selector(swipeActionBackToChats)
        )
        rightGesture.direction = .right
            
        self.view.addGestureRecognizer(rightGesture)
    }
    
    /// This function handles the process of right swipe for returning to the previous controller.
    /// - Parameter sender: Sender.
    @objc
    private func swipeActionBackToChats(_ sender: UISwipeGestureRecognizer) {
        self.navigationController?.fadeOut()
    }
    
    /// This function sets the navigation bar title.
    private func setNavBarTitle() {
        navigationItem.title = "News"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: CustomColors.set(to: .minorBackgroundLightOrange)]
    }
    
    /// This function describes the action of returning to the previous controller after pressing go back button.
    @objc
    private func goBack() {
        self.navigationController?.fadeOut()
    }
    
    /// This function sets the table view up.
    private func configureTableView() {
        setTableViewUI()
        setTableViewDelegate()
        setTableViewCell()
    }
    
    /// This function sets the UI for the table view.
    private func setTableViewUI() {
        tableView.backgroundColor = .clear
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.rowHeight = 120
        
        view.addSubview(tableView)
        tableView.pinLeft(to: self.view)
        tableView.pinTop(to: self.view.safeAreaLayoutGuide.topAnchor)
        tableView.pinRight(to: self.view)
        tableView.pinBottom(to: self.view)
    }
    
    /// This function set the delegate methods.
    private func setTableViewDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    /// This function registers the table view cells.
    private func setTableViewCell() {
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.reuseIdentifier)
    }
    
    /// This function fetches the news from API.
    private func fetchNews() {
        ApiService.shared.getTopStories { [weak self] result in
            switch result {
            case .success(let articles):
                
                self?.newsViewModels = articles.compactMap{
                    NewsViewModel(
                        title: $0.title ?? "No title",
                        description: $0.description ?? "No description",
                        imageURL: URL(string: $0.urlToImage ?? "mountains_default")
                    )
                }
                
                DispatchQueue.main.async {
                    self?.isLoading = false
                    self?.tableView.reloadData()
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    /// This function sets up the refreshing for the news.
    private func setupRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "update news")
        refreshControl.tintColor = CustomColors.set(to: .majorFontWhite)
        
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    /// This function reloads the data (refreshes) and ends the refreshing.
    /// - Parameter sender: Sender.
    @objc
    private func refresh(_ sender: AnyObject) {
        self.refreshControl.endRefreshing()
        fetchNews()
    }
}

// MARK: - The extension for the NewsListViewController (delegate methods).
extension NewsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isLoading {
            return 0
        } else {
            return newsViewModels.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isLoading {
            
        } else {
            let viewModel = newsViewModels[indexPath.row]
            
            if let newsCell = tableView.dequeueReusableCell(withIdentifier: NewsCell.reuseIdentifier, for: indexPath) as? NewsCell {
                newsCell.configure(with: viewModel)
                
                return newsCell
            }
        }
        return UITableViewCell()
    }
}

extension NewsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !isLoading {
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            
            let newsVC = NewsViewController()
            
            newsVC.configure(with: newsViewModels[indexPath.row])
            navigationController?.fadeTo(newsVC)
        }
    }
}

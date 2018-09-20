//
//  PageViewController.swift
//  UIKit_lessons
//
//  Created by Konstantin on 20.09.2018.
//  Copyright © 2018 Konstantin. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {

    let presentScreenContent = [
    "Первая глава. Как я установил икс код. Далее идет какой-то странный текст",
    "Вторая глава. Как я изучал икс код. Далее идет какой-то странный текст",
    "Третяя глава. Как я использовал икс код. Далее идет какой-то странный текст",
    "Последняя глава. Как я разукрасил икс код. Далее идет какой-то странный текст"
    ]
    
    let emojiArray = ["👿", "👤", "👲", "🧐"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        if let contentViewConroller = showViewControllerAtIndex(0) {
            setViewControllers([contentViewConroller], direction: .forward, animated: true, completion: nil)
        }
        
    }
    
    func showViewControllerAtIndex(_ index: Int) -> ContentViewController? {
        
        guard index >= 0 else { return nil }
        guard index < presentScreenContent.count else {
            //let userDefaults = UserDefaults.standard
            //userDefaults.set(true, forKey: "presentationWasViewed")
            //dismiss(animated: true, completion: nil)
            return nil
        }
        //тут создаем экземпляр через поиск по Storyboard ID
        guard let contetViewController = storyboard?.instantiateViewController(withIdentifier: "ContentViewController") as? ContentViewController else { return nil }
        
        contetViewController.presentText = presentScreenContent[index]
        contetViewController.emoji = emojiArray[index]
        contetViewController.currentPage = index
        contetViewController.numberOfPages = presentScreenContent.count
        
        return contetViewController
        
    }
    
    func closePresentation() -> Void {
        dismiss(animated: true, completion: nil)
    }
    
}

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var pageNumber = (viewController as! ContentViewController).currentPage
        pageNumber -= 1
        
        return showViewControllerAtIndex(pageNumber)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var pageNumber = (viewController as! ContentViewController).currentPage
        pageNumber += 1
        
        return showViewControllerAtIndex(pageNumber)
    }
    
}

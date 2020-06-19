//
//  BottomSheetViewController.swift
//  navi-lite
//
//  Created by Phineas.Huang on 2020/5/22.
//  Copyright © 2020 Garmin. All rights reserved.
//

import UIKit

extension BottomSheetViewController {
    private enum Director {
        case up
        case down
    }

    private enum State {
        case partial
        case expanded
        case full
    }

    private enum Constant {
        static let fullViewYPosition: CGFloat = 100
        static var partialViewYPosition: CGFloat { UIScreen.main.bounds.height - 130 }
        static var expandedViewYPosition: CGFloat { UIScreen.main.bounds.height - 130 - 130 }
    }
}

class BottomSheetViewController: UIViewController {
    private var lastStatus:State = .partial

    override func viewDidLoad() {
        super.viewDidLoad()

        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(panGesture))
        view.addGestureRecognizer(gesture)
        roundViews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.6, animations: {
            self.moveView(state: .expanded)
        })
    }

    private func moveView(state: State) {
        var yPosition = Constant.fullViewYPosition
        if (state == .partial) {
            yPosition = Constant.partialViewYPosition

        } else if (state == .expanded) {
            yPosition = Constant.expandedViewYPosition
        }

        view.frame = CGRect(x: 0, y: yPosition, width: view.frame.width, height: view.frame.height)
    }

    private func moveView(panGestureRecognizer recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: view)
        let minY = view.frame.minY

        if (minY + translation.y >= Constant.fullViewYPosition) && (minY + translation.y <= Constant.partialViewYPosition) {
            view.frame = CGRect(x: 0, y: minY + translation.y, width: view.frame.width, height: view.frame.height)
            recognizer.setTranslation(CGPoint.zero, in: view)
        }
    }

    @objc private func panGesture(_ recognizer: UIPanGestureRecognizer) {
        moveView(panGestureRecognizer: recognizer)

        if recognizer.state == .ended {
            UIView.animate(withDuration: 0.3, delay: 0.0, options: [.allowUserInteraction], animations: {

                // handle velocity
                let director: Director = recognizer.velocity(in: self.view).y >= 0 ? .down : .up
                var state:State = self.lastStatus
                if (self.lastStatus == .partial && director == .up) {
                    state = .expanded

                } else if (self.lastStatus == .expanded && director == .up) {
                    state = .full
                }

                if (self.lastStatus == .full && director == .down) {
                    state = .expanded

                } else if (self.lastStatus == .expanded && director == .down) {
                    state = .partial
                }

                // handle
                if (state == .expanded) {
                    if let endLocation = recognizer.view?.frame.origin.y {
                        if (endLocation > Constant.expandedViewYPosition &&
                            director == .down) {
                            state = .partial

                        } else if (endLocation < Constant.expandedViewYPosition &&
                            director == .up) {
                            state = .full
                        }
                    }

                } else if (state == .partial &&
                    self.lastStatus == .partial) {
                    if let endLocation = recognizer.view?.frame.origin.y {
                        if (endLocation < Constant.expandedViewYPosition) {
                            state = .expanded
                        }
                    }
                }

                self.lastStatus = state
                self.moveView(state: state)
            }, completion: nil)
        }
    }

    func roundViews() {
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
    }
}

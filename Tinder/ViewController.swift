//
//  ViewController.swift
//  Tinder
//
//  Created by shooooori0128 on 2019/06/23.
//  Copyright © 2019 shooooori0128. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var basicCard: UIView!
  @IBOutlet weak var likeImageView: UIImageView!
  
  var centerOfCard:CGPoint!
  
  // アプリが起動した時、この画面が読み込まれた時のイベント処理
  override func viewDidLoad() {
    super.viewDidLoad()
    // basicCardの中央の初期値をcardOfCenterに代入
    centerOfCard = basicCard.center
  }
  
  // storyboardに紐づけているのを表すのが、IBAction
  // ドラッグアンドドロップした時のイベント処理
  @IBAction func swipeCard(_ sender: UIPanGestureRecognizer) {
    // senderにはスワイプされたbasicCardが入っている
    let card = sender.view!
    // storyboardにあるviewを基準にどれだけ動いたかをpointに代入している
    let point = sender.translation(in: view)
    
    // cardの中央の座標に対して、スワイプで動作させたxy座標を代入している
    card.center = CGPoint(x: card.center.x + point.x, y: card.center.y + point.y)
    
    // デバイスの中央座標とじスワイプしたx座標の差を求める
    let xFromCenter = card.center.x - view.center.x
    // 角度を変化させる
    card.transform = CGAffineTransform(rotationAngle: xFromCenter / (view.frame.width / 2) * -0.785)
    
    // 画像が左右にスワイプされた時に動作に応じて、グッド、バッド画像を表示する
    if xFromCenter > 0 {
      likeImageView.image = #imageLiteral(resourceName: "good") //image literal と入力すると画像選択できるようになる
      likeImageView.alpha = 1
      likeImageView.tintColor = UIColor.red // 画像がtemplateimageになっていないと反映されないので注意！
    } else if xFromCenter < 0 {
      likeImageView.image = #imageLiteral(resourceName: "bad") //image literal と入力すると画像選択できるようになる
      likeImageView.alpha = 1
      likeImageView.tintColor = UIColor.blue // 画像がtemplateimageになっていないと反映されないので注意！
    }
    
    // スワイプの状態が指が離れたらということを表している
    if sender.state == UIGestureRecognizer.State.ended {
      if card.center.x < 75 { // 大きく左にスワイプ
        UIView.animate(withDuration: 0.2, animations: {
          card.center = CGPoint(x: card.center.x - 250, y:card.center.y)
        })
        return
      } else if card.center.x > self.view.frame.width - 75 { // 大きく右にスワイプ
        UIView.animate(withDuration: 0.2, animations: {
          card.center = CGPoint(x: card.center.x + 250, y:card.center.y)
        })
        return
      }
      
      // 0.2秒間かけて、クロージャ内にある動作を実行する（元に戻る）
      UIView.animate(withDuration: 0.2, animations: {
        card.center = self.centerOfCard // 中央に戻す
        card.transform = .identity // 角度を戻す
      })
      
      likeImageView.alpha = 0
    }
    
  }
}


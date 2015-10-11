//
//  ViewController.swift
//  Long
//
//  Created by xiaolei on 15/10/11.
//  Copyright © 2015年 xiaolei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//注册
    @IBAction func singUp(sender: AnyObject) {
        
        let singUpAlter = UIAlertController(title: "注册", message: nil, preferredStyle: .Alert)
        
        singUpAlter.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action:UIAlertAction) -> Void in
            
            let emil = singUpAlter.textFields![0].text
            let pwd1 = singUpAlter.textFields![1].text
            let pwd2 = singUpAlter.textFields![2].text
            
            if let email = emil , pd1 = pwd1 , pd2 = pwd2{
                
                self.singUp(email, pwd1: pd1, pwd2: pd2)
                
            }else{
                
                let ErrorAlert = UIAlertController(title: "ERROR", message: "不能为空", preferredStyle: UIAlertControllerStyle.Alert)
                ErrorAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                
                self.presentViewController(ErrorAlert, animated: true, completion: nil)
            }
            
        }))
        
        singUpAlter.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        singUpAlter.addTextFieldWithConfigurationHandler { (textfield:UITextField) -> Void in
            textfield.placeholder = "Email"
            textfield.keyboardType = UIKeyboardType.EmailAddress
        }
        
        singUpAlter.addTextFieldWithConfigurationHandler { (textfield:UITextField) -> Void in
            textfield.placeholder = "Password"
            textfield.secureTextEntry = true
        }
        
        singUpAlter.addTextFieldWithConfigurationHandler { (textfield:UITextField) -> Void in
            textfield.placeholder = "password Agin"
            textfield.secureTextEntry = true
        }
        
        self.presentViewController(singUpAlter, animated: true, completion: nil)
    }
  //登录
    @IBAction func longIn(sender: AnyObject) {
        
        let longInAlter = UIAlertController(title: "登录", message: nil, preferredStyle: .Alert)
        
        
        let okAction = UIAlertAction(title: "OK", style: .Default) { (action:UIAlertAction) -> Void in
            
            //获取都用户输入的用户名和密码
            let userName = longInAlter.textFields![0].text
            let password = longInAlter.textFields![1].text
            //首先判断是否为空
            if let username = userName,passWord = password{
                 self.longin(username, password: passWord)
            }else{
           
               let alter = UIAlertController(title: "ERROR", message: "用户名和密码不能为空", preferredStyle: UIAlertControllerStyle.Alert)
                alter.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alter, animated: true, completion: nil)
                
            }
        }
        
        
        
        longInAlter.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        
        
        longInAlter.addTextFieldWithConfigurationHandler { (textfield:UITextField) -> Void in
            textfield.placeholder = "Email"
            textfield.keyboardType = UIKeyboardType.EmailAddress
        }
        longInAlter.addTextFieldWithConfigurationHandler { (textfield:UITextField) -> Void in
            textfield.placeholder = "Password"
            textfield.secureTextEntry = true
        }
        
        longInAlter.addAction(okAction)
        
        presentViewController(longInAlter, animated: true, completion: nil)
    }
    
    func singUp(email:String,pwd1:String,pwd2:String){
        //检查用户名是否存在
        let uerDefaults = NSUserDefaults.standardUserDefaults()
        
        let username = uerDefaults.stringForKey("\(email)")
        
        guard let _ = username else{
           //注册的名字没有被占用
            
           //检查两次密码是否一致
            if pwd2 == pwd1{
                //存储信息
            uerDefaults.setValue(pwd1, forKey: email)
                //提示用户注册成功
                
                let alert = UIAlertController(title: "Sucess", message: "您以成功注册" , preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
                
            }else{
                
                let alert = UIAlertController(title: "ERROR", message: "密码不一致" , preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
            
            return
        }
        
        //用户名存在
        let alert = UIAlertController(title: "ERROR", message: "用户名\(email)存在" , preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
       
        
    }
    
    func longin(userName:String,password:String){
        
        //用户或者密码错误的提示信息
        
//        获取到存储的账户信息
        let uerDefaults = NSUserDefaults.standardUserDefaults()
        
        let username = uerDefaults.stringForKey("\(userName)")
        
        //如果不能过去到提供的用户名的密码则弹出警告
        guard let namePWD = username else{
            
            let errorAlter = UIAlertController(title: "ERROR", message: "用户名\(userName)不存在", preferredStyle: .Alert)
            errorAlter.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(errorAlter, animated: true, completion: nil)
            
            return
        }
        //如果有提供的用户名但是密码不正确，发出警告
        //密码错误
        guard password == namePWD else {
            
            let errorAlter = UIAlertController(title: "ERROR", message: "用户名\(userName)密码错误", preferredStyle: .Alert)
            
            errorAlter.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            self.presentViewController(errorAlter, animated: true, completion: nil)
            
            return
        }
        
        //如果密码和用户名都匹配成功之后则提示登录成功
        
        let errorAlter = UIAlertController(title: "Success", message: " 登录成功了！Si", preferredStyle: .Alert)
        
        errorAlter.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(errorAlter, animated: true, completion: nil)
        
        
    }
    



}


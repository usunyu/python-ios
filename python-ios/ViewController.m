//
//  ViewController.m
//  python-ios
//
//  Created by Yu Sun on 6/28/20.
//  Copyright © 2020 usunyu. All rights reserved.
//

#import "ViewController.h"
#import <Python/Python.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  
  NSString *bundlePath = [[NSBundle mainBundle] resourcePath];
  NSString *pythonHome = [NSString stringWithFormat:@"%@/Python.framework/Resources", bundlePath, nil];
  wchar_t *wpythonHome = Py_DecodeLocale([pythonHome UTF8String], NULL);
  
  Py_SetPythonHome(wpythonHome);
  
  Py_Initialize();
  NSLog(@"Initializing python runtime...");
  
  const char* version = Py_GetVersion();
  NSLog(@"%@", [NSString stringWithUTF8String:version]);
  
  NSString *scriptDir = [NSString stringWithFormat:@"%@/python", bundlePath, nil];
  wchar_t *wscriptDir = Py_DecodeLocale([scriptDir UTF8String], NULL);
  
  PySys_SetPath(wscriptDir);
  
  PyObject *moduleName = PyUnicode_FromString("sample");
  //PyObject *module = PyImport_ImportModule(moduleName);
  PyObject *module = PyImport_Import(moduleName);
  PyObject *funcName = PyUnicode_FromString("add");
  PyObject *addFunction = PyObject_GetAttr(module, funcName);
  //PyObject *addFunction = PyObject_GetAttrString(module, "add");
  
  double input1 = 4.2, input2 = 9.22;
  PyObject *ret = PyObject_CallFunction(addFunction, "dd", input1, input2);
  double result = PyFloat_AsDouble(ret);
  //NSLog([NSString stringWithFormat:@"%f", dresult]);
  
  Py_DECREF(moduleName);
  Py_DecRef(funcName);
  Py_DecRef(module);
  
  Py_Finalize();
  
  UILabel *pyLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 80, self.view.frame.size.height / 2 - 25, 160, 50)];
  pyLabel.text = [@"Python " stringByAppendingString: [NSString stringWithUTF8String:version]];
  [self.view addSubview:pyLabel];
  
  UILabel *retLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 80, self.view.frame.size.height / 2 + 25, 160, 50)];
  retLabel.text = [NSString stringWithFormat:@"%.2f + %.2f = %.2f", input1, input2, result, nil];
  //retLabel.text = [@"" stringByAppendingString: [NSString stringWithUTF8String:version]];
  [self.view addSubview:retLabel];
}


@end

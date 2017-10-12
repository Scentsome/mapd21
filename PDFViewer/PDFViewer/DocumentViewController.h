//
//  ViewController.h
//  PDFViewer
//
//  Created by Michael on 12/10/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import <UIKit/UIKit.h>
@import PDFKit;
@protocol DocumentViewControllerDelegate
-(void)didSaveDocument;
@end


@interface DocumentViewController : UIViewController
@property PDFDocument * document;
@property BOOL addAnnotations;
@property (weak, nonatomic) id <DocumentViewControllerDelegate> delegate;

@end


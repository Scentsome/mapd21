//
//  ViewController.m
//  PDFViewer
//
//  Created by Michael on 12/10/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "DocumentViewController.h"
#import "FSHelper.h"
@interface DocumentViewController ()
@property (weak, nonatomic) IBOutlet PDFView *pdfView;

@end

@implementation DocumentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pdfView.displayMode = kPDFDisplaySinglePageContinuous;
    self.pdfView.displaysPageBreaks = true;
    self.pdfView.autoScales = true;
    self.pdfView.document = self.document;
    if(self.addAnnotations){
        [self addContractAnnotations];
    }

}

-(void) addContractAnnotations{
    PDFPage * page = [self.document pageAtIndex:0];
    PDFRect pageBounds = [page boundsForBox:kPDFDisplayBoxCropBox];
    
    
    PDFRect checkBoxAgreeBounds = CGRectMake(75, pageBounds.size.height - 375, 18, 18);
    
    PDFAnnotation * checkBox = [[PDFAnnotation alloc] initWithBounds:checkBoxAgreeBounds
         forType:PDFAnnotationSubtypeWidget withProperties:nil];
    
    checkBox.widgetFieldType = PDFAnnotationWidgetSubtypeButton;
    checkBox.widgetControlType = kPDFWidgetCheckBoxControl;
    
    [page addAnnotation:checkBox];
    
    
    CGRect textFieldNameBounds = CGRectMake(128, pageBounds.size.height - 142, 230, 23);
    PDFAnnotation * textFieldName = [self textWidget:textFieldNameBounds fieldName:@"name"];
    [page addAnnotation:textFieldName];
    
    CGFloat buttonYOrigin = pageBounds.size.height - 285;
    NSString * buttonFieldName = @"WEEK";
    
    PDFAnnotation * sundayButton = [self radioButton:buttonFieldName startingState:@"Sun" bounds:CGRectMake(105, buttonYOrigin, 18, 18)];
    [page addAnnotation:sundayButton];
    
    PDFAnnotation * mondayButton = [self radioButton:buttonFieldName startingState:@"Mon" bounds:CGRectMake(160, buttonYOrigin, 18, 18)];
    [page addAnnotation:mondayButton];
    
    PDFAnnotation * tuesdayButton = [self radioButton:buttonFieldName startingState:@"Tue" bounds:CGRectMake(215, buttonYOrigin, 18, 18)];
    [page addAnnotation:tuesdayButton];
    
    PDFRect clearButtonBounds = CGRectMake(75, pageBounds.size.height - 450, 106, 32);
    
    PDFAnnotation * clearButton = [[PDFAnnotation alloc] initWithBounds:clearButtonBounds forType:PDFAnnotationSubtypeWidget withProperties:nil];
    clearButton.widgetFieldType = PDFAnnotationWidgetSubtypeButton;
    clearButton.widgetControlType = kPDFWidgetPushButtonControl;
    clearButton.caption = @"Clear";
    clearButton.fieldName = @"clearButton";
    [page addAnnotation:clearButton];
    
    PDFActionResetForm * resetFormAction = [PDFActionResetForm new];
    resetFormAction.fields = @[@"colaPrice", @"rrPrice", @"name"];
   resetFormAction.fieldsIncludedAreCleared = NO;
   clearButton.action = resetFormAction;
    
}

- (PDFAnnotation *) textWidget:(CGRect)bounds fieldName:(NSString *)fieldName {
    PDFAnnotation * textWidget = [[PDFAnnotation alloc] initWithBounds:bounds forType:PDFAnnotationSubtypeWidget withProperties:nil];
    textWidget.widgetFieldType = PDFAnnotationWidgetSubtypeText;
    textWidget.font = [UIFont systemFontOfSize:18];
    textWidget.fieldName = fieldName;
    return textWidget;
}

- (PDFAnnotation *) radioButton:(NSString *)fieldName startingState:(NSString *)startingState bounds:(CGRect)bounds {
    PDFAnnotation * radioButton = [[PDFAnnotation alloc] initWithBounds:bounds forType:PDFAnnotationSubtypeWidget withProperties:nil];
    radioButton.widgetFieldType = PDFAnnotationWidgetSubtypeButton;
    radioButton.widgetControlType = kPDFWidgetRadioButtonControl;
    radioButton.fieldName = fieldName;
    radioButton.buttonWidgetStateString = startingState;
    return radioButton;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)saveDocument:(id)sender {
    
    PDFPage * page = [self.document pageAtIndex:0];
    NSString * contracteeName;
    for (PDFAnnotation * annotation in page.annotations) {
        if ([annotation.fieldName isEqualToString: @"clearButton"]) {
            [page removeAnnotation:annotation];
        } else if ([annotation.fieldName isEqualToString: @"name"]) {
            contracteeName = [annotation valueForAnnotationKey:PDFAnnotationKeyWidgetValue];
        }
    }
    
    if (contracteeName != nil) {
        NSString * displayName = [contracteeName stringByReplacingOccurrencesOfString:@" " withString:@"_"];
        displayName = [NSString stringWithFormat:@"%@.pdf", displayName];
        NSURL * dirURL = [NSURL fileURLWithPath:[[FSHelper sharedObject] contractsDirectory]];
        NSURL * savePathURL = [dirURL URLByAppendingPathComponent:displayName];
        [self.document writeToFile:[NSString stringWithFormat:@"%@", savePathURL.path] withOptions:nil];
        [self.delegate didSaveDocument];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
//-(NSString *) contractsDirectory {
//
//    NSURL * contractsURL = [[NSURL fileURLWithPath:NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,   NSUserDomainMask, YES)[0]] URLByAppendingPathComponent:@"contracts"];
//
//    NSString * contractsPath = [NSString stringWithFormat:@"%@", contractsURL.path];
//    NSLog(@"%@",contractsURL.path);
//
//    if (![[NSFileManager defaultManager] fileExistsAtPath:contractsPath]) {
//
//        NSError * error;
//        [[NSFileManager defaultManager] createDirectoryAtPath:contractsPath withIntermediateDirectories:YES attributes:nil error:&error];
//        if(error) {
//            NSLog(@"Creating dir error %@",error);
//        }
//    }
//    return contractsPath;
//}

@end

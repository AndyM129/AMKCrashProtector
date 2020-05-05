//
//  AMKCrashProtectorConstants.m
//  AMKCategories
//
//  Created by 孟昕欣 on 2020/5/5.
//

#import "AMKCrashProtectorConstants.h"

#pragma mark - NSExceptionName

NSExceptionName const AMKCPUnrecognizedSelectorException = @"AMKCPUnrecognizedSelectorException";
NSExceptionName const AMKCPKeyValueObservingException = @"AMKCPKeyValueObservingException";
NSExceptionName const AMKCPKeyValueObservingNotHandledException = @"AMKCPKeyValueObservingNotHandledException";
NSExceptionName const AMKCPCircularReferenceException = @"AMKCPCircularReferenceException";

#pragma mark - AMKCPUploadInfoKey

AMKCPUploadInfoKey const AMKCPUploadViewHierarchyInfoKey = @"视图层级结构";
AMKCPUploadInfoKey const AMKCPUploadTargetInfoKey = @"被引用对象";

//
//  PatchLoader.m
//  PokemonGoHacking
//
//  Created by Kenneth Poon on 31/8/16.
//
//

#import "PatchLoader.h"
#import "PatchPGO-Swift.h"

@implementation PatchLoader

static void __attribute__((constructor)) initialize(void){
    NSLog(@"======================= dylib initialize ========================");
    
    [LocationSwizzler turnOnSwizzleForCoordinate];
    [LocationSwizzler turnOnSwizzleForDelegate];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        static PatchManager *patchManager;
        patchManager = [PatchManager new];
        [patchManager hijackAppWindow];

    });        


}

@end


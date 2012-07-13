//
//  SpeexKit.m
//  SpeexKit
//
//  Created by Ryan Wang on 7/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SpeexKit.h"

#define MAX_FRAME_BYTES 2000
#define MAX_FRAME_SIZE 2000

#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include <stdio.h>

#define NN 160

int test_main()
{
    short in[NN];
    int i;
    SpeexPreprocessState *st;
    int count=0;
    float f;
    
    st = speex_preprocess_state_init(NN, 8000);
    i=1;
    speex_preprocess_ctl(st, SPEEX_PREPROCESS_SET_DENOISE, &i);
    i=0;
    speex_preprocess_ctl(st, SPEEX_PREPROCESS_SET_AGC, &i);
    i=8000;
    speex_preprocess_ctl(st, SPEEX_PREPROCESS_SET_AGC_LEVEL, &i);
    i=0;
    speex_preprocess_ctl(st, SPEEX_PREPROCESS_SET_DEREVERB, &i);
    f=.0;
    speex_preprocess_ctl(st, SPEEX_PREPROCESS_SET_DEREVERB_DECAY, &f);
    f=.0;
    speex_preprocess_ctl(st, SPEEX_PREPROCESS_SET_DEREVERB_LEVEL, &f);
    while (1)
    {
        int vad;
        fread(in, sizeof(short), NN, stdin);
        if (feof(stdin))
            break;
        vad = speex_preprocess_run(st, in);
        /*fprintf (stderr, "%d\n", vad);*/
        fwrite(in, sizeof(short), NN, stdout);
        count++;
    }
    speex_preprocess_state_destroy(st);
    return 0;
}


@implementation SpeexKit

+ (void)testSpeekKit {
    NSLog(@"%d %s %s ",__LINE__,__FILE__,__PRETTY_FUNCTION__);
    test_main();
}
 
@end

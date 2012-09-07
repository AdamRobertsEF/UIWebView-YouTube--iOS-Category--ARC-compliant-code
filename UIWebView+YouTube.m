/*
 UIWebView+YouTube.m
 
 Created by Adam Roberts on 19/05/2012.
 Copyright (c) 2012 Enigmatic Flare Ltd. All rights reserved.
 http://www.enigmaticflare.com
 twitter:@enigmaticflare facebook/AdamRobertsEF
 
 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:
 
 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
 */


#import "UIWebView+YouTube.h"

@implementation UIWebView (YouTube)


-(NSString *)youTubeVideoURLFromVideoID:(NSString *)videoID{
    return [NSString stringWithFormat:@"http://youtube.com/v/%@",videoID];
}

-(NSString *)youTubeEmbedHTMLFromVideoID:(NSString *)videoID{

    NSString *htmlString = @"<html><head> <meta name = \"viewport\" content = \"initial-scale = 1.0, user-scalable = no, width = \"%f\"/></head> <body style=\"background:#000000;margin-top:0px;margin-left:0px\"> <iframe width= \"%f\" height=\"%f\" src = \"http://www.youtube.com/embed/%@?showinfo=0\" frameborder=\"0\" allowfullscreen></iframe></div></body></html>";
//    
//    NSString *htmlString = @"<html><head> <meta name = \"viewport\" content = \"initial-scale = 1.0, user-scalable = no, width = \"%f\"/></head> <body style=\"background:#000000;margin-top:0px;margin-left:0px\"> <div><object width=\"%f\" height=\"%f\"> <param name=\"movie\" value=\"%@\"></param> <param name=\"wmode\" value=\"transparent\"></param> <embed src=\"%@\" type=\"application/x-shockwave-flash\" wmode=\"transparent\" width=\"%f\" height=\"%f\"></embed> </object></div></body></html>";
       
    // Populate HTML with the URL and requested frame size
    NSString *html = [NSString stringWithFormat:htmlString,self.frame.size.width,self.frame.size.width,self.frame.size.height,videoID];

    //  #ifdef DEBUG
    NSLog(@"YouTube Embed HTML:%@",html);
    // #endif
    
    return html;     
    
}

-(void)loadYouTubeVideoID:(NSString*)videoID{
    
    self.scrollView.bounces = NO;
    self.scrollView.scrollEnabled = NO;
    
    NSString *fileName = [NSString stringWithFormat:@"youtubevideo%@.html",videoID];
    
    //set local path for file
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",
                                   [NSSearchPathForDirectoriesInDomains(
                                    NSCachesDirectory
                                    ,NSUserDomainMask, YES) objectAtIndex:0],
                                    fileName];
    
    NSData *data = [[self youTubeEmbedHTMLFromVideoID:videoID]
                    dataUsingEncoding:NSUTF8StringEncoding];
    
    //write data to file
    [data writeToFile:filePath atomically:YES];
    #ifdef DEBUG
        NSLog(@"WebView Category about to load from HTML file!");
    #endif
    [self loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: filePath]]];
}

@end

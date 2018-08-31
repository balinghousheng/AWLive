/*
 copyright 2016 wanghongyu.
 The project page：https://github.com/hardman/AWLive
 My blog page: http://www.jianshu.com/u/1240d2400ca1
 */

#import "AWSWX264Encoder.h"
#import "AWEncoderManager.h"

@implementation AWSWX264Encoder

// 对x264这个库的封装。
// 1、初始化x264参数，打开编码环境
// 2、进行编码
// 3、关闭编码环境。

//真正实现完整转码逻辑的是在 aw_sw_x264_encoder.h/aw_sw_x264_encoder.c 中。
//它实现了如下功能：
//1、将收到的yuv数据编码成 h264格式。
//2、生成包含sps/pps数据的flv视频帧。
//3、将h264格式的数据转成flv视频数据。
//4、关闭编码器。

// 第二步：开始编码
-(aw_flv_video_tag *) encodeYUVDataToFlvTag:(NSData *)yuvData{
    return aw_sw_encoder_encode_x264_data((int8_t *)yuvData.bytes, yuvData.length, self.manager.timestamp + 1);
}

-(aw_flv_video_tag *)createSpsPpsFlvTag{
    return aw_sw_encoder_create_x264_sps_pps_tag();
}

// 第一步：初始化x264参数，打开编码环境
-(void) open{
    aw_x264_config x264_config = self.videoConfig.x264Config;
    aw_sw_encoder_open_x264_encoder(&x264_config);
}

// 第三步：关闭编码环境。
-(void)close{
    aw_sw_encoder_close_x264_encoder();
}

@end

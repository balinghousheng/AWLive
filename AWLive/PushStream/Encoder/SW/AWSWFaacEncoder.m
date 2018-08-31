/*
 copyright 2016 wanghongyu.
 The project page：https://github.com/hardman/AWLive
 My blog page: http://www.jianshu.com/u/1240d2400ca1
 */

#import "AWSWFaacEncoder.h"
#import "AWEncoderManager.h"

@implementation AWSWFaacEncoder

// 第三步：将接收到的pcm数据转成aac数据，然后将aac数据转成flv音频数据
-(aw_flv_audio_tag *) encodePCMDataToFlvTag:(NSData *)pcmData{
    self.manager.timestamp += aw_sw_faac_encoder_max_input_sample_count() * 1000 / self.audioConfig.sampleRate;
    return aw_sw_encoder_encode_faac_data((int8_t *)pcmData.bytes, pcmData.length, self.manager.timestamp);
}

// 第二步：将audio specific config data 转成flv帧数据。
-(aw_flv_audio_tag *)createAudioSpecificConfigFlvTag{
    return aw_sw_encoder_create_faac_specific_config_tag();
}

// 第一步：开启编码器
-(void) open{
    aw_faac_config faac_config = self.audioConfig.faacConfig;
    aw_sw_encoder_open_faac_encoder(&faac_config);
}

// 第四步：关闭编码器
-(void)close{
    aw_sw_encoder_close_faac_encoder();
}
@end

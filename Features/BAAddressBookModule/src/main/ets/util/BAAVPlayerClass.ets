import { media } from '@kit.MediaKit'
import { Context } from '@kit.AbilityKit'

export class BAAVPlayerClass {
  static player: media.AVPlayer
  static context: Context

  static async init(context: Context) {
    BAAVPlayerClass.context = context
    //   初始化
    //   1.1创建播放器 ->  idle
    BAAVPlayerClass.player = await media.createAVPlayer()
    //   1.2监听状态
    BAAVPlayerClass.player.on('stateChange', (state) => {
      if (state === 'initialized') {
        BAAVPlayerClass.player.prepare() // prepared
      } else if (state === 'prepared') {
        BAAVPlayerClass.player.play() //playing
      } else if (state === 'completed') {
        BAAVPlayerClass.player.reset()
      }
    })
    //   1.3音频文件的时长
    BAAVPlayerClass.player.on('durationUpdate', (duration) => {
      // duration就是音频文件的时长，每次设置音频源的时候进行更新
      //   10000ms
    })
    //   1.4播放器的实时进度
    BAAVPlayerClass.player.on('timeUpdate', (time) => {
      //   time就是播放的时长，播放过程中大概几十毫秒更新一次
      // 1000ms
    })
    //   1.5控制播放的进度
    //   从3S开始播放
    // AVPlayerClass.player.seek(3000)
    //   播放/暂停/停止
    // AVPlayerClass.player.play()
    // AVPlayerClass.player.pause()
    // AVPlayerClass.player.stop()


  }

  static async play(src:fdSrc ) {
    // 2.1设置播放源（在线） -> initialized
    // AVPlayerClass.player.url = 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/5.mp3'
    // 2.2设置播放源(本地)   -> initialized
    // 将之前没有播完的取消
    await BAAVPlayerClass.player.reset()
    // 重新播放新的
    // 宏任务  和  微任务 谁先执行？
    const fileDescriptor = BAAVPlayerClass.context.resourceManager.getRawFdSync(src + '.wav')
    BAAVPlayerClass.player.fdSrc = fileDescriptor
  }

  // static pause
  // static stop
  // static release
}
// 自定义类型
type fdSrc = 'camera' | 'information' | 'send'

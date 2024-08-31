import { KeyboardAvoidMode, router, window } from '@kit.ArkUI'
import { BAMessageInfo, BAMessageInfoModel, BAMessageTypeEnum } from '../../viewmodel/BAMessageViewModel'
import { currentUser, UserInfo } from '../../viewmodel/user'
import { BAAudioRender } from '../../util/BAAudioRender'
import { BAAVPlayerClass } from '../../util/BAAVPlayerClass'
import { requestMessage } from '../../util/BARequest'
import { BAStoreClass } from '../../util/BAStoreClass'

import BottomInput from './BABottomInput'
import Message from './BAMessage'
import PreviewImage from './BAPreviewImage'
import { abilityAccessCtrl, common } from '@kit.AbilityKit'
import { BAAddressBookItem } from '../../viewmodel/BAAddressBookViewModel'

@Component
struct BAChatDetail {
  @State
  talker: UserInfo = {} as UserInfo // 当前用户信息
  @State
  messageList: BAMessageInfoModel[] = [] // 当前用户聊天记录
  @State
  isInputting: boolean = false // 对方是否正在输入

  // 预览的地址
  previewUrl: string = ''
  type: 'img' | 'video' = 'img'
  // 初始化：预览的弹层
  previewController: CustomDialogController = new CustomDialogController({
    builder: PreviewImage({
      url: this.previewUrl,
      type: this.type
    }),
    autoCancel: false,
    customStyle: true
  })
  // 列表滚动控制器
  scroller: Scroller = new Scroller()

  // // 预览图片(打开弹层)
  // previewImage(){
  //   this.previewController.open()
  // }


  async aboutToAppear() {
    const windowStage_ = AppStorage.get('windowStage') as window.WindowStage;
    if (windowStage_ == null) {
      console.error('Failed to create the subwindow. Cause: windowStage_ is null');
    } else {
      // 键盘避让
      windowStage_.getMainWindowSync().getUIContext().setKeyboardAvoidMode(KeyboardAvoidMode.RESIZE)
    }
    // this.talker = router.getParams() as UserInfo
    // this.talker = {
    //   username: '小趴菜',
    //   avatar: 'https://img2.baidu.com/it/u=2778471297,524433918&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500',
    //   user_id: '1'
    // }
    const  addressBook = AppStorage.get('addressBook') as BAAddressBookItem
    this.talker = {
      username: addressBook.name,
      avatar: addressBook.icon as string,
      user_id: addressBook.id.toString()
    }
    this.messageList = BAStoreClass.getChatMessage(this.talker.user_id)

  }

  // 发送文本消息
  async sendTextMsg(message: string) {
    //   准备消息对象
    const newMessage = new BAMessageInfoModel({
      messageContent: message,
      sendUser: currentUser,
      connectUser: this.talker
    } as BAMessageInfo)
    //   加入消息列表中(视图上添加)
    this.messageList.push(newMessage)
    //   持久化
    await BAStoreClass.addChatMessage(this.talker.user_id, newMessage)
    // 滚动到底部
    this.scroller.scrollEdge(Edge.Bottom)
    //  获取消息结果
    this.getResponseMessage(message)
    //   音乐的播放
    BAAVPlayerClass.play('send')
  }

  // 发送语音消息
  async sendAudioMsg(filePath: string, duration: number) {
    const newMessage = new BAMessageInfoModel({
      messageContent: `[语音] ${duration}"`,
      sendUser: currentUser,
      connectUser: this.talker,
      messageType: BAMessageTypeEnum.AUDIO,
      sourceFilePath: filePath,
      sourceDuration: duration
    } as BAMessageInfo)
    //   加入消息列表中(视图上添加)
    this.messageList.push(newMessage)
    //   持久化
    await BAStoreClass.addChatMessage(this.talker.user_id, newMessage)
    // 滚动到底部
    this.scroller.scrollEdge(Edge.Bottom)
  }

  // 发送图片消息
  sendImageMsg(imgList: BAMessageInfoModel[]) {
    // ...可以用，但是只能给数组用
    this.messageList.push(...imgList)
    //   持久化
    imgList.forEach(async (newMessage) => {
      await BAStoreClass.addChatMessage(this.talker.user_id, newMessage)
    })
    // 滚动到底部
    setTimeout(() => {
      this.scroller.scrollEdge(Edge.Bottom)
    }, 30)
    //   音乐的播放
    BAAVPlayerClass.play('send')
  }

  // 接收文本消息
  async getResponseMessage(message: string) {
    this.isInputting = true
    const result = await requestMessage(message)
    // result.data.info.text
    //   准备消息对象
    const newMessage = new BAMessageInfoModel({
      messageContent: result.data.info.text,
      // 后续数据持久化有关系
      sendUser: this.talker,
      // 这条消息是我跟谁聊得(归属者)
      // 判断这条消息的归属！！！
      connectUser: this.talker
    } as BAMessageInfo)
    //   加入消息列表中(视图上添加）
    this.messageList.push(newMessage)
    //   持久化
    await BAStoreClass.addChatMessage(this.talker.user_id, newMessage)


    this.isInputting = false

    BAAVPlayerClass.play('information')

    // 滚动到底部
    setTimeout(() => {
      this.scroller.scrollEdge(Edge.Bottom)
    }, 30)
  }

  // 删除UI页面消息
  delMessage(messageId: string) {
    const index = this.messageList.findIndex(message => message.id === messageId)
    this.messageList.splice(index, 1)
  }

  // 全屏模态实现思路：预览图片
  // @Provide
  // showImageInfo:boolean = false
  // @Provide
  // previewImageUrl:string = ''
  // @Builder
  // getImageInfo(){
  //    Column(){
  //      Image(this.previewImageUrl)
  //        .width('100%')
  //    }.width('100%')
  //   .height('100%')
  //   .backgroundColor('#000')
  //   .justifyContent(FlexAlign.Center)
  // }


  build() {
    Column() {
      // 标题
      // Row() {
      //   // Stack({ alignContent: Alignment.Start }) {
      //   //   Text(this.isInputting ? '对方正在输入' : this.talker.username)
      //   //     .width('100%')
      //   //     .textAlign(TextAlign.Center)
      //   //     .fontSize(16)
      //   //     .fontColor($r('app.color.text_primary'))
      //   //   Image($r('app.media.ic_public_arrow_left'))
      //   //     .width(30)
      //   //     .height(30)
      //   //     .onClick(() => {
      //   //       router.back()
      //   //     })
      //   // }
      //   // .height(50)
      // }
      // .padding({
      //   left: 10,
      //   right: 10
      // })

      //   聊天内容
      List({ space: 16, scroller: this.scroller }) {
        ForEach(this.messageList, (message: BAMessageInfoModel) => {
          Message({
            message,
            delMessage: (messageId: string) => {
              this.delMessage(messageId)
            },
            previewImage: () => {
              // 1.设置预览地址
              this.previewUrl = message.sourceFilePath
              // -----判断是图片还是视频
              this.type = message.messageType === BAMessageTypeEnum.IMAGE ? 'img' : 'video'
              // 2.打开预览
              this.previewController.open()
            }
          })
        })
      }
      .layoutWeight(1)
      .backgroundColor($r('app.color.back_color'))
      .padding({
        top: 20
      })

      //   聊天框
      BottomInput({
        sendTextMsg: (message) => {
          this.sendTextMsg(message)
        },
        sendAudioMsg: (filePath, duration) => {
          this.sendAudioMsg(filePath, duration)
        },
        sendImageMsg: (imgList) => {
          this.sendImageMsg(imgList)
        },
        talker: this.talker
      })
    }
    .height('100%')

    // 全屏模态实现思路：
    // .bindContentCover(this.showImageInfo,this.getImageInfo,{
    //   modalTransition:ModalTransition.NONE
    // })
  }
}

export default BAChatDetail
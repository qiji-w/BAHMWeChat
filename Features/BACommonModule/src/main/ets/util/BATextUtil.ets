import measure from '@ohos.measure';

export class BATextUtil {
  //code

  //计算文本高度
  static getTextSize(content: string | Resource, width: number, fontSize: number, maxLines?: number): SizeOptions {
    return measure.measureTextSize({
      textContent: content,
      constraintWidth: width,
      fontSize: fontSize,
      maxLines: maxLines
    })
  }
}
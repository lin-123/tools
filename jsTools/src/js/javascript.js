/*********** 取整 *************/
/**
 * 方法一、
 * ~~运算符
 *    作用： 按位取反再取反。 看似没作用，但是可以将浮点数转换乘整数
 */
function tildeOperation() {
  console.log(~~1.1 === 1)
  console.log(~~-0.1 === 0)
}

/**
 * 按位或运算
 * @return {[type]} [description]
 */
function orByBit() {
  // 应用： 取整
  console.log(1.1 | 0)
}

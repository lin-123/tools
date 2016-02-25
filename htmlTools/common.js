// 返回每个代码块的局部 document对象， 就是包裹此代码快的 div元素
window.utils = {
  getPartDocument: function(id){
    return document.getElementById(id)
  },
  appendElement: function(targetId, position, message){
    var str = "<p class='log'>"+message+"</p>"
    document.getElementById(targetId).insertAdjacentHTML('afterEnd', str)
  }
}

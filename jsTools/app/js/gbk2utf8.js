// 'userName',
// '=    =   ++      " " +++       " " ，         哈哈'
// "%3D%3D%2B%2B+%2B%2B%2B+%A3%AC%B9%FE%B9%FE"


// 预      " " 测     " " +   看     ++      " "" "" "
// "%D4%A4  +   %B2%E2 +  %2B %BF%B4 %2B%2B  +++


//   'title','K+ +线 ++预++ +测', "K%2B+%2B%CF%DF+%2B%2B%D4%A4%2B%2B+%2B%B2%E2"

//     'userName', '1+1 = 2，哈哈', "1 %2B 1 + %3D + 2%A3%AC%B9%FE%B9%FE"
//     'content', '预 测 +看++ 跌',
//     'title','
// K+ +线 ++预+++测
// K %2B +   %2B %CF%DF +   %2B%2B %D4%A4 %2B%2B+%2B%B2%E2

// ,"":"%D4%A4+%B2%E2+%2B%BF%B4%2B%2B+%B5%F8","title":"

var iconv = require('iconv-lite')

var str = "K+++%2B+%2B%CF%DF+%2B%2B%D4%A4%2B%2B+%2B%B2%E2"
str = "K%2B+%2B%CF%DF+%2B%2B%D4%A4%2B%2B+%2B%B2%E2"
str = "%3D%3D%2B%2B+%2B%2B%2B+%A3%AC%B9%FE%B9%FE"
// var gbk = iconv.encode(str, 'gbk');
// debugger


console.log(gbkDecode(str))


function gbkDecode(gbkStr){
  var arr = gbkStr.split('%')
    , buffArr = []

  var str2buf = function(str, bufArr){
    for(var i = 0; i<str.length; i++){
      str[i] == '+'? bufArr.push('0x20'):buffArr.push('0x' + str.charCodeAt(i).toString(16))
      // if(str[i] == '+') continue;
      // buffArr.push('0x' + str.charCodeAt(i).toString(16))
    }
  }

  arr.map(function(item, index){
    if(index == 0) return str2buf(item, buffArr);
    if(item.slice(0, 2) === '20') return;
    buffArr.push('0x' + item.slice(0, 2).toLowerCase())
    str2buf(item.slice(2), buffArr)
  })

  // var buf = new Buffer(buffArr);
  // var utf8 = iconv.decode( buf, 'gbk');

  return iconv.decode( new Buffer(buffArr), 'gbk')
}
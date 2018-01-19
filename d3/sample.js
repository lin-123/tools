var fourCol = {
  "_id": "5a587ad29400001204fd3674",
  "queries": [{
    "query_id": "5a5dab4209cc31000bcc1bc7",
    "type": "bar",
    "color": "#fa0733",
    "index": 1,
    "nickname": "多方"
  }, {
    "query_id": "5a5daf8209cc31000bcc1bc9",
    "type": "bar",
    "color": "#0d95e0",
    "index": 1,
    "nickname": "空方"
  }],
  "config": {
    "chart": {
      "type": "multiBarChart",
      "margin": {
        "top": 30,
        "right": 40,
        "bottom": 40,
        "left": 55
      },
      "noData": "无数据",
      "duration": 500,
      "useInteractiveGuideline": true,
      "interactive": true,
      "tooltips": true,
      "stacked": true,
      "showControls": true,
      "showValues": true,
      "valueFormat": "function(d) {if(isNaN(d)){return d} var unit = \"\" , num = 1; if((d > 1000000000000) || (d < -1000000000000)){ d = d/1000000000000; num = 1; unit = \"万亿\"} else if((d > 10000000) || (d < -10000000)){ d = d/100000000; unit = \"亿\";  num = 1; }else if((d >= 10000) || (d <= -10000)){ d= d/10000;unit = \"万\"; num = 1; } var flag=\"\"; if(d<0){flag=\"-\" ;d=d*-1;}  if(parseInt(d) == d){num = 0;} d = parseFloat(d).toFixed(num) ; if(d < 0) {}var l = d.split(\".\")[0].split(\"\").reverse(),r = d.split(\".\")[1] || \"\"; var t = \"\"; for(i = 0; i < l.length; i++){t += l[i] + ((i + 1) % 3 == 0 && (i + 1) != l.length ? \",\" : \"\");} return flag + t.split(\"\").reverse().join(\"\") + (r.length > 0?(\".\"+r):r) + unit;}",
      "xAxis": {},
      "yAxis": {
        "showMaxMin": false,
        "tickFormat": "function(d) {if(isNaN(d)){return d} var unit = \"\" , num = 1; if((d > 1000000000000) || (d < -1000000000000)){ d = d/1000000000000; num = 1; unit = \"万亿\"} else if((d > 10000000) || (d < -10000000)){ d = d/100000000; unit = \"亿\";  num = 1; }else if((d >= 10000) || (d <= -10000)){ d= d/10000;unit = \"万\"; num = 1; } var flag=\"\"; if(d<0){flag=\"-\" ;d=d*-1;}  if(parseInt(d) == d){num = 0;} d = parseFloat(d).toFixed(num) ; if(d < 0) {}var l = d.split(\".\")[0].split(\"\").reverse(),r = d.split(\".\")[1] || \"\"; var t = \"\"; for(i = 0; i < l.length; i++){t += l[i] + ((i + 1) % 3 == 0 && (i + 1) != l.length ? \",\" : \"\");} return flag + t.split(\"\").reverse().join(\"\") + (r.length > 0?(\".\"+r):r) + unit;}"
      },
      "period": "分"
    }
  },
  "widget_id": "5a587ac49400009803fd3673",
  "data": [{
    "key": "多方",
    "color": "#fa0733",
    "values": [{
      "x": "白银",
      "y": 5.81
    }, {
      "x": "焦煤",
      "y": 7.74
    }, {
      "x": "螺纹",
      "y": 7.63
    }, {
      "x": "沥青",
      "y": 0
    }, {
      "x": "焦炭",
      "y": 19.77
    }],
    "type": "bar",
    "yAxis": 1
  }, {
    "key": "空方",
    "color": "#0d95e0",
    "values": [{
      "x": "白银",
      "y": 0
    }, {
      "x": "焦煤",
      "y": 7.67
    }, {
      "x": "螺纹",
      "y": 7.63
    }, {
      "x": "沥青",
      "y": 2.77
    }, {
      "x": "焦炭",
      "y": 0
    }],
    "type": "bar",
    "yAxis": 1
  }]
}


var twoCol = {
  "_id": "5a5c0846940000e505fd3681",
  "queries": [{
    "query_id": "5a5dab4209cc31000bcc1bc7",
    "type": "bar",
    "color": "#fa0202",
    "index": 0,
    "nickname": "多头"
  }, {
    "query_id": "5a5daf8209cc31000bcc1bc9",
    "type": "bar",
    "color": "#1ef241",
    "index": 1,
    "nickname": "空头",
    "accumulate": false
  }, {
    "query_id": "5a5dfebe09cc31000bcc1bcb",
    "type": "bar",
    "color": "#f7acbe",
    "index": 2,
    "nickname": "多(10分钟前)"
  }, {
    "query_id": "5a5dff2409cc31000bcc1bcd",
    "type": "bar",
    "color": "#b5f7d8",
    "index": 3,
    "nickname": "空(10分钟前)"
  }],
  "config": {
    "chart": {
      "type": "multiBarChart",
      "margin": {
        "top": 30,
        "right": 40,
        "bottom": 40,
        "left": 55
      },
      "noData": "无数据",
      "duration": 500,
      "useInteractiveGuideline": true,
      "interactive": true,
      "tooltips": true,
      "stacked": true,
      "showControls": true,
      "showValues": true,
      "valueFormat": "function(d) {if(isNaN(d)){return d} var unit = \"\" , num = 1; if((d > 1000000000000) || (d < -1000000000000)){ d = d/1000000000000; num = 1; unit = \"万亿\"} else if((d > 10000000) || (d < -10000000)){ d = d/100000000; unit = \"亿\";  num = 1; }else if((d >= 10000) || (d <= -10000)){ d= d/10000;unit = \"万\"; num = 1; } var flag=\"\"; if(d<0){flag=\"-\" ;d=d*-1;}  if(parseInt(d) == d){num = 0;} d = parseFloat(d).toFixed(num) ; if(d < 0) {}var l = d.split(\".\")[0].split(\"\").reverse(),r = d.split(\".\")[1] || \"\"; var t = \"\"; for(i = 0; i < l.length; i++){t += l[i] + ((i + 1) % 3 == 0 && (i + 1) != l.length ? \",\" : \"\");} return flag + t.split(\"\").reverse().join(\"\") + (r.length > 0?(\".\"+r):r) + unit;}",
      "xAxis": {},
      "yAxis": {
        "showMaxMin": false,
        "tickFormat": "function(d) {if(isNaN(d)){return d} var unit = \"\" , num = 1; if((d > 1000000000000) || (d < -1000000000000)){ d = d/1000000000000; num = 1; unit = \"万亿\"} else if((d > 10000000) || (d < -10000000)){ d = d/100000000; unit = \"亿\";  num = 1; }else if((d >= 10000) || (d <= -10000)){ d= d/10000;unit = \"万\"; num = 1; } var flag=\"\"; if(d<0){flag=\"-\" ;d=d*-1;}  if(parseInt(d) == d){num = 0;} d = parseFloat(d).toFixed(num) ; if(d < 0) {}var l = d.split(\".\")[0].split(\"\").reverse(),r = d.split(\".\")[1] || \"\"; var t = \"\"; for(i = 0; i < l.length; i++){t += l[i] + ((i + 1) % 3 == 0 && (i + 1) != l.length ? \",\" : \"\");} return flag + t.split(\"\").reverse().join(\"\") + (r.length > 0?(\".\"+r):r) + unit;}"
      },
      "period": "日"
    }
  },
  "widget_id": "5a5c0830940000b605fd3680",
  "data": [{
    "key": "多头",
    "color": "#fa0202",
    "values": [{
      "x": "白银",
      "y": 5.81
    }, {
      "x": "焦煤",
      "y": 7.74
    }, {
      "x": "螺纹",
      "y": 7.63
    }, {
      "x": "沥青",
      "y": 0
    }, {
      "x": "焦炭",
      "y": 19.77
    }],
    "type": "bar",
    "yAxis": 1
  }, {
    "key": "空头",
    "color": "#1ef241",
    "values": [{
      "x": "白银",
      "y": 0
    }, {
      "x": "焦煤",
      "y": 7.67
    }, {
      "x": "螺纹",
      "y": 7.63
    }, {
      "x": "沥青",
      "y": 2.77
    }, {
      "x": "焦炭",
      "y": 0
    }],
    "type": "bar",
    "yAxis": 1
  }, {
    "key": "多(10分钟前)",
    "color": "#f7acbe",
    "values": [{
      "x": "白银",
      "y": 5.81
    }, {
      "x": "焦煤",
      "y": 0
    }, {
      "x": "螺纹",
      "y": 7.63
    }, {
      "x": "沥青",
      "y": 0
    }, {
      "x": "焦炭",
      "y": 19.77
    }],
    "type": "bar",
    "yAxis": 1
  }, {
    "key": "空(10分钟前)",
    "color": "#b5f7d8",
    "values": [{
      "x": "白银",
      "y": 0
    }, {
      "x": "焦煤",
      "y": 7.67
    }, {
      "x": "螺纹",
      "y": 7.63
    }, {
      "x": "沥青",
      "y": 2.77
    }, {
      "x": "焦炭",
      "y": 0
    }],
    "type": "bar",
    "yAxis": 1
  }]
}
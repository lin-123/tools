<template>
<h1>home vue</h1>
<p>asdfasdf</p>
<div class="content">
  <h1>发短信， 打电话</h1>
  <div class="content">
    <a href="sms:18655352869">
      发短信
    </a>
    <p>
      <a href="tel:18655352869">打电话</a>
    </p>
  </div>

  <p>list 1</p>
  <ul class="content">
  	<li v-for='num in list' transition="expand" class=#{{num}}>
  		hello_#{{num}}
  	</li>
  </ul>


  <p>list 2</p>
  <ul class="content">
  	<li v-for='num in list2' transition="expand" class=#{{num}}>
  		hello_#{{num}}
  	</li>
  </ul>
</div>
</template>

<script type="text/javascript">
module.exports = {
	data: function(){
		return {
			count: 1,
			listWhole: [0,1,2,3,4,5],
			list: [-1],
			list2: [0]
		}
	},

	ready: function(){
		var self = this
		setInterval(function(){
			self.list[0] = self.listWhole[++self.count%5]

			self.list2.push(self.count)
			// self.list2.shift()
			setTimeout(function(){self.list2.shift()}, 50)

		}, 2000)
	}
}
</script>

<style lang="stylus">
	/* 必需 */
.expand-transition {
  transition: all 1s ease;
  height: 30px;
  padding: 10px;
  background-color: #eee;
  overflow: hidden;
}

/* .expand-enter 定义进入的开始状态 */
/* .expand-leave 定义离开的结束状态 */
.expand-enter, .expand-leave {
  height: 0;
  padding: 0 10px;
  opacity: 0;
}

</style>
